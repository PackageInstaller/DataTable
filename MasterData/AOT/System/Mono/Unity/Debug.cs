using Mono.Security.Interface;

namespace Mono.Unity;

internal static class Debug
{
	public static void CheckAndThrow(UnityTls.unitytls_errorstate errorState, string context, AlertDescription defaultAlert = AlertDescription.InternalError)
	{
		if (errorState.code == UnityTls.unitytls_error_code.UNITYTLS_SUCCESS)
		{
			return;
		}
		string message = $"{context} - error code: {errorState.code}";
		throw new TlsException(defaultAlert, message);
	}

	public static void CheckAndThrow(UnityTls.unitytls_errorstate errorState, UnityTls.unitytls_x509verify_result verifyResult, string context, AlertDescription defaultAlert = AlertDescription.InternalError)
	{
		if (verifyResult == UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_SUCCESS)
		{
			CheckAndThrow(errorState, context, defaultAlert);
			return;
		}
		AlertDescription description = UnityTlsConversions.VerifyResultToAlertDescription(verifyResult, defaultAlert);
		string message = $"{context} - error code: {errorState.code}, verify result: {verifyResult}";
		throw new TlsException(description, message);
	}
}
