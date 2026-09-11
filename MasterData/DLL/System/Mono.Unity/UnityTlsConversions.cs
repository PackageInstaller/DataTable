using System.Net.Security;
using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;
using Mono.Security.Interface;

namespace Mono.Unity;

internal static class UnityTlsConversions
{
	public static UnityTls.unitytls_protocol GetMinProtocol(SslProtocols protocols)
	{
		if (protocols.HasFlag(SslProtocols.Tls))
		{
			return UnityTls.unitytls_protocol.UNITYTLS_PROTOCOL_TLS_1_0;
		}
		if (protocols.HasFlag(SslProtocols.Tls11))
		{
			return UnityTls.unitytls_protocol.UNITYTLS_PROTOCOL_TLS_1_1;
		}
		if (protocols.HasFlag(SslProtocols.Tls12))
		{
			return UnityTls.unitytls_protocol.UNITYTLS_PROTOCOL_TLS_1_2;
		}
		return UnityTls.unitytls_protocol.UNITYTLS_PROTOCOL_TLS_1_0;
	}

	public static UnityTls.unitytls_protocol GetMaxProtocol(SslProtocols protocols)
	{
		if (protocols.HasFlag(SslProtocols.Tls12))
		{
			return UnityTls.unitytls_protocol.UNITYTLS_PROTOCOL_TLS_1_2;
		}
		if (protocols.HasFlag(SslProtocols.Tls11))
		{
			return UnityTls.unitytls_protocol.UNITYTLS_PROTOCOL_TLS_1_1;
		}
		if (protocols.HasFlag(SslProtocols.Tls))
		{
			return UnityTls.unitytls_protocol.UNITYTLS_PROTOCOL_TLS_1_0;
		}
		return UnityTls.unitytls_protocol.UNITYTLS_PROTOCOL_TLS_1_2;
	}

	public static TlsProtocols ConvertProtocolVersion(UnityTls.unitytls_protocol protocol)
	{
		return protocol switch
		{
			UnityTls.unitytls_protocol.UNITYTLS_PROTOCOL_TLS_1_0 => TlsProtocols.Tls10, 
			UnityTls.unitytls_protocol.UNITYTLS_PROTOCOL_TLS_1_1 => TlsProtocols.Tls11, 
			UnityTls.unitytls_protocol.UNITYTLS_PROTOCOL_TLS_1_2 => TlsProtocols.Tls12, 
			UnityTls.unitytls_protocol.UNITYTLS_PROTOCOL_INVALID => TlsProtocols.Zero, 
			_ => TlsProtocols.Zero, 
		};
	}

	public static AlertDescription VerifyResultToAlertDescription(UnityTls.unitytls_x509verify_result verifyResult, AlertDescription defaultAlert = AlertDescription.InternalError)
	{
		if (verifyResult == UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FATAL_ERROR)
		{
			return AlertDescription.CertificateUnknown;
		}
		if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_EXPIRED))
		{
			return AlertDescription.CertificateExpired;
		}
		if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_REVOKED))
		{
			return AlertDescription.CertificateRevoked;
		}
		if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_CN_MISMATCH))
		{
			return AlertDescription.UnknownCA;
		}
		if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_NOT_TRUSTED))
		{
			return AlertDescription.CertificateUnknown;
		}
		if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_USER_ERROR1))
		{
			return AlertDescription.UserCancelled;
		}
		if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_USER_ERROR2))
		{
			return AlertDescription.UserCancelled;
		}
		if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_USER_ERROR2))
		{
			return AlertDescription.UserCancelled;
		}
		if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_USER_ERROR3))
		{
			return AlertDescription.UserCancelled;
		}
		if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_USER_ERROR4))
		{
			return AlertDescription.UserCancelled;
		}
		if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_USER_ERROR5))
		{
			return AlertDescription.UserCancelled;
		}
		if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_USER_ERROR6))
		{
			return AlertDescription.UserCancelled;
		}
		if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_USER_ERROR7))
		{
			return AlertDescription.UserCancelled;
		}
		if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_USER_ERROR8))
		{
			return AlertDescription.UserCancelled;
		}
		return defaultAlert;
	}

	public static SslPolicyErrors VerifyResultToPolicyErrror(UnityTls.unitytls_x509verify_result verifyResult)
	{
		switch (verifyResult)
		{
		case UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_SUCCESS:
			return SslPolicyErrors.None;
		case UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FATAL_ERROR:
			return SslPolicyErrors.RemoteCertificateChainErrors;
		default:
		{
			SslPolicyErrors sslPolicyErrors = SslPolicyErrors.None;
			if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_CN_MISMATCH))
			{
				sslPolicyErrors |= SslPolicyErrors.RemoteCertificateNameMismatch;
			}
			if (verifyResult != UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_CN_MISMATCH)
			{
				sslPolicyErrors |= SslPolicyErrors.RemoteCertificateChainErrors;
			}
			return sslPolicyErrors;
		}
		}
	}

	public static X509ChainStatusFlags VerifyResultToChainStatus(UnityTls.unitytls_x509verify_result verifyResult)
	{
		switch (verifyResult)
		{
		case UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_SUCCESS:
			return X509ChainStatusFlags.NoError;
		case UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FATAL_ERROR:
			return X509ChainStatusFlags.UntrustedRoot;
		default:
		{
			X509ChainStatusFlags x509ChainStatusFlags = X509ChainStatusFlags.NoError;
			if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_EXPIRED))
			{
				x509ChainStatusFlags |= X509ChainStatusFlags.NotTimeValid;
			}
			if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_REVOKED))
			{
				x509ChainStatusFlags |= X509ChainStatusFlags.Revoked;
			}
			if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_CN_MISMATCH))
			{
				x509ChainStatusFlags |= X509ChainStatusFlags.UntrustedRoot;
			}
			if (verifyResult.HasFlag(UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_FLAG_NOT_TRUSTED))
			{
				x509ChainStatusFlags |= X509ChainStatusFlags.UntrustedRoot;
			}
			return x509ChainStatusFlags;
		}
		}
	}
}
