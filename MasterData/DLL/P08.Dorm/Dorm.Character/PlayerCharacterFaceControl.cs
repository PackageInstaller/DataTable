using System;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Dorm.Character;

[ExecuteAlways]
[DisallowMultipleComponent]
public class PlayerCharacterFaceControl : SerializedMonoBehaviour
{
	public GameObject normalFace;

	public GameObject specialFace;

	public Transform spacialFaceEfxAttachPoint;

	public EffectController curEfxFace;

	private bool isDestroy;

	internal static EffectController PlayEffect(string efxFacePath, Transform attach, float duration, Action<EffectController> onEfxEnd)
	{
		GameObject obj = Asset.Instantiate(efxFacePath);
		obj.transform.SetParent(attach, worldPositionStays: false);
		obj.transform.localPosition = Vector3.zero;
		obj.transform.localRotation = Quaternion.identity;
		EffectController effectController = U3DUtil.Get<EffectController>(obj);
		effectController.Initialize(isLoop: false, duration, 1f, EEffectQuality.Low, onEfxEnd);
		effectController.Simulator(0f);
		return effectController;
	}

	public void UseNormalFace()
	{
		specialFace.SetActive(value: false);
		normalFace.SetActive(value: true);
	}

	internal void UseSpecialFace()
	{
		specialFace.SetActive(value: true);
		normalFace.SetActive(value: false);
	}

	private void OnSpFaceEfxEnd(EffectController fxStoped)
	{
		if (curEfxFace == fxStoped)
		{
			if (!isDestroy)
			{
				UseNormalFace();
			}
			curEfxFace = null;
		}
	}

	private void OnDestroy()
	{
		isDestroy = true;
		if ((bool)curEfxFace && curEfxFace.mIsRunning)
		{
			curEfxFace.Stop();
		}
	}

	public void PlaySpecialFaceExpression(string efxFacePath, float duration)
	{
		UseSpecialFace();
		EffectController effectController = curEfxFace;
		curEfxFace = PlayEffect(efxFacePath, spacialFaceEfxAttachPoint, duration, OnSpFaceEfxEnd);
		if ((bool)effectController && effectController.mIsRunning)
		{
			effectController.Stop();
		}
	}
}
