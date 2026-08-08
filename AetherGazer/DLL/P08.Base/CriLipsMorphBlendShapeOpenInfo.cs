using System;
using UnityEngine;

[Serializable]
public class CriLipsMorphBlendShapeOpenInfo : ICriLipsMorph
{
	[SerializeField]
	public int index;

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
		analyzeModule.GetOpenInfo(out var openInfo);
		Target.SetBlendShapeWeightSafety(index, openInfo.openY * 100f);
	}

	public void Reset()
	{
		Target.SetBlendShapeWeightSafety(index, 0f);
	}

	public void Update(ref CriLipsMouth.Info info, ref CriLipsMouth.MorphTargetBlendAmountAsJapanese blendAmount)
	{
	}
}
