using System;
using System.Runtime.InteropServices;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using Mono.Net.Security;
using Mono.Security.Cryptography;
using Mono.Security.Interface;
using Mono.Util;

namespace Mono.Unity;

internal class UnityTlsContext : MobileTlsContext
{
	private unsafe UnityTls.unitytls_tlsctx* tlsContext = null;

	private unsafe UnityTls.unitytls_x509list* requestedClientCertChain = null;

	private unsafe UnityTls.unitytls_key* requestedClientKey = null;

	private UnityTls.unitytls_tlsctx_read_callback readCallback;

	private UnityTls.unitytls_tlsctx_write_callback writeCallback;

	private UnityTls.unitytls_tlsctx_certificate_callback certificateCallback;

	private UnityTls.unitytls_tlsctx_x509verify_callback verifyCallback;

	private X509Certificate localClientCertificate;

	private X509Certificate2 remoteCertificate;

	private MonoTlsConnectionInfo connectioninfo;

	private bool isAuthenticated;

	private bool hasContext;

	private bool closedGraceful;

	private byte[] writeBuffer;

	private byte[] readBuffer;

	private GCHandle handle;

	private Exception lastException;

	public override bool IsAuthenticated => isAuthenticated;

	internal override X509Certificate LocalClientCertificate => localClientCertificate;

	public override X509Certificate2 RemoteCertificate => remoteCertificate;

	public unsafe UnityTlsContext(MobileAuthenticatedStream parent, MonoSslAuthenticationOptions options)
		: base(parent, options)
	{
		handle = GCHandle.Alloc(this);
		UnityTls.unitytls_errorstate errorState = UnityTls.NativeInterface.unitytls_errorstate_create();
		UnityTls.unitytls_tlsctx_protocolrange supportedProtocols = new UnityTls.unitytls_tlsctx_protocolrange
		{
			min = UnityTlsConversions.GetMinProtocol(options.EnabledSslProtocols),
			max = UnityTlsConversions.GetMaxProtocol(options.EnabledSslProtocols)
		};
		readCallback = ReadCallback;
		writeCallback = WriteCallback;
		UnityTls.unitytls_tlsctx_callbacks callbacks = new UnityTls.unitytls_tlsctx_callbacks
		{
			write = writeCallback,
			read = readCallback,
			data = (void*)(IntPtr)handle
		};
		if (options.ServerMode)
		{
			ExtractNativeKeyAndChainFromManagedCertificate(options.ServerCertificate, &errorState, out var nativeCertChain, out var nativeKey);
			try
			{
				UnityTls.unitytls_x509list_ref unitytls_x509list_ref = UnityTls.NativeInterface.unitytls_x509list_get_ref(nativeCertChain, &errorState);
				UnityTls.unitytls_key_ref unitytls_key_ref = UnityTls.NativeInterface.unitytls_key_get_ref(nativeKey, &errorState);
				Debug.CheckAndThrow(errorState, "Failed to parse server key/certificate");
				tlsContext = UnityTls.NativeInterface.unitytls_tlsctx_create_server(supportedProtocols, callbacks, unitytls_x509list_ref.handle, unitytls_key_ref.handle, &errorState);
				if (base.AskForClientCertificate)
				{
					UnityTls.unitytls_x509list* list = null;
					try
					{
						list = UnityTls.NativeInterface.unitytls_x509list_create(&errorState);
						UnityTls.unitytls_x509list_ref clientAuthCAList = UnityTls.NativeInterface.unitytls_x509list_get_ref(list, &errorState);
						UnityTls.NativeInterface.unitytls_tlsctx_server_require_client_authentication(tlsContext, clientAuthCAList, &errorState);
					}
					finally
					{
						UnityTls.NativeInterface.unitytls_x509list_free(list);
					}
				}
			}
			finally
			{
				UnityTls.NativeInterface.unitytls_x509list_free(nativeCertChain);
				UnityTls.NativeInterface.unitytls_key_free(nativeKey);
			}
		}
		else
		{
			byte[] bytes = Encoding.UTF8.GetBytes(options.TargetHost);
			fixed (byte* cn = bytes)
			{
				tlsContext = UnityTls.NativeInterface.unitytls_tlsctx_create_client(supportedProtocols, callbacks, cn, (IntPtr)bytes.Length, &errorState);
			}
			certificateCallback = CertificateCallback;
			UnityTls.NativeInterface.unitytls_tlsctx_set_certificate_callback(tlsContext, certificateCallback, (void*)(IntPtr)handle, &errorState);
		}
		verifyCallback = VerifyCallback;
		UnityTls.NativeInterface.unitytls_tlsctx_set_x509verify_callback(tlsContext, verifyCallback, (void*)(IntPtr)handle, &errorState);
		Debug.CheckAndThrow(errorState, "Failed to create UnityTls context");
		hasContext = true;
	}

	private unsafe static void ExtractNativeKeyAndChainFromManagedCertificate(X509Certificate cert, UnityTls.unitytls_errorstate* errorState, out UnityTls.unitytls_x509list* nativeCertChain, out UnityTls.unitytls_key* nativeKey)
	{
		if (cert == null)
		{
			throw new ArgumentNullException("cert");
		}
		if (!(cert is X509Certificate2 { PrivateKey: not null } x509Certificate))
		{
			throw new ArgumentException("Certificate does not have a private key", "cert");
		}
		nativeCertChain = null;
		nativeKey = null;
		try
		{
			nativeCertChain = UnityTls.NativeInterface.unitytls_x509list_create(errorState);
			CertHelper.AddCertificateToNativeChain(nativeCertChain, cert, errorState);
			byte[] array = PKCS8.PrivateKeyInfo.Encode(x509Certificate.PrivateKey);
			fixed (byte* buffer = array)
			{
				nativeKey = UnityTls.NativeInterface.unitytls_key_parse_der(buffer, (IntPtr)array.Length, null, (IntPtr)0, errorState);
			}
		}
		catch
		{
			UnityTls.NativeInterface.unitytls_x509list_free(nativeCertChain);
			UnityTls.NativeInterface.unitytls_key_free(nativeKey);
			throw;
		}
	}

	public override void Flush()
	{
	}

	public unsafe override (int ret, bool wantMore) Read(byte[] buffer, int offset, int count)
	{
		int num = 0;
		lastException = null;
		UnityTls.unitytls_errorstate errorState = UnityTls.NativeInterface.unitytls_errorstate_create();
		fixed (byte* ptr = buffer)
		{
			num = (int)UnityTls.NativeInterface.unitytls_tlsctx_read(tlsContext, ptr + offset, (IntPtr)count, &errorState);
		}
		if (lastException != null)
		{
			throw lastException;
		}
		switch (errorState.code)
		{
		case UnityTls.unitytls_error_code.UNITYTLS_SUCCESS:
			return (ret: num, wantMore: num < count);
		case UnityTls.unitytls_error_code.UNITYTLS_USER_WOULD_BLOCK:
			return (ret: num, wantMore: true);
		case UnityTls.unitytls_error_code.UNITYTLS_STREAM_CLOSED:
			return (ret: 0, wantMore: false);
		default:
			if (!closedGraceful)
			{
				Debug.CheckAndThrow(errorState, "Failed to read data to TLS context");
			}
			return (ret: 0, wantMore: false);
		}
	}

	public unsafe override (int ret, bool wantMore) Write(byte[] buffer, int offset, int count)
	{
		int num = 0;
		lastException = null;
		UnityTls.unitytls_errorstate errorState = UnityTls.NativeInterface.unitytls_errorstate_create();
		fixed (byte* ptr = buffer)
		{
			num = (int)UnityTls.NativeInterface.unitytls_tlsctx_write(tlsContext, ptr + offset, (IntPtr)count, &errorState);
		}
		if (lastException != null)
		{
			throw lastException;
		}
		switch (errorState.code)
		{
		case UnityTls.unitytls_error_code.UNITYTLS_SUCCESS:
			return (ret: num, wantMore: num < count);
		case UnityTls.unitytls_error_code.UNITYTLS_USER_WOULD_BLOCK:
			return (ret: num, wantMore: true);
		case UnityTls.unitytls_error_code.UNITYTLS_STREAM_CLOSED:
			return (ret: 0, wantMore: false);
		default:
			Debug.CheckAndThrow(errorState, "Failed to write data to TLS context");
			return (ret: 0, wantMore: false);
		}
	}

	public override void Renegotiate()
	{
		throw new NotSupportedException();
	}

	public override bool PendingRenegotiation()
	{
		return false;
	}

	public unsafe override void Shutdown()
	{
		if (base.Settings != null && base.Settings.SendCloseNotify)
		{
			UnityTls.unitytls_errorstate unitytls_errorstate = UnityTls.NativeInterface.unitytls_errorstate_create();
			UnityTls.NativeInterface.unitytls_tlsctx_notify_close(tlsContext, &unitytls_errorstate);
		}
		UnityTls.NativeInterface.unitytls_x509list_free(requestedClientCertChain);
		UnityTls.NativeInterface.unitytls_key_free(requestedClientKey);
		UnityTls.NativeInterface.unitytls_tlsctx_free(tlsContext);
		tlsContext = null;
		hasContext = false;
	}

	protected override void Dispose(bool disposing)
	{
		try
		{
			if (disposing)
			{
				Shutdown();
				localClientCertificate = null;
				remoteCertificate = null;
				if (localClientCertificate != null)
				{
					localClientCertificate.Dispose();
					localClientCertificate = null;
				}
				if (remoteCertificate != null)
				{
					remoteCertificate.Dispose();
					remoteCertificate = null;
				}
				connectioninfo = null;
				isAuthenticated = false;
				hasContext = false;
			}
			handle.Free();
		}
		finally
		{
			base.Dispose(disposing);
		}
	}

	public unsafe override void StartHandshake()
	{
		if (base.Settings != null && base.Settings.EnabledCiphers != null)
		{
			UnityTls.unitytls_ciphersuite[] array = new UnityTls.unitytls_ciphersuite[base.Settings.EnabledCiphers.Length];
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = (UnityTls.unitytls_ciphersuite)base.Settings.EnabledCiphers[i];
			}
			UnityTls.unitytls_errorstate errorState = UnityTls.NativeInterface.unitytls_errorstate_create();
			fixed (UnityTls.unitytls_ciphersuite* supportedCiphersuites = array)
			{
				UnityTls.NativeInterface.unitytls_tlsctx_set_supported_ciphersuites(tlsContext, supportedCiphersuites, (IntPtr)array.Length, &errorState);
			}
			Debug.CheckAndThrow(errorState, "Failed to set list of supported ciphers", AlertDescription.HandshakeFailure);
		}
	}

	public unsafe override bool ProcessHandshake()
	{
		lastException = null;
		UnityTls.unitytls_errorstate errorState = UnityTls.NativeInterface.unitytls_errorstate_create();
		UnityTls.unitytls_x509verify_result unitytls_x509verify_result = UnityTls.NativeInterface.unitytls_tlsctx_process_handshake(tlsContext, &errorState);
		if (errorState.code == UnityTls.unitytls_error_code.UNITYTLS_USER_WOULD_BLOCK)
		{
			return false;
		}
		if (lastException != null)
		{
			throw lastException;
		}
		if (base.IsServer && unitytls_x509verify_result == UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_NOT_DONE)
		{
			Debug.CheckAndThrow(errorState, "Handshake failed", AlertDescription.HandshakeFailure);
			if (!ValidateCertificate(null, null))
			{
				throw new TlsException(AlertDescription.HandshakeFailure, "Verification failure during handshake");
			}
		}
		else
		{
			Debug.CheckAndThrow(errorState, unitytls_x509verify_result, "Handshake failed", AlertDescription.HandshakeFailure);
		}
		return true;
	}

	public unsafe override void FinishHandshake()
	{
		UnityTls.unitytls_errorstate unitytls_errorstate = UnityTls.NativeInterface.unitytls_errorstate_create();
		UnityTls.unitytls_ciphersuite unitytls_ciphersuite = UnityTls.NativeInterface.unitytls_tlsctx_get_ciphersuite(tlsContext, &unitytls_errorstate);
		UnityTls.unitytls_protocol protocol = UnityTls.NativeInterface.unitytls_tlsctx_get_protocol(tlsContext, &unitytls_errorstate);
		connectioninfo = new MonoTlsConnectionInfo
		{
			CipherSuiteCode = (CipherSuiteCode)unitytls_ciphersuite,
			ProtocolVersion = UnityTlsConversions.ConvertProtocolVersion(protocol),
			PeerDomainName = base.ServerName
		};
		isAuthenticated = true;
	}

	[MonoPInvokeCallback(typeof(UnityTls.unitytls_tlsctx_write_callback))]
	private unsafe static IntPtr WriteCallback(void* userData, byte* data, IntPtr bufferLen, UnityTls.unitytls_errorstate* errorState)
	{
		return ((UnityTlsContext)((GCHandle)(IntPtr)userData).Target).WriteCallback(data, bufferLen, errorState);
	}

	private unsafe IntPtr WriteCallback(byte* data, IntPtr bufferLen, UnityTls.unitytls_errorstate* errorState)
	{
		try
		{
			if (writeBuffer == null || writeBuffer.Length < (int)bufferLen)
			{
				writeBuffer = new byte[(int)bufferLen];
			}
			Marshal.Copy((IntPtr)data, writeBuffer, 0, (int)bufferLen);
			if (!base.Parent.InternalWrite(writeBuffer, 0, (int)bufferLen))
			{
				UnityTls.NativeInterface.unitytls_errorstate_raise_error(errorState, UnityTls.unitytls_error_code.UNITYTLS_USER_WRITE_FAILED);
				return (IntPtr)0;
			}
			return bufferLen;
		}
		catch (Exception ex)
		{
			UnityTls.NativeInterface.unitytls_errorstate_raise_error(errorState, UnityTls.unitytls_error_code.UNITYTLS_USER_UNKNOWN_ERROR);
			if (lastException == null)
			{
				lastException = ex;
			}
			return (IntPtr)0;
		}
	}

	[MonoPInvokeCallback(typeof(UnityTls.unitytls_tlsctx_read_callback))]
	private unsafe static IntPtr ReadCallback(void* userData, byte* buffer, IntPtr bufferLen, UnityTls.unitytls_errorstate* errorState)
	{
		return ((UnityTlsContext)((GCHandle)(IntPtr)userData).Target).ReadCallback(buffer, bufferLen, errorState);
	}

	private unsafe IntPtr ReadCallback(byte* buffer, IntPtr bufferLen, UnityTls.unitytls_errorstate* errorState)
	{
		try
		{
			if (readBuffer == null || readBuffer.Length < (int)bufferLen)
			{
				readBuffer = new byte[(int)bufferLen];
			}
			int num = base.Parent.InternalRead(readBuffer, 0, (int)bufferLen, out var outWantMore);
			if (num < 0)
			{
				UnityTls.NativeInterface.unitytls_errorstate_raise_error(errorState, UnityTls.unitytls_error_code.UNITYTLS_USER_READ_FAILED);
			}
			else if (num > 0)
			{
				Marshal.Copy(readBuffer, 0, (IntPtr)buffer, (int)bufferLen);
			}
			else if (outWantMore)
			{
				UnityTls.NativeInterface.unitytls_errorstate_raise_error(errorState, UnityTls.unitytls_error_code.UNITYTLS_USER_WOULD_BLOCK);
			}
			else
			{
				closedGraceful = true;
				UnityTls.NativeInterface.unitytls_errorstate_raise_error(errorState, UnityTls.unitytls_error_code.UNITYTLS_USER_READ_FAILED);
			}
			return (IntPtr)num;
		}
		catch (Exception ex)
		{
			UnityTls.NativeInterface.unitytls_errorstate_raise_error(errorState, UnityTls.unitytls_error_code.UNITYTLS_USER_UNKNOWN_ERROR);
			if (lastException == null)
			{
				lastException = ex;
			}
			return (IntPtr)0;
		}
	}

	[MonoPInvokeCallback(typeof(UnityTls.unitytls_tlsctx_x509verify_callback))]
	private unsafe static UnityTls.unitytls_x509verify_result VerifyCallback(void* userData, UnityTls.unitytls_x509list_ref chain, UnityTls.unitytls_errorstate* errorState)
	{
		return ((UnityTlsContext)((GCHandle)(IntPtr)userData).Target).VerifyCallback(chain, errorState);
	}

	private unsafe UnityTls.unitytls_x509verify_result VerifyCallback(UnityTls.unitytls_x509list_ref chain, UnityTls.unitytls_errorstate* errorState)
	{
		try
		{
			using X509ChainImplUnityTls impl = new X509ChainImplUnityTls(chain);
			using X509Chain x509Chain = new X509Chain(impl);
			remoteCertificate = x509Chain.ChainElements[0].Certificate;
			if (ValidateCertificate(remoteCertificate, x509Chain))
			{
				return UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_SUCCESS;
			}
			return UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_NOT_TRUSTED;
		}
		catch (Exception ex)
		{
			if (lastException == null)
			{
				lastException = ex;
			}
			return UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FATAL_ERROR;
		}
	}

	[MonoPInvokeCallback(typeof(UnityTls.unitytls_tlsctx_certificate_callback))]
	private unsafe static void CertificateCallback(void* userData, UnityTls.unitytls_tlsctx* ctx, byte* cn, IntPtr cnLen, UnityTls.unitytls_x509name* caList, IntPtr caListLen, UnityTls.unitytls_x509list_ref* chain, UnityTls.unitytls_key_ref* key, UnityTls.unitytls_errorstate* errorState)
	{
		((UnityTlsContext)((GCHandle)(IntPtr)userData).Target).CertificateCallback(ctx, cn, cnLen, caList, caListLen, chain, key, errorState);
	}

	private unsafe void CertificateCallback(UnityTls.unitytls_tlsctx* ctx, byte* cn, IntPtr cnLen, UnityTls.unitytls_x509name* caList, IntPtr caListLen, UnityTls.unitytls_x509list_ref* chain, UnityTls.unitytls_key_ref* key, UnityTls.unitytls_errorstate* errorState)
	{
		try
		{
			if (remoteCertificate == null)
			{
				throw new TlsException(AlertDescription.InternalError, "Cannot request client certificate before receiving one from the server.");
			}
			localClientCertificate = SelectClientCertificate(null);
			if (localClientCertificate == null)
			{
				*chain = new UnityTls.unitytls_x509list_ref
				{
					handle = UnityTls.NativeInterface.UNITYTLS_INVALID_HANDLE
				};
				*key = new UnityTls.unitytls_key_ref
				{
					handle = UnityTls.NativeInterface.UNITYTLS_INVALID_HANDLE
				};
			}
			else
			{
				UnityTls.NativeInterface.unitytls_x509list_free(requestedClientCertChain);
				UnityTls.NativeInterface.unitytls_key_free(requestedClientKey);
				ExtractNativeKeyAndChainFromManagedCertificate(localClientCertificate, errorState, out requestedClientCertChain, out requestedClientKey);
				*chain = UnityTls.NativeInterface.unitytls_x509list_get_ref(requestedClientCertChain, errorState);
				*key = UnityTls.NativeInterface.unitytls_key_get_ref(requestedClientKey, errorState);
			}
			Debug.CheckAndThrow(*errorState, "Failed to retrieve certificates on request.", AlertDescription.HandshakeFailure);
		}
		catch (Exception ex)
		{
			UnityTls.NativeInterface.unitytls_errorstate_raise_error(errorState, UnityTls.unitytls_error_code.UNITYTLS_USER_UNKNOWN_ERROR);
			if (lastException == null)
			{
				lastException = ex;
			}
		}
	}
}
