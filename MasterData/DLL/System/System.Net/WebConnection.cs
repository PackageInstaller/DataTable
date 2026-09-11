using System.IO;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using Mono.Net.Security;

namespace System.Net;

internal class WebConnection : IDisposable
{
	private NetworkCredential ntlm_credentials;

	private bool ntlm_authenticated;

	private bool unsafe_sharing;

	private Stream networkStream;

	private Socket socket;

	private MonoTlsStream monoTlsStream;

	private WebConnectionTunnel tunnel;

	private int disposed;

	internal readonly int ID;

	private DateTime idleSince;

	private WebOperation currentOperation;

	public ServicePoint ServicePoint { get; }

	public bool Closed => disposed != 0;

	public DateTime IdleSince => idleSince;

	internal bool NtlmAuthenticated
	{
		get
		{
			return ntlm_authenticated;
		}
		set
		{
			ntlm_authenticated = value;
		}
	}

	internal NetworkCredential NtlmCredential
	{
		get
		{
			return ntlm_credentials;
		}
		set
		{
			ntlm_credentials = value;
		}
	}

	internal bool UnsafeAuthenticatedConnectionSharing
	{
		get
		{
			return unsafe_sharing;
		}
		set
		{
			unsafe_sharing = value;
		}
	}

	public WebConnection(ServicePoint sPoint)
	{
		ServicePoint = sPoint;
	}

	private bool CanReuse()
	{
		return !socket.Poll(0, SelectMode.SelectRead);
	}

	private bool CheckReusable()
	{
		if (socket != null && socket.Connected)
		{
			try
			{
				if (CanReuse())
				{
					return true;
				}
			}
			catch
			{
			}
		}
		return false;
	}

	private async Task Connect(WebOperation operation, CancellationToken cancellationToken)
	{
		IPHostEntry hostEntry = ServicePoint.HostEntry;
		if (hostEntry == null || hostEntry.AddressList.Length == 0)
		{
			throw GetException((!ServicePoint.UsesProxy) ? WebExceptionStatus.NameResolutionFailure : WebExceptionStatus.ProxyNameResolutionFailure, null);
		}
		Exception connectException = null;
		IPAddress[] addressList = hostEntry.AddressList;
		foreach (IPAddress iPAddress in addressList)
		{
			operation.ThrowIfDisposed(cancellationToken);
			try
			{
				socket = new Socket(iPAddress.AddressFamily, SocketType.Stream, ProtocolType.Tcp);
			}
			catch (Exception error)
			{
				throw GetException(WebExceptionStatus.ConnectFailure, error);
			}
			IPEndPoint iPEndPoint = new IPEndPoint(iPAddress, ServicePoint.Address.Port);
			socket.NoDelay = !ServicePoint.UseNagleAlgorithm;
			try
			{
				ServicePoint.KeepAliveSetup(socket);
			}
			catch
			{
			}
			if (!ServicePoint.CallEndPointDelegate(socket, iPEndPoint))
			{
				Interlocked.Exchange(ref socket, null)?.Close();
				continue;
			}
			try
			{
				operation.ThrowIfDisposed(cancellationToken);
				await Task.Factory.FromAsync((IPEndPoint targetEndPoint, AsyncCallback callback, object state) => ((Socket)state).BeginConnect(targetEndPoint, callback, state), delegate(IAsyncResult asyncResult)
				{
					((Socket)asyncResult.AsyncState).EndConnect(asyncResult);
				}, iPEndPoint, socket).ConfigureAwait(continueOnCapturedContext: false);
			}
			catch (ObjectDisposedException)
			{
				throw;
			}
			catch (Exception error2)
			{
				Interlocked.Exchange(ref socket, null)?.Close();
				connectException = GetException(WebExceptionStatus.ConnectFailure, error2);
				continue;
			}
			if (socket == null)
			{
				continue;
			}
			return;
		}
		if (connectException == null)
		{
			connectException = GetException(WebExceptionStatus.ConnectFailure, null);
		}
		throw connectException;
	}

	private async Task<bool> CreateStream(WebOperation operation, bool reused, CancellationToken cancellationToken)
	{
		_ = 1;
		try
		{
			NetworkStream stream = new NetworkStream(socket, ownsSocket: false);
			if (operation.Request.Address.Scheme == Uri.UriSchemeHttps)
			{
				if (!reused || monoTlsStream == null)
				{
					if (ServicePoint.UseConnect)
					{
						if (tunnel == null)
						{
							tunnel = new WebConnectionTunnel(operation.Request, ServicePoint.Address);
						}
						await tunnel.Initialize(stream, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
						if (!tunnel.Success)
						{
							return false;
						}
					}
					monoTlsStream = new MonoTlsStream(operation.Request, stream);
					networkStream = await monoTlsStream.CreateStream(tunnel, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				}
				return true;
			}
			networkStream = stream;
			return true;
		}
		catch (Exception e)
		{
			Exception error = HttpWebRequest.FlattenException(e);
			if (operation.Aborted || monoTlsStream == null)
			{
				throw GetException(WebExceptionStatus.ConnectFailure, error);
			}
			throw GetException(monoTlsStream.ExceptionStatus, error);
		}
		finally
		{
			_ = 0;
		}
	}

	internal async Task<WebRequestStream> InitConnection(WebOperation operation, CancellationToken cancellationToken)
	{
		bool flag = true;
		while (true)
		{
			operation.ThrowIfClosedOrDisposed(cancellationToken);
			bool reused = CheckReusable();
			if (!reused)
			{
				CloseSocket();
				if (flag)
				{
					Reset();
				}
				try
				{
					await Connect(operation, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
				}
				catch (Exception)
				{
					throw;
				}
			}
			if (await CreateStream(operation, reused, cancellationToken).ConfigureAwait(continueOnCapturedContext: false))
			{
				break;
			}
			if (tunnel?.Challenge == null)
			{
				throw GetException(WebExceptionStatus.ProtocolError, null);
			}
			if (tunnel.CloseConnection)
			{
				CloseSocket();
			}
			flag = false;
		}
		networkStream.ReadTimeout = operation.Request.ReadWriteTimeout;
		return new WebRequestStream(this, operation, networkStream, tunnel);
	}

	internal static WebException GetException(WebExceptionStatus status, Exception error)
	{
		if (error == null)
		{
			return new WebException($"Error: {status}", status);
		}
		if (error is WebException result)
		{
			return result;
		}
		return new WebException($"Error: {status} ({error.Message})", status, WebExceptionInternalStatus.RequestFatal, error);
	}

	internal static bool ReadLine(byte[] buffer, ref int start, int max, ref string output)
	{
		bool flag = false;
		StringBuilder stringBuilder = new StringBuilder();
		int num = 0;
		while (start < max)
		{
			num = buffer[start++];
			if (num == 10)
			{
				if (stringBuilder.Length > 0 && stringBuilder[stringBuilder.Length - 1] == '\r')
				{
					stringBuilder.Length--;
				}
				flag = false;
				break;
			}
			if (flag)
			{
				stringBuilder.Length--;
				break;
			}
			if (num == 13)
			{
				flag = true;
			}
			stringBuilder.Append((char)num);
		}
		if (num != 10 && num != 13)
		{
			return false;
		}
		if (stringBuilder.Length == 0)
		{
			output = null;
			if (num != 10)
			{
				return num == 13;
			}
			return true;
		}
		if (flag)
		{
			stringBuilder.Length--;
		}
		output = stringBuilder.ToString();
		return true;
	}

	internal bool CanReuseConnection(WebOperation operation)
	{
		lock (this)
		{
			if (Closed || currentOperation != null)
			{
				return false;
			}
			if (!NtlmAuthenticated)
			{
				return true;
			}
			NetworkCredential ntlmCredential = NtlmCredential;
			HttpWebRequest request = operation.Request;
			NetworkCredential networkCredential = ((request.Proxy == null || request.Proxy.IsBypassed(request.RequestUri)) ? request.Credentials : request.Proxy.Credentials)?.GetCredential(request.RequestUri, "NTLM");
			if (ntlmCredential == null || networkCredential == null || ntlmCredential.Domain != networkCredential.Domain || ntlmCredential.UserName != networkCredential.UserName || ntlmCredential.Password != networkCredential.Password)
			{
				return false;
			}
			bool unsafeAuthenticatedConnectionSharing = request.UnsafeAuthenticatedConnectionSharing;
			bool unsafeAuthenticatedConnectionSharing2 = UnsafeAuthenticatedConnectionSharing;
			return unsafeAuthenticatedConnectionSharing && unsafeAuthenticatedConnectionSharing == unsafeAuthenticatedConnectionSharing2;
		}
	}

	private bool PrepareSharingNtlm(WebOperation operation)
	{
		if (operation == null || !NtlmAuthenticated)
		{
			return true;
		}
		bool flag = false;
		NetworkCredential ntlmCredential = NtlmCredential;
		HttpWebRequest request = operation.Request;
		NetworkCredential networkCredential = ((request.Proxy == null || request.Proxy.IsBypassed(request.RequestUri)) ? request.Credentials : request.Proxy.Credentials)?.GetCredential(request.RequestUri, "NTLM");
		if (ntlmCredential == null || networkCredential == null || ntlmCredential.Domain != networkCredential.Domain || ntlmCredential.UserName != networkCredential.UserName || ntlmCredential.Password != networkCredential.Password)
		{
			flag = true;
		}
		if (!flag)
		{
			bool unsafeAuthenticatedConnectionSharing = request.UnsafeAuthenticatedConnectionSharing;
			bool unsafeAuthenticatedConnectionSharing2 = UnsafeAuthenticatedConnectionSharing;
			flag = !unsafeAuthenticatedConnectionSharing || unsafeAuthenticatedConnectionSharing != unsafeAuthenticatedConnectionSharing2;
		}
		return flag;
	}

	private void Reset()
	{
		lock (this)
		{
			tunnel = null;
			ResetNtlm();
		}
	}

	private void Close(bool reset)
	{
		lock (this)
		{
			CloseSocket();
			if (reset)
			{
				Reset();
			}
		}
	}

	private void CloseSocket()
	{
		lock (this)
		{
			if (networkStream != null)
			{
				try
				{
					networkStream.Dispose();
				}
				catch
				{
				}
				networkStream = null;
			}
			if (monoTlsStream != null)
			{
				try
				{
					monoTlsStream.Dispose();
				}
				catch
				{
				}
				monoTlsStream = null;
			}
			if (socket != null)
			{
				try
				{
					socket.Dispose();
				}
				catch
				{
				}
				socket = null;
			}
			monoTlsStream = null;
		}
	}

	public bool StartOperation(WebOperation operation, bool reused)
	{
		lock (this)
		{
			if (Closed)
			{
				return false;
			}
			if (Interlocked.CompareExchange(ref currentOperation, operation, null) != null)
			{
				return false;
			}
			idleSince = DateTime.UtcNow + TimeSpan.FromDays(3650.0);
			if (reused && !PrepareSharingNtlm(operation))
			{
				Close(reset: true);
			}
			operation.RegisterRequest(ServicePoint, this);
		}
		operation.Run();
		return true;
	}

	public bool Continue(WebOperation next)
	{
		lock (this)
		{
			if (Closed)
			{
				return false;
			}
			if (socket == null || !socket.Connected || !PrepareSharingNtlm(next))
			{
				Close(reset: true);
				return false;
			}
			currentOperation = next;
			if (next == null)
			{
				return true;
			}
			next.RegisterRequest(ServicePoint, this);
		}
		next.Run();
		return true;
	}

	private void Dispose(bool disposing)
	{
		if (Interlocked.CompareExchange(ref disposed, 1, 0) == 0)
		{
			Close(reset: true);
		}
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}

	private void ResetNtlm()
	{
		ntlm_authenticated = false;
		ntlm_credentials = null;
		unsafe_sharing = false;
	}
}
