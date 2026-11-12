using System;
using System.Collections;
using Nova.Hotfix;
using TMPro;
using UnityEngine;

public class MathParkourEffectItemEntity : MonoBehaviour
{
	[SerializeField]
	private Canvas worldSpaceCanvas;

	[SerializeField]
	private TextMeshProUGUI EffectText;

	[SerializeField]
	private GameObject EffectImage;

	[SerializeField]
	private SpriteRenderer BenefitItemSprite;

	[SerializeField]
	private Animator EffectAnimator;

	private Coroutine collectAnimationCoroutine;

	public long EntityId { get; private set; }

	public int ConfigId { get; private set; }

	public bool IsCollected { get; private set; }

	public void Init(long entityId, int configId)
	{
		EntityId = entityId;
		ConfigId = configId;
		IsCollected = false;
		BindHudCamera();
		InitHud();
	}

	private void InitHud()
	{
		EffectText.gameObject.SetActive(value: false);
		EffectImage.SetActive(value: false);
		BenefitItemSprite.gameObject.SetActive(value: false);
		MathParkourObject mathParkourObject = Singleton<HotfixDataController>.Instance.GetMathParkourObject(ConfigId);
		if (mathParkourObject != null)
		{
			switch ((HotfixEnum.MathParkourObjectType)mathParkourObject.ObjType)
			{
			case HotfixEnum.MathParkourObjectType.BenefitItem:
				BenefitItemSprite.gameObject.SetActive(value: true);
				break;
			case HotfixEnum.MathParkourObjectType.AccelerationConveyor:
			case HotfixEnum.MathParkourObjectType.DecelerationConveyor:
				EffectText.gameObject.SetActive(value: true);
				EffectText.text = mathParkourObject.Name;
				BenefitItemSprite.gameObject.SetActive(value: true);
				break;
			case HotfixEnum.MathParkourObjectType.SpecialConveyor:
				EffectImage.gameObject.SetActive(value: true);
				BenefitItemSprite.gameObject.SetActive(value: true);
				break;
			}
		}
	}

	public void Collect()
	{
		if (IsCollected)
		{
			return;
		}
		IsCollected = true;
		MathParkourObject mathParkourObject = Singleton<HotfixDataController>.Instance.GetMathParkourObject(ConfigId);
		if (mathParkourObject == null)
		{
			return;
		}
		if (mathParkourObject.ObjType == 6)
		{
			MonoSingleton<WwiseAudioManager>.Instance.PostEvent("Mode_400018_get");
			PlayCollectAnimation("obj_icon_in", () =>
			{
				gameObject.SetActive(value: false);
			});
		}
		else
		{
			EffectText.gameObject.SetActive(value: false);
			EffectImage.SetActive(value: false);
		}
	}

	private void PlayCollectAnimation(string animationStateName, Action finishCallback)
	{
		if (EffectAnimator == null || string.IsNullOrEmpty(animationStateName))
		{
			finishCallback?.Invoke();
			return;
		}
		if (collectAnimationCoroutine != null)
		{
			StopCoroutine(collectAnimationCoroutine);
		}
		int num = Animator.StringToHash(animationStateName);
		if (EffectAnimator.gameObject.activeSelf)
		{
			EffectAnimator.Play(num, 0, 0f);
			EffectAnimator.Update(0f);
			collectAnimationCoroutine = StartCoroutine(WaitForCollectAnimationComplete(num, finishCallback));
		}
		else
		{
			finishCallback?.Invoke();
		}
	}

	private IEnumerator WaitForCollectAnimationComplete(int stateHash, Action finishCallback)
	{
		yield return null;
		while (EffectAnimator != null)
		{
			AnimatorStateInfo currentAnimatorStateInfo = EffectAnimator.GetCurrentAnimatorStateInfo(0);
			if (currentAnimatorStateInfo.shortNameHash != stateHash || currentAnimatorStateInfo.normalizedTime >= 1f)
			{
				break;
			}
			yield return null;
		}
		collectAnimationCoroutine = null;
		finishCallback?.Invoke();
	}

	private void BindHudCamera()
	{
		if ((object)worldSpaceCanvas == null)
		{
			worldSpaceCanvas = GetComponentInChildren<Canvas>(includeInactive: true);
		}
		if (!(worldSpaceCanvas == null))
		{
			if (worldSpaceCanvas.renderMode != RenderMode.WorldSpace)
			{
				Debug.LogError("[MathParkour] Buff 道具的 HUD Canvas 必须使用 World Space 模式。", worldSpaceCanvas);
			}
			else
			{
				worldSpaceCanvas.worldCamera = ModuleController<MathParkourModuleController>.Instance?.hudCamera;
			}
		}
	}
}
