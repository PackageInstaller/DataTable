using System;
using System.Linq;

namespace UnityEngine.Rendering.Universal;

internal static class CameraTypeUtility
{
	private static string[] s_CameraTypeNames = Enum.GetNames(typeof(CameraRenderType)).ToArray();

	public static string GetName(this CameraRenderType type)
	{
		int num = (int)type;
		if (num < 0 || num >= s_CameraTypeNames.Length)
		{
			num = 0;
		}
		return s_CameraTypeNames[num];
	}
}
