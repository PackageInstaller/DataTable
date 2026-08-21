using System;
using System.Globalization;
using UnityEngine;

namespace Sirenix.Utilities;

public static class ColorExtensions
{
	private static readonly char[] trimRGBStart = new char[9] { 'R', 'r', 'G', 'g', 'B', 'b', 'A', 'a', '(' };

	public static Color Lerp(this Color[] colors, float t)
	{
		t = Mathf.Clamp(t, 0f, 1f) * (float)(colors.Length - 1);
		int num = (int)t;
		int num2 = Mathf.Min((int)t + 1, colors.Length - 1);
		return Color.Lerp(colors[num], colors[num2], t - (float)(int)t);
	}

	public static Color MoveTowards(this Color from, Color to, float maxDelta)
	{
		Color result = new Color
		{
			r = Mathf.MoveTowards(from.r, to.r, maxDelta),
			g = Mathf.MoveTowards(from.g, to.g, maxDelta),
			b = Mathf.MoveTowards(from.b, to.b, maxDelta),
			a = Mathf.MoveTowards(from.a, to.a, maxDelta)
		};
		from.r = result.r;
		from.g = result.g;
		from.b = result.b;
		from.a = result.a;
		return result;
	}

	public static bool TryParseString(string colorStr, out Color color)
	{
		color = default(Color);
		if (colorStr == null || colorStr.Length < 2 || colorStr.Length > 100)
		{
			return false;
		}
		if (colorStr.StartsWith("new Color", StringComparison.InvariantCulture))
		{
			colorStr = colorStr.Substring("new Color".Length, colorStr.Length - "new Color".Length).Replace("f", "");
		}
		bool flag = colorStr[0] == '#' || char.IsLetter(colorStr[0]) || char.IsNumber(colorStr[0]);
		bool flag2 = colorStr[0] == 'R' || colorStr[0] == '(' || char.IsNumber(colorStr[0]);
		if (!flag && !flag2)
		{
			return false;
		}
		bool flag3 = false;
		if (flag2 || ((flag && !(flag3 = ColorUtility.TryParseHtmlString(colorStr, out color))) & flag2))
		{
			colorStr = colorStr.TrimStart(trimRGBStart).TrimEnd(new char[1] { ')' });
			string[] array = colorStr.Split(new char[1] { ',' });
			if (array.Length < 2 || array.Length > 4)
			{
				return false;
			}
			Color color2 = new Color(0f, 0f, 0f, 1f);
			for (int i = 0; i < array.Length; i++)
			{
				if (!float.TryParse(array[i], out var result))
				{
					return false;
				}
				if (i == 0)
				{
					color2.r = result;
				}
				if (i == 1)
				{
					color2.g = result;
				}
				if (i == 2)
				{
					color2.b = result;
				}
				if (i == 3)
				{
					color2.a = result;
				}
			}
			color = color2;
			return true;
		}
		if (flag3)
		{
			return true;
		}
		return false;
	}

	public static string ToCSharpColor(this Color color)
	{
		return "new Color(" + TrimFloat(color.r) + "f, " + TrimFloat(color.g) + "f, " + TrimFloat(color.b) + "f, " + TrimFloat(color.a) + "f)";
	}

	public static Color Pow(this Color color, float factor)
	{
		color.r = Mathf.Pow(color.r, factor);
		color.g = Mathf.Pow(color.g, factor);
		color.b = Mathf.Pow(color.b, factor);
		color.a = Mathf.Pow(color.a, factor);
		return color;
	}

	public static Color NormalizeRGB(this Color color)
	{
		Vector3 normalized = new Vector3(color.r, color.g, color.b).normalized;
		color.r = normalized.x;
		color.g = normalized.y;
		color.b = normalized.z;
		return color;
	}

	private static string TrimFloat(float value)
	{
		string text = value.ToString("F3", CultureInfo.InvariantCulture).TrimEnd(new char[1] { '0' });
		char c = text[text.Length - 1];
		if (c == '.' || c == ',')
		{
			text = text.Substring(0, text.Length - 1);
		}
		return text;
	}
}
