using System;
using System.IO;
using System.Net.Security;
using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using Mono.Net.Security;
using Mono.Security.Interface;
using Mono.Util;

namespace Mono.Unity;

internal class UnityTlsProvider : MobileTlsProvider
{
	public override string Name => "unitytls";

	public override Guid ID => Mono.Net.Security.MonoTlsProviderFactory.UnityTlsId;

	public override bool SupportsSslStream => true;

	public override bool SupportsMonoExtensions => true;

	public override bool SupportsConnectionInfo => true;

	internal override bool SupportsCleanShutdown => true;

	public override SslProtocols SupportedProtocols => SslProtocols.Tls | SslProtocols.Tls11 | SslProtocols.Tls12;

	internal override MobileAuthenticatedStream CreateSslStream(SslStream sslStream, Stream innerStream, bool leaveInnerStreamOpen, MonoTlsSettings settings)
	{
		return new UnityTlsStream(innerStream, leaveInnerStreamOpen, sslStream, settings, this);
	}

	[MonoPInvokeCallback(typeof(UnityTls.unitytls_x509verify_callback))]
	private unsafe static UnityTls.unitytls_x509verify_result x509verify_callback(void* userData, UnityTls.unitytls_x509_ref cert, UnityTls.unitytls_x509verify_result result, UnityTls.unitytls_errorstate* errorState)
	{
		if (userData != null)
		{
			UnityTls.NativeInterface.unitytls_x509list_append((UnityTls.unitytls_x509list*)userData, cert, errorState);
		}
		return result;
	}

	internal unsafe override bool ValidateCertificate(ChainValidationHelper validator, string targetHost, bool serverMode, X509CertificateCollection certificates, bool wantsChain, ref X509Chain chain, ref SslPolicyErrors errors, ref int status11)
	{
		UnityTls.unitytls_errorstate unitytls_errorstate = UnityTls.NativeInterface.unitytls_errorstate_create();
		X509ChainImplUnityTls x509ChainImplUnityTls = chain.Impl as X509ChainImplUnityTls;
		if (x509ChainImplUnityTls == null)
		{
			if (certificates == null || certificates.Count == 0)
			{
				errors |= SslPolicyErrors.RemoteCertificateNotAvailable;
				return false;
			}
		}
		else if (UnityTls.NativeInterface.unitytls_x509list_get_x509(x509ChainImplUnityTls.NativeCertificateChain, (IntPtr)0, &unitytls_errorstate).handle == UnityTls.NativeInterface.UNITYTLS_INVALID_HANDLE)
		{
			errors |= SslPolicyErrors.RemoteCertificateNotAvailable;
			return false;
		}
		if (!string.IsNullOrEmpty(targetHost))
		{
			int num = targetHost.IndexOf(':');
			if (num > 0)
			{
				targetHost = targetHost.Substring(0, num);
			}
		}
		else if (targetHost == null)
		{
			targetHost = "";
		}
		UnityTls.unitytls_x509verify_result unitytls_x509verify_result = UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_NOT_DONE;
		UnityTls.unitytls_x509list* ptr = null;
		UnityTls.unitytls_x509list* ptr2 = UnityTls.NativeInterface.unitytls_x509list_create(&unitytls_errorstate);
		try
		{
			UnityTls.unitytls_x509list_ref chain2;
			if (x509ChainImplUnityTls == null)
			{
				ptr = UnityTls.NativeInterface.unitytls_x509list_create(&unitytls_errorstate);
				CertHelper.AddCertificatesToNativeChain(ptr, certificates, &unitytls_errorstate);
				chain2 = UnityTls.NativeInterface.unitytls_x509list_get_ref(ptr, &unitytls_errorstate);
			}
			else
			{
				chain2 = x509ChainImplUnityTls.NativeCertificateChain;
			}
			byte[] bytes = Encoding.UTF8.GetBytes(targetHost);
			if (validator.Settings.TrustAnchors != null)
			{
				UnityTls.unitytls_x509list* ptr3 = null;
				try
				{
					ptr3 = UnityTls.NativeInterface.unitytls_x509list_create(&unitytls_errorstate);
					CertHelper.AddCertificatesToNativeChain(ptr3, validator.Settings.TrustAnchors, &unitytls_errorstate);
					UnityTls.unitytls_x509list_ref trustCA = UnityTls.NativeInterface.unitytls_x509list_get_ref(ptr3, &unitytls_errorstate);
					fixed (byte* cn = bytes)
					{
						unitytls_x509verify_result = UnityTls.NativeInterface.unitytls_x509verify_explicit_ca(chain2, trustCA, cn, (IntPtr)bytes.Length, x509verify_callback, ptr2, &unitytls_errorstate);
					}
				}
				finally
				{
					UnityTls.NativeInterface.unitytls_x509list_free(ptr3);
				}
			}
			else
			{
				fixed (byte* cn2 = bytes)
				{
					unitytls_x509verify_result = UnityTls.NativeInterface.unitytls_x509verify_default_ca(chain2, cn2, (IntPtr)bytes.Length, x509verify_callback, ptr2, &unitytls_errorstate);
				}
			}
		}
		catch
		{
			UnityTls.NativeInterface.unitytls_x509list_free(ptr2);
			throw;
		}
		finally
		{
			UnityTls.NativeInterface.unitytls_x509list_free(ptr);
		}
		chain?.Dispose();
		X509ChainImplUnityTls x509ChainImplUnityTls2 = new X509ChainImplUnityTls(ptr2, &unitytls_errorstate, reverseOrder: true);
		chain = new X509Chain(x509ChainImplUnityTls2);
		errors = UnityTlsConversions.VerifyResultToPolicyErrror(unitytls_x509verify_result);
		x509ChainImplUnityTls2.AddStatus(UnityTlsConversions.VerifyResultToChainStatus(unitytls_x509verify_result));
		if (unitytls_x509verify_result == UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_SUCCESS)
		{
			return unitytls_errorstate.code == UnityTls.unitytls_error_code.UNITYTLS_SUCCESS;
		}
		return false;
	}
}
