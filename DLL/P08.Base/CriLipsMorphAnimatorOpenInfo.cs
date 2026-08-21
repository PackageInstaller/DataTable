using System;
using UnityEngine;

[Serializable]
public class CriLipsMorphAnimatorOpenInfo : ICriLipsMorph
{
	[SerializeField]
	public int stateHash;

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
		analyzeModule.GetOpenInfo(out var openInfo);
		Target.PlaySafety(stateHash, -1, Mathf.Max(0.001f, Mathf.Min(openInfo.openY, 1f)));
	}

	public void Reset()
	{
	}

	public void Update(ref CriLipsMouth.Info info, ref CriLipsMouth.MorphTargetBlendAmountAsJapanese blendAmount)
	{
	}
}
