using System.Collections.Generic;
using UnityEngine.Pipelines.SimPipeline;

namespace P08.EnvironmentHelper;

public class TimelineGlitchEffectHelper : TimelineCameraExtensionHelperBase
{
	protected override void InitOriginData(CameraExtension pCameraExtension)
	{
	}

	protected override void OnResetData()
	{
		_cameraExtension.glitchIntensity = 0f;
		_cameraExtension.glitchFrequency = 0f;
	}

	public void AddGlitchEffectClip(int pCreationIndex, int pKey, float pLength, float pIntensity, float pFrequency, int pPriority)
	{
		GlitchEffectClip glitchEffectClip = FrameObjectPool<GlitchEffectClip>.Claim();
		glitchEffectClip.InitBaseData(pIsAuto: false, pLength);
		glitchEffectClip.CreationIndex = pCreationIndex;
		glitchEffectClip.Key = pKey;
		glitchEffectClip.Intensity = pIntensity;
		glitchEffectClip.Frequency = pFrequency;
		AddClip(glitchEffectClip);
	}

	protected override void OnAddingClip(List<ClipBase> pRuntimeClip, int pIndex)
	{
	}

	public void RemoveGlitchEffectClip(int pCreationIndex, int pKey = 0)
	{
		for (int num = _runtimeClip.Count - 1; num >= 0; num--)
		{
			GlitchEffectClip glitchEffectClip = _runtimeClip[num] as GlitchEffectClip;
			if (glitchEffectClip.CreationIndex == pCreationIndex)
			{
				if (pKey == 0)
				{
					glitchEffectClip.IsObsolete = true;
				}
				else if (glitchEffectClip.Key == pKey && !glitchEffectClip.IsObsolete)
				{
					glitchEffectClip.IsObsolete = true;
					break;
				}
			}
		}
	}

	protected override void OnObsoleting(ClipBase pClipBase)
	{
	}

	protected override void OnRemovedClip(List<ClipBase> pRuntimeClip, int pLastestRemoveIndex)
	{
	}

	protected override void OnRemovingClip(ClipBase pClipBase)
	{
		if (pClipBase is GlitchEffectClip obj)
		{
			FrameObjectPool<GlitchEffectClip>.Release(obj);
		}
	}

	public void UpdateGlitchEffect(int pCreationIndex, int pKey, float pNormalized, float pIntensity, float pFrequency = -1f)
	{
		for (int num = _runtimeClip.Count - 1; num >= 0; num--)
		{
			GlitchEffectClip glitchEffectClip = _runtimeClip[num] as GlitchEffectClip;
			if (glitchEffectClip.CreationIndex == pCreationIndex && glitchEffectClip.Key == pKey)
			{
				glitchEffectClip.Normalized = pNormalized;
				glitchEffectClip.Intensity = pIntensity;
				if (pFrequency != -1f)
				{
					glitchEffectClip.Frequency = pFrequency;
				}
				break;
			}
		}
	}

	protected override void OnUpdateClip(List<ClipBase> pRuntimeClip)
	{
		float num = 0f;
		float num2 = 0f;
		int num3 = -1;
		for (int i = 0; i < pRuntimeClip.Count; i++)
		{
			GlitchEffectClip glitchEffectClip = pRuntimeClip[i] as GlitchEffectClip;
			if (glitchEffectClip.Priority >= num3)
			{
				if (num < glitchEffectClip.Intensity)
				{
					num = glitchEffectClip.Intensity;
				}
				if (num2 < glitchEffectClip.Frequency)
				{
					num2 = glitchEffectClip.Frequency;
				}
			}
		}
		_cameraExtension.glitchIntensity = num;
		_cameraExtension.glitchFrequency = num2;
	}
}
