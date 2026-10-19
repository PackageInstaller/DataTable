using UnityEngine;

namespace ACT.UI;

public static class MaterialOps
{
	public static bool SupportsSoftMask(this Material mat)
	{
		return mat.HasProperty("_SoftMask");
	}

	public static bool HasDefaultUIShader(this Material mat)
	{
		return mat.shader == Canvas.GetDefaultCanvasMaterial().shader;
	}

	public static bool HasDefaultETC1UIShader(this Material mat)
	{
		return mat.shader == Canvas.GetETC1SupportedCanvasMaterial().shader;
	}

	public static bool IsMapBackGround(this Material mat)
	{
		return mat.shader.name == "Unlit/MapBackGround";
	}

	public static bool IsMistyMap(this Material mat)
	{
		return mat.shader.name == "UI/MistyMap";
	}

	public static bool UseSoftMask(this Material mat)
	{
		return mat.HasProperty("_SoftMask");
	}

	public static void EnableKeyword(this Material mat, string keyword, bool enabled)
	{
		if (enabled)
		{
			mat.EnableKeyword(keyword);
		}
		else
		{
			mat.DisableKeyword(keyword);
		}
	}
}
