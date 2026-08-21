using System;
using System.Collections.Generic;
using System.Globalization;
using UnityEngine;

namespace ParadoxNotion;

public static class ColorUtils
{
	private static Dictionary<Color32, string> colorHexCache = new Dictionary<Color32, string>();

	private static Dictionary<string, Color> hexColorCache = new Dictionary<string, Color>(StringComparer.OrdinalIgnoreCase);

	public static Color WithAlpha(this Color color, float alpha)
	{
		color.a = alpha;
		return color;
	}

	public static Color Grey(float value)
	{
		return new Color(value, value, value, 1f);
	}

	public static string ColorToHex(Color32 color)
	{
		if (colorHexCache.TryGetValue(color, out var value))
		{
			return value;
		}
		value = ("#" + color.r.ToString("X2") + color.g.ToString("X2") + color.b.ToString("X2")).ToUpper();
		return colorHexCache[color] = value;
	}

	public static Color HexToColor(string hex)
	{
		if (hexColorCache.TryGetValue(hex, out var value))
		{
			return value;
		}
		if (hex.Length != 6)
		{
			throw new Exception("Invalid length for hex color provided");
		}
		byte r = byte.Parse(hex.Substring(0, 2), NumberStyles.HexNumber);
		byte g = byte.Parse(hex.Substring(2, 2), NumberStyles.HexNumber);
		byte b = byte.Parse(hex.Substring(4, 2), NumberStyles.HexNumber);
		value = new Color32(r, g, b, byte.MaxValue);
		return hexColorCache[hex] = value;
	}
}
