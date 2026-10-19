using System.Text.RegularExpressions;
using UnityEngine;

namespace ACT.Tool.VertexChange;

public static class SVTXPainterUtils
{
	public static Mesh GetMesh(GameObject aGO)
	{
		Mesh result = null;
		if ((bool)aGO)
		{
			MeshFilter component = aGO.GetComponent<MeshFilter>();
			SkinnedMeshRenderer component2 = aGO.GetComponent<SkinnedMeshRenderer>();
			if ((bool)component && !component2)
			{
				result = component.sharedMesh;
			}
			if (!component && (bool)component2)
			{
				result = component2.sharedMesh;
			}
		}
		return result;
	}

	public static float LinearFalloff(float distance, float brushRadius)
	{
		return Mathf.Clamp01(1f - distance / brushRadius);
	}

	public static Color VTXColorLerp(Color colorA, Color colorB, float value)
	{
		if (value > 1f)
		{
			return colorB;
		}
		if (value < 0f)
		{
			return colorA;
		}
		return new Color(colorA.r + (colorB.r - colorA.r) * value, colorA.g + (colorB.g - colorA.g) * value, colorA.b + (colorB.b - colorA.b) * value, colorA.a + (colorB.a - colorA.a) * value);
	}

	public static Color VTXOneChannelLerp(Color colorA, float intensity, float value, PaintType channel)
	{
		switch (channel)
		{
		case PaintType.R:
			if (value > 1f)
			{
				return new Color(intensity, colorA.g, colorA.b, colorA.a);
			}
			if (value < 0f)
			{
				return colorA;
			}
			return new Color(colorA.r + (intensity - colorA.r) * value, colorA.g, colorA.b, colorA.a);
		case PaintType.G:
			if (value > 1f)
			{
				return new Color(colorA.r, intensity, colorA.b, colorA.a);
			}
			if (value < 0f)
			{
				return colorA;
			}
			return new Color(colorA.r, colorA.g + (intensity - colorA.g) * value, colorA.b, colorA.a);
		case PaintType.B:
			if (value > 1f)
			{
				return new Color(colorA.r, colorA.g, intensity, colorA.a);
			}
			if (value < 0f)
			{
				return colorA;
			}
			return new Color(colorA.r, colorA.g, colorA.b + (intensity - colorA.b) * value, colorA.a);
		case PaintType.A:
			if (value > 1f)
			{
				return new Color(colorA.r, colorA.g, colorA.b, intensity);
			}
			if (value < 0f)
			{
				return colorA;
			}
			return new Color(colorA.r, colorA.g, colorA.b, colorA.a + (intensity - colorA.a) * value);
		default:
			return Color.cyan;
		}
	}

	public static string SanitizeForFileName(string name)
	{
		return new Regex("[\\/:\\*\\?<>\\|\\\"]").Replace(name, "_");
	}
}
