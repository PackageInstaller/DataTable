using UnityEngine;

namespace Unity.VisualScripting;

public static class PlatformUtility
{
	public static readonly bool supportsJit;

	static PlatformUtility()
	{
		supportsJit = CheckJitSupport();
	}

	private static bool CheckJitSupport()
	{
		return false;
	}

	public static bool IsEditor(this RuntimePlatform platform)
	{
		if (platform != RuntimePlatform.WindowsEditor && platform != RuntimePlatform.OSXEditor)
		{
			return platform == RuntimePlatform.LinuxEditor;
		}
		return true;
	}

	public static bool IsStandalone(this RuntimePlatform platform)
	{
		if (platform != RuntimePlatform.WindowsPlayer && platform != RuntimePlatform.OSXPlayer)
		{
			return platform == RuntimePlatform.LinuxPlayer;
		}
		return true;
	}
}
