using System;
using System.IO;
using System.Net;
using System.Net.Security;
using System.Net.Sockets;
using System.Security.Authentication;
using System.Threading;
using System.Threading.Tasks;
using Mono.Net.Security.Private;
using Mono.Security.Interface;

namespace Mono.Net.Security;

internal class MonoTlsStream : IDisposable
{
	private readonly MobileTlsProvider provider;

	private readonly NetworkStream networkStream;

	private readonly HttpWebRequest request;

	private readonly MonoTlsSettings settings;

	private SslStream sslStream;

	private readonly object sslStreamLock = new object();

	private WebExceptionStatus status;

	internal HttpWebRequest Request => request;

	internal WebExceptionStatus ExceptionStatus => status;

	internal bool CertificateValidationFailed { get; set; }

	public MonoTlsStream(HttpWebRequest request, NetworkStream networkStream)
	{
		this.request = request;
		this.networkStream = networkStream;
		settings = request.TlsSettings;
		if (settings == null)
		{
			settings = MonoTlsSettings.CopyDefaultSettings();
		}
		if (settings.RemoteCertificateValidationCallback == null)
		{
			settings.RemoteCertificateValidationCallback = CallbackHelpers.PublicToMono(request.ServerCertificateValidationCallback);
		}
		provider = request.TlsProvider ?? MonoTlsProviderFactory.GetProviderInternal();
		status = WebExceptionStatus.SecureChannelFailure;
		ChainValidationHelper.Create(provider, ref settings, this);
	}

	internal async Task<Stream> CreateStream(WebConnectionTunnel tunnel, CancellationToken cancellationToken)
	{
		Socket socket = networkStream.InternalSocket;
		sslStream = new SslStream(networkStream, leaveInnerStreamOpen: false, provider, settings);
		try
		{
			string text = request.Host;
			if (!string.IsNullOrEmpty(text))
			{
				int num = text.IndexOf(':');
				if (num > 0)
				{
					text = text.Substring(0, num);
				}
			}
			await sslStream.AuthenticateAsClientAsync(text, request.ClientCertificates, (SslProtocols)ServicePointManager.SecurityProtocol, ServicePointManager.CheckCertificateRevocationList).ConfigureAwait(continueOnCapturedContext: false);
			status = WebExceptionStatus.Success;
			request.ServicePoint.UpdateClientCertificate(sslStream.LocalCertificate);
		}
		catch (Exception)
		{
			if (socket.CleanedUp)
			{
				status = WebExceptionStatus.RequestCanceled;
			}
			else if (CertificateValidationFailed)
			{
				status = WebExceptionStatus.TrustFailure;
			}
			else
			{
				status = WebExceptionStatus.SecureChannelFailure;
			}
			request.ServicePoint.UpdateClientCertificate(null);
			CloseSslStream();
			throw;
		}
		try
		{
			if (tunnel?.Data != null)
			{
				await sslStream.WriteAsync(tunnel.Data, 0, tunnel.Data.Length, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			}
		}
		catch
		{
			status = WebExceptionStatus.SendFailure;
			CloseSslStream();
			throw;
		}
		return sslStream;
	}

	public void Dispose()
	{
		CloseSslStream();
	}

	private void CloseSslStream()
	{
		lock (sslStreamLock)
		{
			if (sslStream != null)
			{
				sslStream.Dispose();
				sslStream = null;
			}
		}
	}
}
