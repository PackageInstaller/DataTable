using Mono.Security.Interface;

namespace Mono.Unity;

internal static class Debug
{
	public static void CheckAndThrow(UnityTls.unitytls_errorstate errorState, string context, AlertDescription defaultAlert = (AlertDescription)80)
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		if (errorState.code == UnityTls.unitytls_error_code.UNITYTLS_SUCCESS)
		{
			return;
		}
		string text = $"{context} - error code: {errorState.code}";
		throw new TlsException(defaultAlert, text);
	}

	public static void CheckAndThrow(UnityTls.unitytls_errorstate errorState, UnityTls.unitytls_x509verify_result verifyResult, string context, AlertDescription defaultAlert = (AlertDescription)80)
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		if (verifyResult == UnityTls.unitytls_x509verify_result.UNITYTLS_X509VERIFY_SUCCESS)
		{
			CheckAndThrow(errorState, context, defaultAlert);
			return;
		}
		AlertDescription val = UnityTlsConversions.VerifyResultToAlertDescription(verifyResult, defaultAlert);
		string text = $"{context} - error code: {errorState.code}, verify result: {verifyResult}";
		throw new TlsException(val, text);
	}
}
