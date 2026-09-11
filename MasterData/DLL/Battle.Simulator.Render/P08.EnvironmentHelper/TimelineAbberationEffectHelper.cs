using System.Collections.Generic;
using UnityEngine.Pipelines.SimPipeline;

namespace P08.EnvironmentHelper;

public class TimelineAbberationEffectHelper : TimelineCameraExtensionHelperBase
{
	protected override void InitOriginData(CameraExtension pCameraExtension)
	{
	}

	protected override void OnResetData()
	{
		_cameraExtension.abberationIntensity = 0f;
	}

	public void AddAbberationEffectClip(int pCreationIndex, int pKey, float pLength, float pIntensity, bool pIsActive, int pPriority)
	{
		AbberationEffectClip abberationEffectClip = FrameObjectPool<AbberationEffectClip>.Claim();
		abberationEffectClip.InitBaseData(pIsAuto: false, pLength);
		abberationEffectClip.CreationIndex = pCreationIndex;
		abberationEffectClip.Key = pKey;
		abberationEffectClip.Intensity = pIntensity;
		abberationEffectClip.IsActive = pIsActive;
		abberationEffectClip.Priority = pPriority;
		AddClip(abberationEffectClip);
	}

	protected override void OnAddingClip(List<ClipBase> pRuntimeClip, int pIndex)
	{
	}

	public void RemoveAbberationEffectClip(int pCreationIndex, int pKey = 0)
	{
		for (int num = _runtimeClip.Count - 1; num >= 0; num--)
		{
			AbberationEffectClip abberationEffectClip = _runtimeClip[num] as AbberationEffectClip;
			if (abberationEffectClip.CreationIndex == pCreationIndex)
			{
				if (pKey == 0)
				{
					abberationEffectClip.IsObsolete = true;
				}
				else if (abberationEffectClip.Key == pKey && !abberationEffectClip.IsObsolete)
				{
					abberationEffectClip.IsObsolete = true;
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
		if (pClipBase is AbberationEffectClip obj)
		{
			FrameObjectPool<AbberationEffectClip>.Release(obj);
		}
	}

	public void UpdateAbberationEffect(int pCreationIndex, int pKey, float pIntensity, float pNormalized, bool pIsActive)
	{
		for (int num = _runtimeClip.Count - 1; num >= 0; num--)
		{
			AbberationEffectClip abberationEffectClip = _runtimeClip[num] as AbberationEffectClip;
			if (abberationEffectClip.CreationIndex == pCreationIndex && abberationEffectClip.Key == pKey)
			{
				abberationEffectClip.Normalized = pNormalized;
				abberationEffectClip.Intensity = pIntensity;
				abberationEffectClip.IsActive = pIsActive;
				break;
			}
		}
	}

	protected override void OnUpdateClip(List<ClipBase> pRuntimeClip)
	{
		float num = 0f;
		int num2 = -1;
		for (int i = 0; i < pRuntimeClip.Count; i++)
		{
			AbberationEffectClip abberationEffectClip = pRuntimeClip[i] as AbberationEffectClip;
			if (abberationEffectClip.Priority >= num2 && abberationEffectClip.IsActive && num < abberationEffectClip.Intensity)
			{
				num = abberationEffectClip.Intensity;
			}
		}
		_cameraExtension.abberationIntensity = num;
	}
}
