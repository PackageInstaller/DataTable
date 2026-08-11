using Mono.Security.X509;

namespace System.Security.Cryptography.X509Certificates;

internal static class X509Helper2
{
	[MonoTODO("Investigate replacement; see comments in source.")]
	internal static X509Certificate GetMonoCertificate(X509Certificate2 certificate)
	{
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Expected O, but got Unknown
		if (!(certificate.Impl is X509Certificate2ImplMono x509Certificate2ImplMono))
		{
			return new X509Certificate(certificate.RawData);
		}
		return x509Certificate2ImplMono.MonoCertificate;
	}

	internal static X509ChainImpl CreateChainImpl(bool useMachineContext)
	{
		return new X509ChainImplMono(useMachineContext);
	}

	public static bool IsValid(X509ChainImpl impl)
	{
		return impl?.IsValid ?? false;
	}

	internal static void ThrowIfContextInvalid(X509ChainImpl impl)
	{
		if (!IsValid(impl))
		{
			throw GetInvalidChainContextException();
		}
	}

	internal static Exception GetInvalidChainContextException()
	{
		return new CryptographicException(Locale.GetText("Chain instance is empty."));
	}
}
