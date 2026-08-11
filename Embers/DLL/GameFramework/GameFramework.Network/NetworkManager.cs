using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Runtime.ExceptionServices;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using UnityEngine;

namespace GameFramework.Network;

internal sealed class NetworkManager : GameFrameworkModule, INetworkManager
{
	private abstract class NetworkChannelBase : INetworkChannel, IDisposable
	{
		public const int RECEIVE_BUFFER_SIZE = 8192;

		public const int SEND_BUFFER_SIZE = 8192;

		private const float DefaultHeartBeatInterval = 30f;

		protected const int DEFAULT_TIMEOUT = 5000;

		private readonly string m_Name;

		protected int timeoutMilliseconds;

		protected readonly INetworkChannelHelper m_NetworkChannelHelper;

		protected string hostname;

		protected int port;

		protected int connTimeoutMilliseconds;

		protected bool connected;

		protected readonly SemaphoreSlim connectLock = new SemaphoreSlim(1, 1);

		protected readonly ConcurrentDictionary<IRequest, RequestTaskTimeoutOrCompletionSource> promises = new ConcurrentDictionary<IRequest, RequestTaskTimeoutOrCompletionSource>();

		protected readonly ConcurrentStack<IMessage> messages = new ConcurrentStack<IMessage>();

		protected readonly ConcurrentStack<IMessage> notifications = new ConcurrentStack<IMessage>();

		protected readonly NetworkSubject<EventArgs> eventArgsSubject = new NetworkSubject<EventArgs>();

		protected readonly NetworkSubject<INotification> notificationSubject = new NetworkSubject<INotification>();

		protected ConnectionState state = ConnectionState.Closed;

		protected readonly object stateLock = new object();

		protected readonly object readLock = new object();

		protected CancellationTokenSource receiveTokenSource;

		protected CancellationTokenSource readTokenSource;

		protected CancellationTokenSource shutdownTokenSource;

		protected CancellationToken shutdownCancellationToken;

		protected IdleStateMonitor idleStateMonitor;

		private bool m_Disposed;

		public string Name => m_Name;

		public ServiceType ServiceType => ServiceType.Tcp;

		public virtual bool Connected
		{
			get
			{
				if (!connected)
				{
					return false;
				}
				if (State == ConnectionState.Connected)
				{
					return true;
				}
				return false;
			}
		}

		public virtual ConnectionState State
		{
			get
			{
				return state;
			}
			protected set
			{
				lock (stateLock)
				{
					if (state != value)
					{
						Debug.Log($"网络状态修改 : {value}");
						ConnectionState oldState = state;
						state = value;
						OnStateChanged(oldState, value);
					}
				}
			}
		}

		public bool IsBigEndian { get; set; }

		public bool NoDelay { get; set; }

		public int ReceiveBufferSize { get; set; }

		public int SendBufferSize { get; set; }

		public virtual bool AutoReconnect { get; set; }

		public virtual int TimeoutMilliseconds
		{
			get
			{
				return timeoutMilliseconds;
			}
			set
			{
				timeoutMilliseconds = Math.Max(value, 5000);
			}
		}

		public NetworkChannelBase(string name, INetworkChannelHelper networkChannelHelper, bool isBigEndian)
		{
			m_Name = name ?? string.Empty;
			m_NetworkChannelHelper = networkChannelHelper;
			m_Disposed = false;
			NoDelay = true;
			IsBigEndian = isBigEndian;
			idleStateMonitor = new IdleStateMonitor(TimeSpan.FromSeconds(30.0));
			idleStateMonitor.IdleStateChanged += OnIdleStateChanged;
			ReceiveBufferSize = 8192;
			SendBufferSize = 8192;
			networkChannelHelper.Initialize(this);
		}

		public INetworkSubscription<EventArgs> Events()
		{
			return eventArgsSubject.Subscribe();
		}

		public INetworkSubscription<INotification> Received()
		{
			return notificationSubject.Subscribe();
		}

		public INetworkSubscription<INotification> Received(Predicate<INotification> filter)
		{
			return notificationSubject.Subscribe(filter);
		}

		public virtual void Update(float elapseSeconds, float realElapseSeconds)
		{
		}

		protected virtual async void DoTick()
		{
			while (!shutdownCancellationToken.IsCancellationRequested)
			{
				try
				{
					foreach (KeyValuePair<IRequest, RequestTaskTimeoutOrCompletionSource> kv in promises)
					{
						IRequest request = kv.Key;
						RequestTaskTimeoutOrCompletionSource promise = kv.Value;
						RequestTaskTimeoutOrCompletionSource value;
						if (promise.IsCanceled)
						{
							promise.TrySetCanceled();
							promises.TryRemove(request, out value);
						}
						if (!promise.IsComplete && promise.IsTimeout)
						{
							promise.TrySetTimeout();
							promises.TryRemove(request, out value);
						}
					}
				}
				catch (Exception)
				{
				}
				try
				{
					await Task.Delay(timeoutMilliseconds / 2, shutdownCancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				}
				catch (Exception)
				{
				}
			}
		}

		protected virtual void OnStateChanged(ConnectionState oldState, ConnectionState newState)
		{
		}

		public Task Connect(string hostname, int port, int timeoutMilliseconds)
		{
			return Connect(hostname, port, timeoutMilliseconds, CancellationToken.None);
		}

		public async Task Connect(string hostname, int port, int timeoutMilliseconds, CancellationToken cancellationToken)
		{
			ValidateDisposed();
			if (timeoutMilliseconds <= 0)
			{
				timeoutMilliseconds = 5000;
			}
			if (!(await connectLock.WaitAsync(timeoutMilliseconds, cancellationToken).ConfigureAwait(continueOnCapturedContext: false)))
			{
				throw new TimeoutException();
			}
			CancellationTokenSource connectionTokenSource = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken);
			try
			{
				Init();
				await DoDisconnect().ConfigureAwait(continueOnCapturedContext: false);
				State = ConnectionState.Connecting;
				eventArgsSubject.Publish(ConnectionEventArgs.ConnectingEventArgs);
				this.hostname = hostname;
				this.port = port;
				connTimeoutMilliseconds = timeoutMilliseconds;
				connectionTokenSource.CancelAfter(connTimeoutMilliseconds);
				CancellationToken connectionToken = connectionTokenSource.Token;
				connectionToken.Register(delegate
				{
					if (State == ConnectionState.Connecting)
					{
						Close();
					}
				});
				await DoConnect(connectionToken).ConfigureAwait(continueOnCapturedContext: false);
				State = ConnectionState.Connected;
				connectionTokenSource.Dispose();
				eventArgsSubject.Publish(ConnectionEventArgs.ConnectedEventArgs);
			}
			catch (Exception ex)
			{
				await DoDisconnect().ConfigureAwait(continueOnCapturedContext: false);
				State = ConnectionState.Exception;
				eventArgsSubject.Publish(ConnectionEventArgs.FailedEventArgs);
				if (!(ex is Exception source))
				{
					throw ex;
				}
				ExceptionDispatchInfo.Capture(source).Throw();
			}
			finally
			{
				connectionTokenSource.Dispose();
				connectLock.Release();
			}
		}

		protected virtual async Task DoConnect(CancellationToken cancellationToken)
		{
			try
			{
				await DoConnect(hostname, port, connTimeoutMilliseconds, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				cancellationToken.ThrowIfCancellationRequested();
				OnConnected();
				cancellationToken.ThrowIfCancellationRequested();
				messages.Clear();
				notifications.Clear();
				receiveTokenSource = new CancellationTokenSource();
				readTokenSource = new CancellationTokenSource();
				Task.Factory.StartNew(DoReceived, CancellationToken.None, TaskCreationOptions.LongRunning, TaskScheduler.Default);
				Read();
			}
			catch (Exception ex)
			{
				Exception e = ex;
				if (receiveTokenSource != null)
				{
					receiveTokenSource.Cancel();
					receiveTokenSource = null;
				}
				if (readTokenSource != null)
				{
					readTokenSource.Cancel();
					readTokenSource = null;
				}
				throw e;
			}
		}

		protected abstract Task DoConnect(string hostname, int port, int timeoutMilliseconds, CancellationToken cancellationToken);

		protected virtual void OnConnected()
		{
			idleStateMonitor?.OnConnected();
		}

		protected virtual void Init()
		{
			if (shutdownTokenSource == null)
			{
				shutdownTokenSource = new CancellationTokenSource();
				shutdownCancellationToken = shutdownTokenSource.Token;
				if (timeoutMilliseconds <= 0)
				{
					timeoutMilliseconds = 5000;
				}
				Task.Factory.StartNew(DoTick, shutdownCancellationToken, TaskCreationOptions.LongRunning, TaskScheduler.Default);
			}
		}

		protected virtual void OnIdleStateChanged(object sender, IdleStateEventArgs e)
		{
			if (eventArgsSubject != null)
			{
				eventArgsSubject.Publish(e);
			}
		}

		protected virtual async Task<Stream> WrapStream(Stream stream)
		{
			return stream;
		}

		protected void Read()
		{
			if (!connected || readTokenSource == null)
			{
				return;
			}
			CancellationToken token = readTokenSource.Token;
			ReadAsync().ContinueWith((Func<Task<IMessage>, Task>)async delegate(Task<IMessage> t)
			{
				if (!token.IsCancellationRequested)
				{
					if (!t.IsFaulted && !t.IsCanceled)
					{
						OnRead(t.Result);
						Read();
						lock (readLock)
						{
							Monitor.PulseAll(readLock);
						}
					}
					else
					{
						Debug.Log($"读取线程错误. 当前状态 = {State}");
						if (State == ConnectionState.Connected)
						{
							await DoDisconnect();
							if (State == ConnectionState.Connected)
							{
								if (!AutoReconnect)
								{
									State = ConnectionState.Exception;
									eventArgsSubject.Publish(ConnectionEventArgs.ExceptionEventArgs);
								}
								else
								{
									await Reconnect(autoReconnect: true, CancellationToken.None);
								}
							}
						}
					}
				}
			}, token, TaskContinuationOptions.ExecuteSynchronously, TaskScheduler.Default);
		}

		protected void OnRead(IMessage message)
		{
			if (message is IResponse response)
			{
				foreach (IRequest key in promises.Keys)
				{
					if (key.RpcId == response.RpcId)
					{
						if (promises.TryGetValue(key, out RequestTaskTimeoutOrCompletionSource value) && value != null)
						{
							value.Result = response;
						}
						break;
					}
				}
				messages.Push(message);
			}
			else
			{
				notifications.Push(message);
			}
		}

		protected void DoReceived()
		{
			CancellationToken token = receiveTokenSource.Token;
			while (true)
			{
				if (messages.TryPop(out IMessage result))
				{
					OnReceived(result);
					continue;
				}
				if (notifications.TryPop(out IMessage result2))
				{
					OnReceived(result2);
					continue;
				}
				lock (readLock)
				{
					if (token.IsCancellationRequested && messages.Count <= 0 && notifications.Count <= 0)
					{
						break;
					}
					Monitor.Wait(readLock, 2000);
				}
			}
		}

		protected virtual void OnReceived(IMessage message)
		{
			idleStateMonitor?.OnReceived();
			if (message is IResponse response)
			{
				{
					foreach (IRequest key in promises.Keys)
					{
						if (key.RpcId == response.RpcId)
						{
							if (promises.TryRemove(key, out RequestTaskTimeoutOrCompletionSource value) && value != null)
							{
								value.TrySetResult(response);
								value.Result = null;
							}
							break;
						}
					}
					return;
				}
			}
			if (message is INotification notification)
			{
				Debug.Log("接收到推送消息. 等待后续处理: " + notification.ToString());
				notificationSubject.Publish(notification);
			}
		}

		public Task<T> Send<T>(IRequest request) where T : IResponse
		{
			return Send<T>(request, TimeoutMilliseconds);
		}

		public Task<T> Send<T>(IRequest request, int timeoutMilliseconds) where T : IResponse
		{
			return Send<T>(request, timeoutMilliseconds, CancellationToken.None);
		}

		public Task<T> Send<T>(IRequest request, CancellationToken cancellationToken) where T : IResponse
		{
			return Send<T>(request, TimeoutMilliseconds, cancellationToken);
		}

		public virtual async Task<T> Send<T>(IRequest request, int timeoutMilliseconds, CancellationToken cancellationToken) where T : IResponse
		{
			ValidateDisposed();
			ValidateConnected();
			return (T)(await DoSend(request, timeoutMilliseconds, cancellationToken).ConfigureAwait(continueOnCapturedContext: false));
		}

		public virtual async Task Send(INotification notification)
		{
			ValidateDisposed();
			ValidateConnected();
			await DoSend(notification).ConfigureAwait(continueOnCapturedContext: false);
		}

		protected virtual Task<IResponse> DoSend(IRequest request, int timeoutMilliseconds, CancellationToken cancellationToken)
		{
			int num = Math.Max(timeoutMilliseconds, 5000);
			RequestTaskTimeoutOrCompletionSource requestTaskTimeoutOrCompletionSource = new RequestTaskTimeoutOrCompletionSource(request, num, cancellationToken);
			promises.TryAdd(requestTaskTimeoutOrCompletionSource.Request, requestTaskTimeoutOrCompletionSource);
			ToSend(request, requestTaskTimeoutOrCompletionSource, cancellationToken);
			return requestTaskTimeoutOrCompletionSource.Task;
		}

		protected virtual void ToSend(IRequest request, RequestTaskTimeoutOrCompletionSource promise, CancellationToken cancellationToken)
		{
			WriteAsync(request).ContinueWith(delegate(Task t)
			{
				RequestTaskTimeoutOrCompletionSource value;
				if (!t.IsFaulted && !t.IsCanceled)
				{
					if (cancellationToken.IsCancellationRequested)
					{
						promise.TrySetCanceled();
						promises.TryRemove(promise.Request, out value);
					}
					OnSent(request);
				}
				else
				{
					if (t.Exception != null)
					{
						promise.TrySetException(t.Exception);
					}
					else
					{
						promise.TrySetException(new IOException());
					}
					promises.TryRemove(promise.Request, out value);
				}
			}, TaskContinuationOptions.ExecuteSynchronously);
		}

		protected virtual void ReSend(IRequest request, RequestTaskTimeoutOrCompletionSource promise, CancellationToken cancellationToken)
		{
			WriteAsync(request).ContinueWith(delegate(Task t)
			{
				RequestTaskTimeoutOrCompletionSource value;
				if (!t.IsFaulted && !t.IsCanceled)
				{
					if (cancellationToken.IsCancellationRequested)
					{
						promise.TrySetCanceled();
						promises.TryRemove(promise.Request, out value);
					}
					OnSent(request);
				}
				else
				{
					if (t.Exception != null)
					{
						promise.TrySetException(t.Exception);
					}
					else
					{
						promise.TrySetException(new IOException());
					}
					promises.TryRemove(promise.Request, out value);
				}
			}, TaskContinuationOptions.ExecuteSynchronously);
		}

		protected virtual async Task DoSend(INotification notification)
		{
			await WriteAsync(notification).ConfigureAwait(continueOnCapturedContext: false);
			OnSent(notification);
		}

		protected virtual void OnSent(IMessage message)
		{
			idleStateMonitor?.OnSent();
		}

		protected abstract Task WriteAsync(IMessage message);

		protected abstract Task<IMessage> ReadAsync();

		public virtual async Task Disconnect()
		{
			if (State == ConnectionState.Closed)
			{
				return;
			}
			await connectLock.WaitAsync().ConfigureAwait(continueOnCapturedContext: false);
			try
			{
				if (State != ConnectionState.Closed)
				{
					State = ConnectionState.Closing;
					eventArgsSubject.Publish(ConnectionEventArgs.ClosingEventArgs);
					await DoDisconnect().ConfigureAwait(continueOnCapturedContext: false);
					State = ConnectionState.Closed;
					eventArgsSubject.Publish(ConnectionEventArgs.ClosedEventArgs);
				}
			}
			finally
			{
				connectLock.Release();
			}
		}

		protected virtual async Task DoDisconnect()
		{
			try
			{
				if (Connected)
				{
					await Close().ConfigureAwait(continueOnCapturedContext: false);
				}
				if (receiveTokenSource != null)
				{
					Debug.Log("关闭Receive线程.");
					receiveTokenSource.Cancel();
					receiveTokenSource = null;
					lock (readLock)
					{
						Monitor.PulseAll(readLock);
					}
				}
				if (readTokenSource != null)
				{
					Debug.Log("关闭Read线程.");
					readTokenSource.Cancel();
					readTokenSource = null;
				}
				OnDisconnected();
			}
			catch (Exception)
			{
			}
		}

		protected virtual void OnDisconnected()
		{
			idleStateMonitor?.OnDisconnected();
		}

		public Task Reconnect()
		{
			return Reconnect(autoReconnect: false, CancellationToken.None);
		}

		public Task Reconnect(CancellationToken cancellationToken)
		{
			return Reconnect(autoReconnect: false, cancellationToken);
		}

		private async Task Reconnect(bool autoReconnect, CancellationToken cancellationToken)
		{
			await connectLock.WaitAsync(cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			CancellationTokenSource connectionTokenSource = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken);
			try
			{
				await DoDisconnect().ConfigureAwait(continueOnCapturedContext: false);
				State = ConnectionState.Connecting;
				eventArgsSubject.Publish(ConnectionEventArgs.ReconnectingEventArgs);
				connectionTokenSource.CancelAfter(connTimeoutMilliseconds);
				CancellationToken connectionToken = connectionTokenSource.Token;
				connectionToken.Register(delegate
				{
					if (State == ConnectionState.Connecting)
					{
						Close();
					}
				});
				await DoConnect(connectionToken).ConfigureAwait(continueOnCapturedContext: false);
				State = ConnectionState.Connected;
				connectionTokenSource.Dispose();
				eventArgsSubject.Publish(ConnectionEventArgs.ConnectedEventArgs);
			}
			catch (Exception ex)
			{
				Exception e = ex;
				Debug.LogError("重连错误. e : " + e.ToString());
				await DoDisconnect().ConfigureAwait(continueOnCapturedContext: false);
				State = ConnectionState.Exception;
				eventArgsSubject.Publish(autoReconnect ? ConnectionEventArgs.ExceptionEventArgs : ConnectionEventArgs.FailedEventArgs);
				if (!(ex is Exception source))
				{
					throw ex;
				}
				ExceptionDispatchInfo.Capture(source).Throw();
			}
			finally
			{
				connectionTokenSource.Dispose();
				connectLock.Release();
			}
		}

		protected virtual void ValidateDisposed()
		{
			if (m_Disposed)
			{
				throw new ObjectDisposedException(GetType().FullName);
			}
		}

		protected virtual void ValidateConnected()
		{
			if (!Connected)
			{
				throw new IOException("The connection is not established or disconnected.");
			}
		}

		public abstract Task Close();

		public virtual async Task Shutdown()
		{
			await connectLock.WaitAsync().ConfigureAwait(continueOnCapturedContext: false);
			try
			{
				if (shutdownTokenSource == null)
				{
					return;
				}
				shutdownTokenSource.Cancel();
				shutdownTokenSource = null;
				if (State != ConnectionState.Closed)
				{
					State = ConnectionState.Closing;
					eventArgsSubject.Publish(ConnectionEventArgs.ClosingEventArgs);
					await DoDisconnect().ConfigureAwait(continueOnCapturedContext: false);
					State = ConnectionState.Closed;
					eventArgsSubject.Publish(ConnectionEventArgs.ClosedEventArgs);
				}
				if (idleStateMonitor != null)
				{
					idleStateMonitor.IdleStateChanged -= OnIdleStateChanged;
					idleStateMonitor.Dispose();
				}
				foreach (KeyValuePair<IRequest, RequestTaskTimeoutOrCompletionSource> promise2 in promises)
				{
					RequestTaskTimeoutOrCompletionSource promise = promise2.Value;
					promise.SetCanceled();
				}
				promises.Clear();
			}
			catch (Exception)
			{
			}
			finally
			{
				connectLock.Release();
			}
			m_NetworkChannelHelper.Shutdown();
		}

		public void Dispose()
		{
			Dispose(disposing: true);
			GC.SuppressFinalize(this);
		}

		protected virtual void Dispose(bool disposing)
		{
			if (m_Disposed)
			{
				return;
			}
			if (shutdownTokenSource != null)
			{
				try
				{
					shutdownTokenSource.Cancel();
					shutdownTokenSource = null;
					State = ConnectionState.Closing;
					DoDisconnect();
					eventArgsSubject.Dispose();
					foreach (KeyValuePair<IRequest, RequestTaskTimeoutOrCompletionSource> promise in promises)
					{
						RequestTaskTimeoutOrCompletionSource value = promise.Value;
						value.SetCanceled();
					}
					promises.Clear();
				}
				finally
				{
					State = ConnectionState.Closed;
				}
			}
			m_Disposed = true;
		}
	}

	private sealed class TcpNetworkChannel : NetworkChannelBase
	{
		private TcpClient client;

		private BinaryReader reader;

		private BinaryWriter writer;

		private new readonly SemaphoreSlim connectLock = new SemaphoreSlim(1, 1);

		private AddressFamily family = AddressFamily.InterNetwork;

		private bool adaptiveAddressFamily = true;

		public TcpNetworkChannel(string name, INetworkChannelHelper networkChannelHelper, bool isBigEndian, AddressFamily family)
			: base(name, networkChannelHelper, isBigEndian)
		{
			this.family = family;
		}

		protected override async Task DoConnect(string hostname, int port, int timeoutMilliseconds, CancellationToken cancellationToken)
		{
			if (timeoutMilliseconds <= 0)
			{
				timeoutMilliseconds = 5000;
			}
			if (!(await connectLock.WaitAsync(timeoutMilliseconds, cancellationToken).ConfigureAwait(continueOnCapturedContext: false)))
			{
				throw new TimeoutException();
			}
			try
			{
				if (client != null)
				{
					client.Close();
					client = null;
				}
				connected = false;
				client = await Task.Run(async delegate
				{
					IPAddress[] addresses = await Dns.GetHostAddressesAsync(hostname);
					cancellationToken.ThrowIfCancellationRequested();
					Exception lastex = null;
					TcpClient ipv6Client = null;
					TcpClient ipv4Client = null;
					IPAddress nat64Address = null;
					if ((adaptiveAddressFamily && Socket.OSSupportsIPv4) || family == AddressFamily.InterNetwork)
					{
						ipv4Client = new TcpClient(AddressFamily.InterNetwork)
						{
							NoDelay = base.NoDelay,
							ReceiveBufferSize = base.ReceiveBufferSize,
							SendBufferSize = base.SendBufferSize
						};
					}
					if ((adaptiveAddressFamily && Socket.OSSupportsIPv6) || family == AddressFamily.InterNetworkV6)
					{
						ipv6Client = new TcpClient(AddressFamily.InterNetworkV6)
						{
							NoDelay = base.NoDelay,
							ReceiveBufferSize = base.ReceiveBufferSize,
							SendBufferSize = base.SendBufferSize
						};
						if (Regex.IsMatch(hostname, "^((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)$"))
						{
							nat64Address = IPAddress.Parse("64:ff9b::" + hostname);
						}
					}
					IPAddress[] array = addresses;
					foreach (IPAddress address in array)
					{
						cancellationToken.ThrowIfCancellationRequested();
						try
						{
							if (address.AddressFamily == AddressFamily.InterNetwork && ipv4Client != null)
							{
								IAsyncResult result = ipv4Client.BeginConnect(address, port, null, null);
								if (result.AsyncWaitHandle.WaitOne(timeoutMilliseconds))
								{
									ipv4Client.EndConnect(result);
									ipv6Client?.Close();
									return ipv4Client;
								}
								ipv4Client.Close();
								throw new SocketException(10060);
							}
							if (address.AddressFamily == AddressFamily.InterNetworkV6 && ipv6Client != null)
							{
								IAsyncResult result2 = ipv6Client.BeginConnect(address, port, null, null);
								if (result2.AsyncWaitHandle.WaitOne(timeoutMilliseconds))
								{
									ipv6Client.EndConnect(result2);
									ipv4Client?.Close();
									return ipv6Client;
								}
								ipv6Client.Close();
								throw new SocketException(10060);
							}
						}
						catch (Exception ex2)
						{
							if (ex2 is ThreadAbortException || ex2 is StackOverflowException || ex2 is OutOfMemoryException)
							{
								throw;
							}
							lastex = ex2;
						}
					}
					cancellationToken.ThrowIfCancellationRequested();
					try
					{
						if (nat64Address != null)
						{
							IAsyncResult result3 = ipv6Client.BeginConnect(nat64Address, port, null, null);
							if (result3.AsyncWaitHandle.WaitOne(timeoutMilliseconds))
							{
								ipv6Client.EndConnect(result3);
								ipv4Client?.Close();
								return ipv6Client;
							}
							ipv6Client.Close();
							throw new SocketException(10060);
						}
					}
					catch (Exception ex3)
					{
						if (lastex == null)
						{
							lastex = ex3;
						}
					}
					ipv4Client?.Close();
					ipv6Client?.Close();
					if (lastex != null)
					{
						throw lastex;
					}
					throw new SocketException(10057);
				}, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				Stream stream = await WrapStream(client.GetStream()).ConfigureAwait(continueOnCapturedContext: false);
				reader = new BinaryReader(stream, leaveOpen: false, base.IsBigEndian);
				writer = new BinaryWriter(stream, leaveOpen: false, base.IsBigEndian);
				cancellationToken.ThrowIfCancellationRequested();
				connected = true;
			}
			catch (Exception ex)
			{
				Exception e = ex;
				if (client != null)
				{
					client.Close();
					client = null;
				}
				if (reader != null)
				{
					reader.Dispose();
					reader = null;
				}
				if (writer != null)
				{
					writer.Dispose();
					writer = null;
				}
				Debug.LogError("连接远端服务器失败. " + e.Message + " " + e.StackTrace);
				throw e;
			}
			finally
			{
				connectLock.Release();
			}
		}

		protected override async Task WriteAsync(IMessage message)
		{
			if (writer == null)
			{
				throw new IOException("The channel is not connected.");
			}
			await m_NetworkChannelHelper.Encode(message, writer).ConfigureAwait(continueOnCapturedContext: false);
		}

		protected override async Task<IMessage> ReadAsync()
		{
			if (reader == null)
			{
				throw new IOException("The channel is not connected.");
			}
			return await m_NetworkChannelHelper.Decode(reader).ConfigureAwait(continueOnCapturedContext: false);
		}

		public override async Task Close()
		{
			Debug.Log("关闭远端服务器连接.");
			await connectLock.WaitAsync().ConfigureAwait(continueOnCapturedContext: false);
			try
			{
				if (client != null)
				{
					connected = false;
					int delayTime = 0;
					LingerOption state = client.LingerState;
					if (state?.Enabled ?? false)
					{
						delayTime = state.LingerTime;
					}
					client.Close();
					client.Dispose();
					client = null;
					if (delayTime > 0)
					{
						await Task.Delay(delayTime).ConfigureAwait(continueOnCapturedContext: false);
					}
				}
				if (reader != null)
				{
					reader.Dispose();
					reader = null;
				}
				if (writer != null)
				{
					writer.Dispose();
					writer = null;
				}
			}
			finally
			{
				connectLock.Release();
			}
		}
	}

	private readonly Dictionary<string, NetworkChannelBase> m_NetworkChannels;

	public int NetworkChannelCount => m_NetworkChannels.Count;

	public bool IsBigEndian { get; set; }

	public AddressFamily Family { get; set; }

	public NetworkManager()
	{
		m_NetworkChannels = new Dictionary<string, NetworkChannelBase>(StringComparer.Ordinal);
	}

	internal override void Update(float elapseSeconds, float realElapseSeconds)
	{
		foreach (KeyValuePair<string, NetworkChannelBase> networkChannel in m_NetworkChannels)
		{
			networkChannel.Value.Update(elapseSeconds, realElapseSeconds);
		}
	}

	public bool HasNetworkChannel(string name)
	{
		return m_NetworkChannels.ContainsKey(name ?? string.Empty);
	}

	public INetworkChannel GetNetworkChannel(string name)
	{
		NetworkChannelBase value = null;
		if (m_NetworkChannels.TryGetValue(name ?? string.Empty, out value))
		{
			return value;
		}
		return null;
	}

	public INetworkChannel[] GetAllNetworkChannels()
	{
		int num = 0;
		INetworkChannel[] array = new INetworkChannel[m_NetworkChannels.Count];
		foreach (KeyValuePair<string, NetworkChannelBase> networkChannel in m_NetworkChannels)
		{
			array[num++] = networkChannel.Value;
		}
		return array;
	}

	public INetworkChannel CreateNetworkChannel(string name, ServiceType serviceType, INetworkChannelHelper networkChannelHelper)
	{
		if (networkChannelHelper == null)
		{
			throw new GameFrameworkException("Network channel helper is invalid.");
		}
		if (networkChannelHelper.PacketHeaderLength < 0)
		{
			throw new GameFrameworkException("Packet header length is invalid.");
		}
		if (HasNetworkChannel(name))
		{
			throw new GameFrameworkException("Already exist network channel '" + (name ?? string.Empty) + "'.");
		}
		NetworkChannelBase networkChannelBase = null;
		if (serviceType == ServiceType.Tcp)
		{
			networkChannelBase = new TcpNetworkChannel(name, networkChannelHelper, IsBigEndian, Family);
			m_NetworkChannels.Add(name, networkChannelBase);
			return networkChannelBase;
		}
		throw new GameFrameworkException($"Not supported service type '{serviceType}'.");
	}

	public bool DestroyNetworkChannel(string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			return false;
		}
		if (m_NetworkChannels.TryGetValue(name, out NetworkChannelBase value))
		{
			value.Shutdown();
			return m_NetworkChannels.Remove(name);
		}
		return false;
	}

	internal override void Shutdown()
	{
		foreach (KeyValuePair<string, NetworkChannelBase> networkChannel in m_NetworkChannels)
		{
			networkChannel.Value.Shutdown();
		}
		m_NetworkChannels.Clear();
	}
}
