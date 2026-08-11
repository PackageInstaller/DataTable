namespace Ase;

public static class SDKHelper
{
	public static ISDKService CreateSDKService()
	{
		return new AndroidSDKService();
	}
}
