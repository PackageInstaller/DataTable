using System;
using UnityEngine;

[Obsolete("Use CriLipsDeformer Component")]
public class CriLipsShape : CriMonoBehaviour
{
	public enum MorphingTargetType
	{
		BlendShape,
		Animation
	}

	public enum BlendShapeType
	{
		WidthHeight,
		JapaneseAIUEO
	}

	public delegate void UserModifyDelegateFunction(ref CriLipsMouth.Info info, ref CriLipsMouth.MorphTargetBlendAmountAsJapanese morph, ICriLipsAnalyzeModule analyzeModule);

	public UserModifyDelegateFunction UserModifyDelegate;

	[SerializeField]
	private MorphingTargetType _morphingTargetType;

	[SerializeField]
	private BlendShapeType _blendShapeType;

	[SerializeField]
	public SkinnedMeshRenderer skinnedMeshRenderer;

	[SerializeField]
	public CriLipsMeshMorph.BlendShapeNameMapping nameMapping;

	[SerializeField]
	public Animator animator;

	[SerializeField]
	public CriLipsMeshMorph.BlendShapeNameMapping animationStateNameMapping;

	protected CriLipsMeshMorph meshMorphing;

	protected CriLipsMouth.Info info;

	protected CriLipsMouth.MorphTargetBlendAmountAsJapanese blendAmount;

	protected ICriLipsAnalyzeModule analyzeModule;

	public MorphingTargetType morphingTargetType
	{
		get
		{
			return _morphingTargetType;
		}
		set
		{
			_morphingTargetType = value;
		}
	}

	public BlendShapeType blendShapeType
	{
		get
		{
			return _blendShapeType;
		}
		set
		{
			_blendShapeType = value;
		}
	}

	protected virtual void StartForMorphing(CriLipsMouth.Info silenceInfo)
	{
		if (skinnedMeshRenderer == null && animator == null)
		{
			return;
		}
		if (meshMorphing != null)
		{
			Debug.LogError("[CRIWARE] There is already existed CriLipsMeshMorph instance.");
			return;
		}
		switch (morphingTargetType)
		{
		case MorphingTargetType.BlendShape:
			if (skinnedMeshRenderer == null)
			{
				Debug.LogError("[CRIWARE] skinnedMeshRenderer is not found.");
			}
			else
			{
				meshMorphing = new CriLipsMeshMorph(skinnedMeshRenderer, nameMapping, silenceInfo.lipWidth);
			}
			break;
		case MorphingTargetType.Animation:
			if (animator == null)
			{
				Debug.LogError("[CRIWARE] animator is not found.");
			}
			else
			{
				meshMorphing = new CriLipsMeshMorph(animator, animationStateNameMapping, silenceInfo.lipWidth);
			}
			break;
		}
	}

	protected virtual void UpdateLipsParamerterForBelndShape(ref CriLipsMouth.Info info)
	{
		if (meshMorphing != null)
		{
			meshMorphing.Update(ref info);
		}
	}

	protected virtual void UpdateLipsParamerterForBelndShape(ref CriLipsMouth.MorphTargetBlendAmountAsJapanese blendAmount)
	{
		if (meshMorphing != null)
		{
			meshMorphing.Update(ref blendAmount);
		}
	}

	protected virtual void UpdateLipsParameter()
	{
		if (UserModifyDelegate != null && analyzeModule != null)
		{
			UserModifyDelegate(ref info, ref blendAmount, analyzeModule);
		}
		switch (blendShapeType)
		{
		case BlendShapeType.WidthHeight:
			UpdateLipsParamerterForBelndShape(ref info);
			break;
		case BlendShapeType.JapaneseAIUEO:
			UpdateLipsParamerterForBelndShape(ref blendAmount);
			break;
		}
	}

	public override void CriInternalUpdate()
	{
	}

	public override void CriInternalLateUpdate()
	{
	}
}
