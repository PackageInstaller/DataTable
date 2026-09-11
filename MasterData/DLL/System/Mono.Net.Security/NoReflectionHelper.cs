namespace Mono.Net.Security;

internal static class NoReflectionHelper
{
	internal static object GetProvider()
	{
		return MonoTlsProviderFactory.GetProvider();
	}
}
