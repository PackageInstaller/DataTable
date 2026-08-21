using UnityEngine;

namespace Sirenix.Utilities;

public static class UnityVersion
{
	public static readonly int Major;

	public static readonly int Minor;

	static UnityVersion()
	{
		string[] array = Application.unityVersion.Split(new char[1] { '.' });
		if (array.Length < 2)
		{
			Debug.LogError("Could not parse current Unity version '" + Application.unityVersion + "'; not enough version elements.");
			return;
		}
		if (!int.TryParse(array[0], out Major))
		{
			Debug.LogError("Could not parse major part '" + array[0] + "' of Unity version '" + Application.unityVersion + "'.");
		}
		if (!int.TryParse(array[1], out Minor))
		{
			Debug.LogError("Could not parse minor part '" + array[1] + "' of Unity version '" + Application.unityVersion + "'.");
		}
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.BeforeSceneLoad)]
	private static void EnsureLoaded()
	{
	}

	public static bool IsVersionOrGreater(int major, int minor)
	{
		if (Major <= major)
		{
			if (Major == major)
			{
				return Minor >= minor;
			}
			return false;
		}
		return true;
	}
}
