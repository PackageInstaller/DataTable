using System.Text.RegularExpressions;
using UnityEngine;

public class BMUtility
{
	public static void Swap<T>(ref T a, ref T b)
	{
		T val = a;
		a = b;
		b = val;
	}

	public static string InterpretPath(string origPath, BuildPlatform platform)
	{
		foreach (Match item in Regex.Matches(origPath, "\\$\\((\\w+)\\)"))
		{
			string value = item.Groups[1].Value;
			origPath = origPath.Replace("$(" + value + ")", EnvVarToString(value, platform));
		}
		return origPath;
	}

	public static int[] long2doubleInt(long a)
	{
		int num = (int)(a & 0xFFFFFFFFu);
		int num2 = (int)(a >> 32);
		return new int[2] { num, num2 };
	}

	public static long doubleInt2long(int a1, int a2)
	{
		return ((long)a2 << 32) | (uint)a1;
	}

	private static string EnvVarToString(string varString, BuildPlatform platform)
	{
		switch (varString)
		{
		case "DataPath":
			return Application.dataPath;
		case "PersistentDataPath":
			return Application.persistentDataPath;
		case "StreamingAssetsPath":
			return Application.streamingAssetsPath;
		case "Platform":
			return platform.ToString();
		default:
			Debug.LogError("Cannot solve enviroment var " + varString);
			return "";
		}
	}
}
