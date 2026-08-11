using System;
using System.Threading;
using System.Threading.Tasks;

namespace GameFramework.Network;

public class IdleStateMonitor : IDisposable
{
	private readonly object syncLock = new object();

	private TimeSpan readerIdleTime;

	private TimeSpan writerIdleTime;

	private TimeSpan allIdleTime;

	private TimeSpan waitTimeout;

	private long readerIdleCheckTime;

	private long writerIdleCheckTime;

	private long allIdleCheckTime;

	private bool enableReaderIdle;

	private bool enableWriterIdle;

	private bool enableAllIdle;

	private bool firstReaderIdle = true;

	private bool firstWriterIdle = true;

	private bool firstAllIdle = true;

	private bool connected = false;

	private CancellationTokenSource cancellationTokenSource;

	private CancellationToken cancellationToken;

	private bool disposedValue = false;

	public event EventHandler<IdleStateEventArgs> IdleStateChanged;

	public IdleStateMonitor()
		: this(TimeSpan.FromMilliseconds(0.0))
	{
	}

	public IdleStateMonitor(TimeSpan idleTime)
		: this(idleTime, idleTime, idleTime)
	{
	}

	public IdleStateMonitor(TimeSpan readerIdleTime, TimeSpan writerIdleTime, TimeSpan allIdleTime)
	{
		this.readerIdleTime = readerIdleTime;
		this.writerIdleTime = writerIdleTime;
		this.allIdleTime = allIdleTime;
		enableReaderIdle = this.readerIdleTime.Ticks > 0;
		enableWriterIdle = this.writerIdleTime.Ticks > 0;
		enableAllIdle = this.allIdleTime.Ticks > 0;
		waitTimeout = TimeSpan.FromSeconds(60.0);
		if (enableReaderIdle && waitTimeout > readerIdleTime)
		{
			waitTimeout = readerIdleTime;
		}
		if (enableWriterIdle && waitTimeout > writerIdleTime)
		{
			waitTimeout = writerIdleTime;
		}
		if (enableAllIdle && waitTimeout > allIdleTime)
		{
			waitTimeout = allIdleTime;
		}
		Init();
	}

	protected void Init()
	{
		if (!enableReaderIdle && !enableWriterIdle && !enableAllIdle)
		{
			return;
		}
		long ticks = DateTime.Now.Ticks;
		readerIdleCheckTime = ticks + readerIdleTime.Ticks;
		writerIdleCheckTime = ticks + writerIdleTime.Ticks;
		allIdleCheckTime = ticks + allIdleTime.Ticks;
		firstReaderIdle = (firstWriterIdle = (firstAllIdle = true));
		cancellationTokenSource = new CancellationTokenSource();
		cancellationToken = cancellationTokenSource.Token;
		Task.Factory.StartNew(delegate
		{
			try
			{
				while (!cancellationToken.IsCancellationRequested)
				{
					long ticks2 = DateTime.Now.Ticks;
					if (connected)
					{
						try
						{
							IdleStateEventArgs e = null;
							IdleStateEventArgs e2 = null;
							IdleStateEventArgs e3 = null;
							lock (syncLock)
							{
								if (enableReaderIdle && readerIdleCheckTime <= ticks2)
								{
									e = (firstReaderIdle ? IdleStateEventArgs.FirstReaderIdleStateEvent : IdleStateEventArgs.ReaderIdleStateEvent);
									firstReaderIdle = false;
									readerIdleCheckTime = ticks2 + readerIdleTime.Ticks;
								}
								if (enableWriterIdle && writerIdleCheckTime <= ticks2)
								{
									e2 = (firstWriterIdle ? IdleStateEventArgs.FirstWriterIdleStateEvent : IdleStateEventArgs.WriterIdleStateEvent);
									firstWriterIdle = false;
									writerIdleCheckTime = ticks2 + writerIdleTime.Ticks;
								}
								if (enableAllIdle && allIdleCheckTime <= ticks2)
								{
									e3 = (firstAllIdle ? IdleStateEventArgs.FirstAllIdleStateEvent : IdleStateEventArgs.AllIdleStateEvent);
									firstAllIdle = false;
									allIdleCheckTime = ticks2 + allIdleTime.Ticks;
								}
							}
							if (e != null)
							{
								RaiseIdleStateChanged(e);
							}
							if (e2 != null)
							{
								RaiseIdleStateChanged(e2);
							}
							if (e3 != null)
							{
								RaiseIdleStateChanged(e3);
							}
						}
						catch (Exception)
						{
						}
					}
					lock (syncLock)
					{
						if (connected)
						{
							if (waitTimeout.Ticks > 0)
							{
								Monitor.Wait(syncLock, waitTimeout);
							}
						}
						else
						{
							Monitor.Wait(syncLock);
						}
					}
				}
			}
			catch (Exception)
			{
			}
		}, cancellationToken, TaskCreationOptions.LongRunning, TaskScheduler.Default);
	}

	public void OnConnected()
	{
		lock (syncLock)
		{
			connected = true;
			Monitor.PulseAll(syncLock);
		}
	}

	public void OnReceived()
	{
		lock (syncLock)
		{
			long ticks = DateTime.Now.Ticks;
			if (enableReaderIdle)
			{
				readerIdleCheckTime = ticks + readerIdleTime.Ticks;
			}
			if (enableAllIdle)
			{
				allIdleCheckTime = ticks + allIdleTime.Ticks;
			}
			firstReaderIdle = (firstAllIdle = true);
		}
	}

	public void OnSent()
	{
		lock (syncLock)
		{
			long ticks = DateTime.Now.Ticks;
			if (enableWriterIdle)
			{
				writerIdleCheckTime = ticks + writerIdleTime.Ticks;
			}
			if (enableAllIdle)
			{
				allIdleCheckTime = ticks + allIdleTime.Ticks;
			}
			firstWriterIdle = (firstAllIdle = true);
		}
	}

	public void OnDisconnected()
	{
		lock (syncLock)
		{
			connected = false;
			Monitor.PulseAll(syncLock);
		}
	}

	protected void RaiseIdleStateChanged(IdleStateEventArgs eventArgs)
	{
		IdleStateChanged?.Invoke(this, eventArgs);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!disposedValue)
		{
			lock (syncLock)
			{
				connected = false;
				cancellationTokenSource.Cancel();
				Monitor.PulseAll(syncLock);
				cancellationTokenSource.Dispose();
				cancellationTokenSource = null;
			}
			disposedValue = true;
		}
	}

	~IdleStateMonitor()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}
}
