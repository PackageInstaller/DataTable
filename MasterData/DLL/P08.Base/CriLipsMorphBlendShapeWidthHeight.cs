using System;
using UnityEngine;

[Serializable]
public class CriLipsMorphBlendShapeWidthHeight : ICriLipsMorph
{
	[SerializeField]
	public int lipHeightIndex;

	[SerializeField]
	public int lipWidthOpenIndex;

	[SerializeField]
	public int lipWidthCloseIndex;

	[SerializeField]
	public int tongueUpIndex;

	[field: SerializeField]
	private SkinnedMeshRenderer target { get; set; }

	public SkinnedMeshRenderer Target
	{
		get
		{
			return target;
		}
		set
		{
			target = value;
		}
	}

	public CriLipsMouth.Info SilenceInfo { get; set; }

	public void Update(ICriLipsAnalyzeModule analyzeModule)
	{
		analyzeModule.GetInfo(out var info);
		float num = 0f;
		float num2 = 0f;
		if (info.lipWidth > SilenceInfo.lipWidth)
		{
			num = (info.lipWidth - SilenceInfo.lipWidth) / (1f - SilenceInfo.lipWidth);
		}
		else
		{
			num2 = (SilenceInfo.lipWidth - info.lipWidth) / SilenceInfo.lipWidth;
		}
		Target.SetBlendShapeWeightSafety(lipHeightIndex, info.lipHeight * 100f);
		Target.SetBlendShapeWeightSafety(lipWidthOpenIndex, num * 100f);
		Target.SetBlendShapeWeightSafety(lipWidthCloseIndex, num2 * 100f);
		Target.SetBlendShapeWeightSafety(tongueUpIndex, info.tonguePosition * 100f);
	}

	public void Reset()
	{
		Target.SetBlendShapeWeightSafety(lipHeightIndex, SilenceInfo.lipHeight * 100f);
		Target.SetBlendShapeWeightSafety(lipWidthOpenIndex, 0f);
		Target.SetBlendShapeWeightSafety(lipWidthCloseIndex, 0f);
		Target.SetBlendShapeWeightSafety(tongueUpIndex, SilenceInfo.tonguePosition * 100f);
	}

	public void Update(ref CriLipsMouth.Info info, ref CriLipsMouth.MorphTargetBlendAmountAsJapanese blendAmount)
	{
	}
}
