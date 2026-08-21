using System.IO;
using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;
using System.Threading;
using System.Threading.Tasks;
using Mono.Net.Security;
using Mono.Net.Security.Private;
using Mono.Security.Interface;

namespace System.Net.Security;

public class SslStream : AuthenticatedStream
{
	private MobileTlsProvider provider;

	private MonoTlsSettings settings;

	private RemoteCertificateValidationCallback validationCallback;

	private LocalCertificateSelectionCallback selectionCallback;

	private MobileAuthenticatedStream impl;

	private bool explicitSettings;

	internal MobileAuthenticatedStream Impl
	{
		get
		{
			CheckDisposed();
			return impl;
		}
	}

	internal string InternalTargetHost
	{
		get
		{
			CheckDisposed();
			return impl.TargetHost;
		}
	}

	public override bool IsAuthenticated => Impl.IsAuthenticated;

	public virtual X509Certificate LocalCertificate => Impl.LocalCertificate;

	public override bool CanSeek => false;

	public override bool CanRead
	{
		get
		{
			if (impl != null)
			{
				return impl.CanRead;
			}
			return false;
		}
	}

	public override bool CanTimeout => base.InnerStream.CanTimeout;

	public override bool CanWrite
	{
		get
		{
			if (impl != null)
			{
				return impl.CanWrite;
			}
			return false;
		}
	}

	public override int ReadTimeout
	{
		get
		{
			return Impl.ReadTimeout;
		}
		set
		{
			Impl.ReadTimeout = value;
		}
	}

	public override int WriteTimeout
	{
		get
		{
			return Impl.WriteTimeout;
		}
		set
		{
			Impl.WriteTimeout = value;
		}
	}

	public override long Length => Impl.Length;

	public override long Position
	{
		get
		{
			return Impl.Position;
		}
		set
		{
			throw new NotSupportedException(global::SR.GetString("This stream does not support seek operations."));
		}
	}

	private static MobileTlsProvider GetProvider()
	{
		return (MobileTlsProvider)(object)MonoTlsProviderFactory.GetProvider();
	}

	public SslStream(Stream innerStream, bool leaveInnerStreamOpen, RemoteCertificateValidationCallback userCertificateValidationCallback)
		: this(innerStream, leaveInnerStreamOpen, userCertificateValidationCallback, null)
	{
	}

	public SslStream(Stream innerStream, bool leaveInnerStreamOpen, RemoteCertificateValidationCallback userCertificateValidationCallback, LocalCertificateSelectionCallback userCertificateSelectionCallback)
		: base(innerStream, leaveInnerStreamOpen)
	{
		provider = GetProvider();
		settings = MonoTlsSettings.CopyDefaultSettings();
		SetAndVerifyValidationCallback(userCertificateValidationCallback);
		SetAndVerifySelectionCallback(userCertificateSelectionCallback);
		impl = provider.CreateSslStream(this, innerStream, leaveInnerStreamOpen, settings);
	}

	internal SslStream(Stream innerStream, bool leaveInnerStreamOpen, MonoTlsProvider provider, MonoTlsSettings settings)
		: base(innerStream, leaveInnerStreamOpen)
	{
		this.provider = (MobileTlsProvider)(object)provider;
		this.settings = settings.Clone();
		explicitSettings = true;
		impl = this.provider.CreateSslStream(this, innerStream, leaveInnerStreamOpen, settings);
	}

	private void SetAndVerifyValidationCallback(RemoteCertificateValidationCallback callback)
	{
		if (validationCallback == null)
		{
			validationCallback = callback;
			settings.RemoteCertificateValidationCallback = CallbackHelpers.PublicToMono(callback);
		}
		else if ((callback != null && validationCallback != callback) || (explicitSettings & (settings.RemoteCertificateValidationCallback != null)))
		{
			throw new InvalidOperationException(global::SR.Format("The '{0}' option was already set in the SslStream constructor.", "RemoteCertificateValidationCallback"));
		}
	}

	private void SetAndVerifySelectionCallback(LocalCertificateSelectionCallback callback)
	{
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Expected O, but got Unknown
		if (selectionCallback == null)
		{
			selectionCallback = callback;
			if (callback == null)
			{
				settings.ClientCertificateSelectionCallback = null;
				return;
			}
			settings.ClientCertificateSelectionCallback = (MonoLocalCertificateSelectionCallback)((string t, X509CertificateCollection lc, X509Certificate rc, string[] ai) => callback(this, t, lc, rc, ai));
		}
		else if ((callback != null && selectionCallback != callback) || (explicitSettings && settings.ClientCertificateSelectionCallback != null))
		{
			throw new InvalidOperationException(global::SR.Format("The '{0}' option was already set in the SslStream constructor.", "LocalCertificateSelectionCallback"));
		}
	}

	public virtual void AuthenticateAsClient(string targetHost, X509CertificateCollection clientCertificates, SslProtocols enabledSslProtocols, bool checkCertificateRevocation)
	{
		Impl.AuthenticateAsClient(targetHost, clientCertificates, enabledSslProtocols, checkCertificateRevocation);
	}

	public virtual IAsyncResult BeginAuthenticateAsClient(string targetHost, X509CertificateCollection clientCertificates, SslProtocols enabledSslProtocols, bool checkCertificateRevocation, AsyncCallback asyncCallback, object asyncState)
	{
		return TaskToApm.Begin(Impl.AuthenticateAsClientAsync(targetHost, clientCertificates, enabledSslProtocols, checkCertificateRevocation), asyncCallback, asyncState);
	}

	public virtual void EndAuthenticateAsClient(IAsyncResult asyncResult)
	{
		TaskToApm.End(asyncResult);
	}

	public virtual Task AuthenticateAsClientAsync(string targetHost, X509CertificateCollection clientCertificates, SslProtocols enabledSslProtocols, bool checkCertificateRevocation)
	{
		return Impl.AuthenticateAsClientAsync(targetHost, clientCertificates, enabledSslProtocols, checkCertificateRevocation);
	}

	public override void SetLength(long value)
	{
		Impl.SetLength(value);
	}

	public override long Seek(long offset, SeekOrigin origin)
	{
		throw new NotSupportedException(global::SR.GetString("This stream does not support seek operations."));
	}

	public override Task FlushAsync(CancellationToken cancellationToken)
	{
		return base.InnerStream.FlushAsync(cancellationToken);
	}

	public override void Flush()
	{
		base.InnerStream.Flush();
	}

	private void CheckDisposed()
	{
		if (impl == null)
		{
			throw new ObjectDisposedException("SslStream");
		}
	}

	protected override void Dispose(bool disposing)
	{
		try
		{
			if ((impl != null) & disposing)
			{
				impl.Dispose();
				impl = null;
			}
		}
		finally
		{
			base.Dispose(disposing);
		}
	}

	public override int Read(byte[] buffer, int offset, int count)
	{
		return Impl.Read(buffer, offset, count);
	}

	public override void Write(byte[] buffer, int offset, int count)
	{
		Impl.Write(buffer, offset, count);
	}

	public override Task<int> ReadAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		return Impl.ReadAsync(buffer, offset, count, cancellationToken);
	}

	public override Task WriteAsync(byte[] buffer, int offset, int count, CancellationToken cancellationToken)
	{
		return Impl.WriteAsync(buffer, offset, count, cancellationToken);
	}

	public override IAsyncResult BeginRead(byte[] buffer, int offset, int count, AsyncCallback callback, object state)
	{
		return TaskToApm.Begin(Impl.ReadAsync(buffer, offset, count), callback, state);
	}

	public override int EndRead(IAsyncResult asyncResult)
	{
		return TaskToApm.End<int>(asyncResult);
	}

	public override IAsyncResult BeginWrite(byte[] buffer, int offset, int count, AsyncCallback callback, object state)
	{
		return TaskToApm.Begin(Impl.WriteAsync(buffer, offset, count), callback, state);
	}

	public override void EndWrite(IAsyncResult asyncResult)
	{
		TaskToApm.End(asyncResult);
	}
}
