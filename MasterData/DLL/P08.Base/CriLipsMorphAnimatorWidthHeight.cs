using System;
using UnityEngine;

[Serializable]
public class CriLipsMorphAnimatorWidthHeight : ICriLipsMorph
{
	[SerializeField]
	public int lipHeightStateHash;

	[SerializeField]
	public int lipWidthOpenStateHash;

	[SerializeField]
	public int lipWidthCloseStateHash;

	[SerializeField]
	public int tongueUpStateHash;

	[field: SerializeField]
	private Animator target { get; set; }

	public Animator Target
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
		float a = 0f;
		float a2 = 0f;
		if (info.lipWidth > SilenceInfo.lipWidth)
		{
			a = (info.lipWidth - SilenceInfo.lipWidth) / (1f - SilenceInfo.lipWidth);
		}
		else
		{
			a2 = (SilenceInfo.lipWidth - info.lipWidth) / SilenceInfo.lipWidth;
		}
		Target.PlaySafety(lipHeightStateHash, -1, Mathf.Max(0.001f, Mathf.Min(info.lipHeight, 1f)));
		Target.PlaySafety(lipWidthOpenStateHash, -1, Mathf.Max(0.001f, Mathf.Min(a, 1f)));
		Target.PlaySafety(lipWidthCloseStateHash, -1, Mathf.Max(0.001f, Mathf.Min(a2, 1f)));
		Target.PlaySafety(tongueUpStateHash, -1, Mathf.Max(0.001f, Mathf.Min(info.tonguePosition, 1f)));
	}

	public void Reset()
	{
	}

	public void Update(ref CriLipsMouth.Info info, ref CriLipsMouth.MorphTargetBlendAmountAsJapanese blendAmount)
	{
	}
}
