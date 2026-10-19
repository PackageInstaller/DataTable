using System;
using UnityEngine;

namespace ACT.Utility;

public static class ColorParseUtility
{
	public static Color HexToColor(string hexColor)
	{
		if (string.IsNullOrEmpty(hexColor))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("ColorUtility: 输入的十六进制颜色字符串为空");
			}
			return Color.white;
		}
		string text = hexColor.TrimStart('#');
		if (text.Length != 6 && text.Length != 8)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("ColorUtility: 无效的十六进制颜色格式: " + hexColor + "，长度应为6位(RGB)或8位(RGBA)");
			}
			return Color.white;
		}
		if (!IsValidHexString(text))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("ColorUtility: 无效的十六进制颜色格式: " + hexColor);
			}
			return Color.white;
		}
		try
		{
			float r = HexToFloat(text.Substring(0, 2));
			float g = HexToFloat(text.Substring(2, 2));
			float b = HexToFloat(text.Substring(4, 2));
			float a = ((text.Length == 8) ? HexToFloat(text.Substring(6, 2)) : 1f);
			return new Color(r, g, b, a);
		}
		catch (Exception ex)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("ColorUtility: 转换颜色时发生错误: " + ex.Message);
			}
			return Color.white;
		}
	}

	public static string ColorToHex(Color color, bool includeAlpha = true, bool includeHash = true)
	{
		string text = FloatToHex(color.r);
		string text2 = FloatToHex(color.g);
		string text3 = FloatToHex(color.b);
		string text4 = (includeAlpha ? FloatToHex(color.a) : "");
		string text5 = text + text2 + text3 + text4;
		if (!includeHash)
		{
			return text5;
		}
		return "#" + text5;
	}

	private static float HexToFloat(string hex)
	{
		return (float)Convert.ToInt32(hex, 16) / 255f;
	}

	private static string FloatToHex(float value)
	{
		return Mathf.RoundToInt(value * 255f).ToString("X2");
	}

	private static bool IsValidHexString(string hex)
	{
		if (string.IsNullOrEmpty(hex))
		{
			return false;
		}
		foreach (char c in hex)
		{
			if ((c < '0' || c > '9') && (c < 'A' || c > 'F') && (c < 'a' || c > 'f'))
			{
				return false;
			}
		}
		return true;
	}

	public static bool TryHexToColor(string hexColor, out Color color)
	{
		color = Color.white;
		if (string.IsNullOrEmpty(hexColor))
		{
			return false;
		}
		string text = hexColor.TrimStart('#');
		if (text.Length != 6 && text.Length != 8)
		{
			return false;
		}
		if (!IsValidHexString(text))
		{
			return false;
		}
		try
		{
			float r = HexToFloat(text.Substring(0, 2));
			float g = HexToFloat(text.Substring(2, 2));
			float b = HexToFloat(text.Substring(4, 2));
			float a = ((text.Length == 8) ? HexToFloat(text.Substring(6, 2)) : 1f);
			color = new Color(r, g, b, a);
			return true;
		}
		catch
		{
			return false;
		}
	}
}
