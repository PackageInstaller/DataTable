using System;
using System.Collections.Generic;
using RenderProject.Rendering.CustomSkinning;
using UnityEngine;

namespace ACT.Timeline;

[DefaultExecutionOrder(9990)]
public sealed class GachaLipSyncMouthGate : MonoBehaviour
{
	private CustomSkinRenderer faceRenderer;

	private Animator boundAnimator;

	private int[] mouthBlendShapeIndices = Array.Empty<int>();

	private readonly Dictionary<string, float[]> phonemePoses = new Dictionary<string, float[]>();

	private readonly Dictionary<string, float> visemeWeights = new Dictionary<string, float>();

	private readonly float[] appliedMouthWeights = new float[64];

	private bool clipActive;

	private static readonly string[] LipSyncMouthShapeNames = new string[11]
	{
		"Mouth_Grin", "Mouth_Shrinks", "Mouth_Shout", "Mouth_Roar", "Mouth_Pouting_L", "Mouth_Pouting_R", "Mouth_Smile", "Mouth_Laugh", "Mouth_Anger", "Mouth_Smile01",
		"Mouth_Grin02"
	};

	public void Initialize(Animator animator)
	{
		boundAnimator = animator;
		faceRenderer = null;
		mouthBlendShapeIndices = Array.Empty<int>();
		phonemePoses.Clear();
		if (animator == null)
		{
			return;
		}
		CustomSkinRenderer[] componentsInChildren = animator.GetComponentsInChildren<CustomSkinRenderer>(includeInactive: true);
		int num = 0;
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			int[] array = CollectMouthBlendShapeIndices(componentsInChildren[i]);
			if (array.Length > num)
			{
				num = array.Length;
				faceRenderer = componentsInChildren[i];
				mouthBlendShapeIndices = array;
			}
		}
	}

	public void CapturePhonemePose(string phoneme, AnimationClip clip)
	{
		if (string.IsNullOrEmpty(phoneme) || clip == null || faceRenderer == null || boundAnimator == null)
		{
			return;
		}
		float[] array = new float[mouthBlendShapeIndices.Length];
		for (int i = 0; i < mouthBlendShapeIndices.Length; i++)
		{
			array[i] = faceRenderer.GetBlendShapeWeight(mouthBlendShapeIndices[i]);
		}
		clip.SampleAnimation(boundAnimator.gameObject, 0f);
		float[] array2 = new float[mouthBlendShapeIndices.Length];
		bool flag = false;
		for (int j = 0; j < mouthBlendShapeIndices.Length; j++)
		{
			array2[j] = faceRenderer.GetBlendShapeWeight(mouthBlendShapeIndices[j]);
			if (array2[j] > 0.01f)
			{
				flag = true;
			}
		}
		for (int k = 0; k < mouthBlendShapeIndices.Length; k++)
		{
			faceRenderer.SetBlendShapeWeight(mouthBlendShapeIndices[k], array[k]);
		}
		if (flag)
		{
			phonemePoses[phoneme] = array2;
		}
	}

	public void BeginLipSyncFrame(bool hasActiveLipSyncClip)
	{
		clipActive = hasActiveLipSyncClip;
		visemeWeights.Clear();
		_ = clipActive;
	}

	public void SetVisemeWeight(string phoneme, float weight)
	{
		if (clipActive && !string.IsNullOrEmpty(phoneme) && !(weight <= 0.0001f))
		{
			visemeWeights.TryGetValue(phoneme, out var value);
			visemeWeights[phoneme] = value + weight;
		}
	}

	public void SetSuppressIdleMouth(bool suppress)
	{
		if (suppress)
		{
			clipActive = true;
			visemeWeights.Clear();
		}
	}

	private void LateUpdate()
	{
		if (clipActive && !(faceRenderer == null) && phonemePoses.Count != 0)
		{
			ZeroMouthBlendShapes();
			ApplyVisemePoses();
		}
	}

	private void OnDisable()
	{
		clipActive = false;
		visemeWeights.Clear();
	}

	private void ApplyVisemePoses()
	{
		if (visemeWeights.Count == 0)
		{
			return;
		}
		Array.Clear(appliedMouthWeights, 0, appliedMouthWeights.Length);
		foreach (KeyValuePair<string, float> visemeWeight in visemeWeights)
		{
			if (!phonemePoses.TryGetValue(visemeWeight.Key, out var value))
			{
				continue;
			}
			for (int i = 0; i < value.Length && i < mouthBlendShapeIndices.Length; i++)
			{
				int num = mouthBlendShapeIndices[i];
				if (num >= 0 && num < appliedMouthWeights.Length)
				{
					appliedMouthWeights[num] += value[i] * visemeWeight.Value;
				}
			}
		}
		for (int j = 0; j < mouthBlendShapeIndices.Length; j++)
		{
			int num2 = mouthBlendShapeIndices[j];
			float num3 = ((num2 < appliedMouthWeights.Length) ? appliedMouthWeights[num2] : 0f);
			if (num3 > 0.01f)
			{
				faceRenderer.SetBlendShapeWeight(num2, num3);
			}
		}
	}

	private void ZeroMouthBlendShapes()
	{
		if (!(faceRenderer == null))
		{
			for (int i = 0; i < mouthBlendShapeIndices.Length; i++)
			{
				faceRenderer.SetBlendShapeWeight(mouthBlendShapeIndices[i], 0f);
			}
		}
	}

	private static int[] CollectMouthBlendShapeIndices(CustomSkinRenderer renderer)
	{
		if (renderer == null)
		{
			return Array.Empty<int>();
		}
		MeshFilter component = renderer.GetComponent<MeshFilter>();
		Mesh mesh = ((component != null) ? component.sharedMesh : null);
		if (mesh == null)
		{
			return Array.Empty<int>();
		}
		int blendShapeCount = mesh.blendShapeCount;
		int[] array = new int[blendShapeCount];
		int num = 0;
		for (int i = 0; i < blendShapeCount; i++)
		{
			if (IsMouthBlendShape(mesh.GetBlendShapeName(i)))
			{
				array[num++] = i;
			}
		}
		if (num == 0)
		{
			return Array.Empty<int>();
		}
		int[] array2 = new int[num];
		Array.Copy(array, array2, num);
		return array2;
	}

	private static bool IsMouthBlendShape(string shapeName)
	{
		if (string.IsNullOrEmpty(shapeName))
		{
			return false;
		}
		if (shapeName.StartsWith("Jaw", StringComparison.OrdinalIgnoreCase))
		{
			return true;
		}
		for (int i = 0; i < LipSyncMouthShapeNames.Length; i++)
		{
			if (string.Equals(shapeName, LipSyncMouthShapeNames[i], StringComparison.OrdinalIgnoreCase))
			{
				return true;
			}
		}
		return false;
	}
}
