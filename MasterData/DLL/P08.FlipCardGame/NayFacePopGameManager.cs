using System;
using UnityEngine;

public class NayFacePopGameManager : MonoBehaviour
{
	private NayFacePopStep step;

	private int clickTimes;

	private float lastClickTime;

	private float operateTimer;

	private float hitStateTimer;

	private bool isExiting;

	private Camera uiCamera;

	private bool isAniPlaying;

	public NayFacePopGameManager(NayFacePopStep step)
	{
		this.step = step;
		isAniPlaying = false;
		uiCamera = GameObject.Find("UICamera/Canvas").GetComponent<Canvas>().worldCamera;
	}

	public void Update()
	{
		if (!(step != null))
		{
			return;
		}
		operateTimer += Time.deltaTime;
		if (operateTimer >= step.guideTime && !isExiting)
		{
			ShowGuide();
			operateTimer = 0f;
		}
		if (hitStateTimer > 0f)
		{
			hitStateTimer -= Time.deltaTime;
			if (hitStateTimer <= 0f && !isExiting)
			{
				step.faceImage.sprite = step.normalStateSprite;
			}
		}
	}

	public void OnFaceClick()
	{
		operateTimer = 0f;
		if (IsCompleted())
		{
			return;
		}
		HideGuide();
		RectTransformUtility.ScreenPointToLocalPointInRectangle(step.ani.transform.parent as RectTransform, Input.mousePosition, uiCamera, out var localPoint);
		step.ani.transform.localPosition = new Vector2(localPoint.x + 50f, localPoint.y);
		step.faceImage.sprite = step.hitStateSprite;
		hitStateTimer = step.hitStateDuration;
		step.ani.Play("FacePop_hit", 0, 0f);
		clickTimes++;
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_hit", useStream: true);
		if (!isAniPlaying)
		{
			isAniPlaying = true;
			LeanTween.scale(step.faceImage.rectTransform, new Vector3(step.endScale, step.endScale, step.endScale), step.hitAniduration).setEase(step.aniType).setOnComplete((Action)delegate
			{
				LeanTween.scale(step.faceImage.rectTransform, new Vector3(1f, 1f, 1f), step.hitAniduration).setEase(step.aniType).setOnComplete((Action)delegate
				{
					isAniPlaying = false;
				});
			});
		}
		if (clickTimes >= step.requiredClicks && !isExiting)
		{
			isExiting = true;
			step.faceImage.sprite = step.exitStateSprite;
			step.controller.GetController("isCry").SetSelectedState("true");
			ExitScene();
		}
	}

	private void ShowGuide()
	{
		step.guideHand.SetActive(value: true);
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.ShowGuideText(flag: true, step.guideText);
		}
		step.clickEffect.SetActive(value: true);
	}

	private void HideGuide()
	{
		step.guideHand.SetActive(value: false);
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.ShowGuideText(flag: false, "");
		}
	}

	private void ExitScene()
	{
		CookingGameManager.Instance.AddStepSuccess(step.config.stepID);
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_done02", useStream: true);
		LeanTween.move(step.faceRect, step.exitPosition, 0.8f).setEase(LeanTweenType.easeInCubic).setOnComplete((Action)delegate
		{
			step.OnStepEnd();
		});
	}

	public bool IsCompleted()
	{
		return clickTimes >= step.requiredClicks;
	}

	public int GetCurrentProgress()
	{
		return clickTimes;
	}
}
