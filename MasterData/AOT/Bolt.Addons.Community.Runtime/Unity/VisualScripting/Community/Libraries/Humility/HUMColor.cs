using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMColor
{
	private static Dictionary<Color, Texture2D> coloredTextures = new Dictionary<Color, Texture2D>();

	public static Color Between(Color start, Color end, int amount, int index)
	{
		Color color = new Color((end.r - start.r) / (float)amount, (end.g - start.g) / (float)amount, (end.b - start.b) / (float)amount);
		if (index == 0)
		{
			return start;
		}
		return start + color * (index + 1);
	}

	public static Color Between(Color start, Color end)
	{
		return Between(start, end, 3, 1);
	}

	public static Color Grey(float percent)
	{
		return new Color(percent, percent, percent);
	}

	public static Color Darken(this Color value, float percent)
	{
		return new Color(value.r - percent, value.g - percent, value.b - percent);
	}

	public static Color Brighten(this Color value, float percent)
	{
		return new Color(value.r + percent, value.g + percent, value.b + percent);
	}

	public static Color Mix(this Color value, Color other)
	{
		return new Color((value.r + other.r) / 2f, (value.g + other.g) / 2f, (value.b + other.b) / 2f);
	}

	public static Color Blend(this Color value, Color other, float percent)
	{
		return new Color((value.r + other.r * percent) / 2f, (value.g + other.g * percent) / 2f, (value.b + other.b * percent) / 2f);
	}

	public static Color Multiply(this Color value, float percent)
	{
		return new Color(value.r * percent, value.g * percent, value.b * percent);
	}

	public static Color Divide(this Color value, float percent)
	{
		return new Color(value.r / percent, value.g / percent, value.b / percent);
	}

	public static void CacheTexture(this Color color, ref Texture2D texture)
	{
		if (texture == null)
		{
			texture = new Texture2D(1, 1);
			texture.SetPixel(0, 0, color);
			texture.Apply();
		}
	}

	public static Texture2D CacheTexture(this Color color)
	{
		if (coloredTextures.ContainsKey(color))
		{
			if (coloredTextures[color] == null)
			{
				coloredTextures[color] = HUMTexture.Create(1, 1).Color(color);
			}
		}
		else
		{
			coloredTextures.Add(color, HUMTexture.Create(1, 1).Color(color));
		}
		return coloredTextures[color];
	}
}
