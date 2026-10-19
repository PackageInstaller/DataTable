using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle.Configs;

public class CurveLibrary : ScriptableObject
{
	public const uint DissolveEmission1ColorId = 0u;

	public const uint DissolveEmission2ColorId = 1u;

	public const uint DevourborneDieColorId = 2u;

	public List<CurveItem> curves;

	public List<GradientItem> gradients;

	public List<ColorItem> colors = new List<ColorItem>();

	public List<MatOverrideStruct> matOverrides;

	public AnimationCurve GetCurve(uint id)
	{
		for (int i = 0; i < curves.Count; i++)
		{
			CurveItem curveItem = curves[i];
			if (curveItem.id == id)
			{
				return curveItem.curve;
			}
		}
		return curves[0].curve;
	}

	public Gradient GetGradient(uint id)
	{
		for (int i = 0; i < gradients.Count; i++)
		{
			GradientItem gradientItem = gradients[i];
			if (gradientItem.id == id)
			{
				return gradientItem.gradient;
			}
		}
		return gradients[0].gradient;
	}

	public Color GetColor(uint id)
	{
		if (colors != null)
		{
			for (int i = 0; i < colors.Count; i++)
			{
				ColorItem colorItem = colors[i];
				if (colorItem.id == id)
				{
					return colorItem.color;
				}
			}
		}
		if (colors != null && colors.Count > 0)
		{
			return colors[0].color;
		}
		return default;
	}
}
