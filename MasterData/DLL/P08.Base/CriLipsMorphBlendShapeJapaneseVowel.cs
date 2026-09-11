using System;
using UnityEngine;

[Serializable]
public class CriLipsMorphBlendShapeJapaneseVowel : ICriLipsMorph
{
	[SerializeField]
	public int aIndex;

	[SerializeField]
	public int iIndex;

	[SerializeField]
	public int uIndex;

	[SerializeField]
	public int eIndex;

	[SerializeField]
	public int oIndex;

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
		analyzeModule.GetMorphTargetBlendAmountAsJapanese(out var morph);
		Target.SetBlendShapeWeightSafety(aIndex, morph.a * 100f);
		Target.SetBlendShapeWeightSafety(iIndex, morph.i * 100f);
		Target.SetBlendShapeWeightSafety(uIndex, morph.u * 100f);
		Target.SetBlendShapeWeightSafety(eIndex, morph.e * 100f);
		Target.SetBlendShapeWeightSafety(oIndex, morph.o * 100f);
	}

	public void Reset()
	{
		Target.SetBlendShapeWeightSafety(aIndex, 0f);
		Target.SetBlendShapeWeightSafety(iIndex, 0f);
		Target.SetBlendShapeWeightSafety(uIndex, 0f);
		Target.SetBlendShapeWeightSafety(eIndex, 0f);
		Target.SetBlendShapeWeightSafety(oIndex, 0f);
	}

	public void Update(ref CriLipsMouth.Info info, ref CriLipsMouth.MorphTargetBlendAmountAsJapanese blendAmount)
	{
	}
}
