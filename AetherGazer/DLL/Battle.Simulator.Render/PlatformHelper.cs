using UnityEngine;

public static class PlatformHelper
{
	public static bool IsPC()
	{
		if (Application.isMobilePlatform || Application.isConsolePlatform)
		{
			return false;
		}
		switch (Application.platform)
		{
		case RuntimePlatform.WindowsPlayer:
		case RuntimePlatform.WindowsEditor:
		case RuntimePlatform.LinuxPlayer:
		case RuntimePlatform.LinuxEditor:
			return true;
		default:
			return false;
		}
	}
}
