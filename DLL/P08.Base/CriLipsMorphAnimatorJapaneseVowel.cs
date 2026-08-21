using System;
using UnityEngine;

[Serializable]
public class CriLipsMorphAnimatorJapaneseVowel : ICriLipsMorph
{
	[SerializeField]
	public int aStateHash;

	[SerializeField]
	public int iStateHash;

	[SerializeField]
	public int uStateHash;

	[SerializeField]
	public int eStateHash;

	[SerializeField]
	public int oStateHash;

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
		analyzeModule.GetMorphTargetBlendAmountAsJapanese(out var morph);
		Target.PlaySafety(aStateHash, -1, Mathf.Max(0.001f, Mathf.Min(morph.a, 1f)));
		Target.PlaySafety(iStateHash, -1, Mathf.Max(0.001f, Mathf.Min(morph.i, 1f)));
		Target.PlaySafety(uStateHash, -1, Mathf.Max(0.001f, Mathf.Min(morph.u, 1f)));
		Target.PlaySafety(eStateHash, -1, Mathf.Max(0.001f, Mathf.Min(morph.e, 1f)));
		Target.PlaySafety(oStateHash, -1, Mathf.Max(0.001f, Mathf.Min(morph.o, 1f)));
	}

	public void Reset()
	{
	}

	public void Update(ref CriLipsMouth.Info info, ref CriLipsMouth.MorphTargetBlendAmountAsJapanese blendAmount)
	{
	}
}
