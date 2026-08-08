using System;
using UnityEngine;

[Obsolete("Use ICriLipsMorph")]
public class CriLipsMeshMorph
{
	public enum BlendShapeNameMappingIndex
	{
		WidthOpen,
		HeightOpen,
		TonguePosition,
		WidthClose,
		A,
		I,
		U,
		E,
		O,
		MAXNUM
	}

	[Serializable]
	public struct BlendShapeNameMapping
	{
		public string lipWidthOpenName;

		public string lipHeightOpenName;

		public string tonguePosition;

		public string lipWidthCloseName;

		public string a;

		public string i;

		public string u;

		public string e;

		public string o;
	}

	private CriLipsShape.MorphingTargetType morphingTargetType;

	public SkinnedMeshRenderer skinnedMeshRenderer;

	public Animator animator;

	private int[] nameMappingGetBlendShapeIndexs = new int[9];

	private float silenceWidthPosition;

	public CriLipsMeshMorph(SkinnedMeshRenderer skinnedMeshRenderer, BlendShapeNameMapping nameMapping, float silenceWidthPosition)
	{
		morphingTargetType = CriLipsShape.MorphingTargetType.BlendShape;
		this.skinnedMeshRenderer = skinnedMeshRenderer;
		this.silenceWidthPosition = silenceWidthPosition;
		string[] array = BlendShapeNameMappingToArray(nameMapping);
		for (int i = 0; i < 9; i++)
		{
			nameMappingGetBlendShapeIndexs[i] = this.skinnedMeshRenderer.sharedMesh.GetBlendShapeIndex(array[i]);
		}
	}

	public CriLipsMeshMorph(Animator animator, BlendShapeNameMapping nameMapping, float silenceWidthPosition)
	{
		morphingTargetType = CriLipsShape.MorphingTargetType.Animation;
		this.animator = animator;
		this.silenceWidthPosition = silenceWidthPosition;
		nameMappingGetBlendShapeIndexs[0] = Animator.StringToHash(nameMapping.lipWidthOpenName);
		nameMappingGetBlendShapeIndexs[1] = Animator.StringToHash(nameMapping.lipHeightOpenName);
		nameMappingGetBlendShapeIndexs[2] = Animator.StringToHash(nameMapping.tonguePosition);
		nameMappingGetBlendShapeIndexs[3] = Animator.StringToHash(nameMapping.lipWidthCloseName);
		nameMappingGetBlendShapeIndexs[4] = Animator.StringToHash(nameMapping.a);
		nameMappingGetBlendShapeIndexs[5] = Animator.StringToHash(nameMapping.i);
		nameMappingGetBlendShapeIndexs[6] = Animator.StringToHash(nameMapping.u);
		nameMappingGetBlendShapeIndexs[7] = Animator.StringToHash(nameMapping.e);
		nameMappingGetBlendShapeIndexs[8] = Animator.StringToHash(nameMapping.o);
	}

	public void Update(ref CriLipsMouth.Info info)
	{
		float num = 0f;
		float num2 = 0f;
		if (info.lipWidth > silenceWidthPosition)
		{
			num = (info.lipWidth - silenceWidthPosition) / (1f - silenceWidthPosition);
		}
		else
		{
			num2 = (silenceWidthPosition - info.lipWidth) / silenceWidthPosition;
		}
		switch (morphingTargetType)
		{
		case CriLipsShape.MorphingTargetType.BlendShape:
			BlendShapeWeightIndex(skinnedMeshRenderer, nameMappingGetBlendShapeIndexs[0], num * 100f);
			BlendShapeWeightIndex(skinnedMeshRenderer, nameMappingGetBlendShapeIndexs[3], num2 * 100f);
			BlendShapeWeightIndex(skinnedMeshRenderer, nameMappingGetBlendShapeIndexs[1], info.lipHeight * 100f);
			BlendShapeWeightIndex(skinnedMeshRenderer, nameMappingGetBlendShapeIndexs[2], info.tonguePosition * 100f);
			break;
		case CriLipsShape.MorphingTargetType.Animation:
			animator.Play(nameMappingGetBlendShapeIndexs[0], -1, Mathf.Max(0.001f, Mathf.Min(num, 1f)));
			animator.Play(nameMappingGetBlendShapeIndexs[3], -1, Mathf.Max(0.001f, Mathf.Min(num2, 1f)));
			animator.Play(nameMappingGetBlendShapeIndexs[1], -1, Mathf.Max(0.001f, Mathf.Min(info.lipHeight, 1f)));
			animator.Play(nameMappingGetBlendShapeIndexs[2], -1, Mathf.Max(0.001f, Mathf.Min(info.tonguePosition, 1f)));
			break;
		}
	}

	public void Update(ref CriLipsMouth.MorphTargetBlendAmountAsJapanese blendAmount)
	{
		switch (morphingTargetType)
		{
		case CriLipsShape.MorphingTargetType.BlendShape:
			BlendShapeWeightIndex(skinnedMeshRenderer, nameMappingGetBlendShapeIndexs[4], blendAmount.a * 100f);
			BlendShapeWeightIndex(skinnedMeshRenderer, nameMappingGetBlendShapeIndexs[5], blendAmount.i * 100f);
			BlendShapeWeightIndex(skinnedMeshRenderer, nameMappingGetBlendShapeIndexs[6], blendAmount.u * 100f);
			BlendShapeWeightIndex(skinnedMeshRenderer, nameMappingGetBlendShapeIndexs[7], blendAmount.e * 100f);
			BlendShapeWeightIndex(skinnedMeshRenderer, nameMappingGetBlendShapeIndexs[8], blendAmount.o * 100f);
			break;
		case CriLipsShape.MorphingTargetType.Animation:
			animator.Play(nameMappingGetBlendShapeIndexs[4], -1, Mathf.Max(0.001f, Mathf.Min(blendAmount.a, 1f)));
			animator.Play(nameMappingGetBlendShapeIndexs[5], -1, Mathf.Max(0.001f, Mathf.Min(blendAmount.i, 1f)));
			animator.Play(nameMappingGetBlendShapeIndexs[6], -1, Mathf.Max(0.001f, Mathf.Min(blendAmount.u, 1f)));
			animator.Play(nameMappingGetBlendShapeIndexs[7], -1, Mathf.Max(0.001f, Mathf.Min(blendAmount.e, 1f)));
			animator.Play(nameMappingGetBlendShapeIndexs[8], -1, Mathf.Max(0.001f, Mathf.Min(blendAmount.o, 1f)));
			break;
		}
	}

	private void BlendShapeWeightIndex(SkinnedMeshRenderer skinnedMeshRenderer, int index, float weight)
	{
		if (index >= 0 && !(skinnedMeshRenderer == null))
		{
			skinnedMeshRenderer.SetBlendShapeWeight(index, weight);
		}
	}

	public static string[] BlendShapeNameMappingToArray(BlendShapeNameMapping nameMapping)
	{
		return new string[9] { nameMapping.lipWidthOpenName, nameMapping.lipHeightOpenName, nameMapping.tonguePosition, nameMapping.lipWidthCloseName, nameMapping.a, nameMapping.i, nameMapping.u, nameMapping.e, nameMapping.o };
	}

	public static bool SetBlendShapeNameMappingArrayToStruct(string[] nameMappingArray, ref BlendShapeNameMapping nameMapping)
	{
		if (nameMappingArray == null || nameMappingArray.Length != 9)
		{
			Debug.LogError("[CRIWARE] nameMappingArray is invalid.");
			return false;
		}
		nameMapping.lipWidthOpenName = nameMappingArray[0];
		nameMapping.lipHeightOpenName = nameMappingArray[1];
		nameMapping.tonguePosition = nameMappingArray[2];
		nameMapping.lipWidthCloseName = nameMappingArray[3];
		nameMapping.a = nameMappingArray[4];
		nameMapping.i = nameMappingArray[5];
		nameMapping.u = nameMappingArray[6];
		nameMapping.e = nameMappingArray[7];
		nameMapping.o = nameMappingArray[8];
		return true;
	}
}
