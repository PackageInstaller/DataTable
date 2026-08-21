using System;
using System.Collections;
using ControllerExSpace;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.UI;

public class SliceMessilyProgressItem : MonoBehaviour
{
	private SliceMessilyGameManager manager;

	private SliceMessilyGameStep config;

	public Image progressImage;

	public ControllerExCollection progressControllerEx;

	private ControllerEx progressColorController;

	public Animator progressAnimator;

	public RectTransform greenFxTrans;

	public GameObject countDownTimeGo;

	public ControllerExCollection countDownControllerEx;

	private ControllerEx countDownStatusController;

	public Text countDownTimeText;

	public Image countDownImage;

	public Animator countDownAnimator;

	private readonly float limitTimePercent = 1f / 3f;

	private IEnumerator animCoroutine;

	private int curTime;

	private float greenProgressWidth;

	private int playingAnimCount;

	private bool isClockWarning;

	public bool isBlocking => playingAnimCount > 0;

	public void Init(SliceMessilyGameManager manager, SliceMessilyGameStep config)
	{
		this.manager = manager;
		this.config = config;
		progressColorController = progressControllerEx.GetController("processColor");
		countDownStatusController = countDownControllerEx.GetController("processStatus");
		RectTransform rectTransform = greenFxTrans.parent as RectTransform;
		greenProgressWidth = rectTransform.sizeDelta.x;
	}

	public void InitGame()
	{
		curTime = 0;
		progressColorController.SetSelectedState("green");
		countDownStatusController.SetSelectedState("orange");
		progressImage.fillAmount = 0f;
		greenFxTrans.anchoredPosition = Vector2.zero;
		greenFxTrans.SetActive(bActive: false);
		countDownTimeGo.SetActive(value: false);
		playingAnimCount = 0;
		isClockWarning = false;
	}

	public void SwitchToSliceStatus()
	{
		if (config.countDownTime > 0)
		{
			countDownTimeGo.SetActive(value: true);
			PlayClockEnterAnim();
		}
	}

	public void UpdateRender()
	{
		RenderProgress();
		RenderCountDownTime();
	}

	public void RenderProgress()
	{
		float num = manager.curProgress / config.maxProgress;
		progressImage.fillAmount = num;
		float x = greenProgressWidth * num;
		greenFxTrans.anchoredPosition = new Vector2(x, 0f);
		if (manager.curProgress > 0f)
		{
			greenFxTrans.SetActive(bActive: true);
		}
		if (manager.curProgress >= config.maxProgress)
		{
			PlayFinishAnim();
			countDownTimeGo.SetActive(value: false);
		}
	}

	public void RenderCountDownTime()
	{
		if (config.countDownTime <= 0)
		{
			return;
		}
		int num = (int)math.ceil(manager.curCountDownTime);
		countDownImage.fillAmount = manager.curCountDownTime / (float)config.countDownTime;
		if (curTime != num)
		{
			curTime = num;
			countDownTimeText.text = curTime.ToString();
			if (manager.curCountDownTime / (float)config.countDownTime <= limitTimePercent && !isClockWarning)
			{
				isClockWarning = true;
				countDownStatusController.SetSelectedState("red");
				PlayClockWarningAnim();
			}
			if (curTime == 0 && manager.curProgress < config.maxProgress)
			{
				progressColorController.SetSelectedState("red");
				PlayFailAnim();
			}
			if (curTime <= 3 && curTime > 0)
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_count", useStream: false);
			}
			else if (curTime == 0)
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_negative", useStream: false);
			}
		}
	}

	public void PlayClockEnterAnim()
	{
		countDownAnimator.enabled = true;
		countDownAnimator.Play("in", 0, 0f);
		countDownAnimator.Update(0f);
	}

	public void PlayClockWarningAnim()
	{
		countDownAnimator.Play("countdown", 0, 0f);
		countDownAnimator.Update(0f);
	}

	public void PlayClockExitAnim()
	{
		playingAnimCount++;
		PlayAnimWithCallback(countDownAnimator, "out", ClockExitAnimEnd);
	}

	private void ClockExitAnimEnd()
	{
		playingAnimCount--;
	}

	public void PlayUnfinishAnim()
	{
		playingAnimCount++;
		PlayAnimWithCallback(progressAnimator, "unfinishi_shake", UnfinishAnimEnd);
	}

	public void UnfinishAnimEnd()
	{
		playingAnimCount--;
		PlayClockExitAnim();
	}

	public void PlayFinishAnim()
	{
		progressAnimator.SetActive(bActive: true);
		progressAnimator.enabled = true;
		progressAnimator.Play("finishi", 0, 0f);
		progressAnimator.Update(0f);
	}

	public void PlayFailAnim()
	{
		PlayUnfinishAnim();
	}

	private void PlayAnimWithCallback(Animator animator, string animName, Action callback = null)
	{
		animator.enabled = true;
		animator.Play(animName, 0, 0f);
		animator.Update(0f);
		StopAnimCoroutine();
		animCoroutine = CheckAnimEnd(animator, animName, callback);
		StartCoroutine(animCoroutine);
	}

	private void StopAnimCoroutine()
	{
		if (animCoroutine != null)
		{
			StopCoroutine(animCoroutine);
		}
	}

	private IEnumerator CheckAnimEnd(Animator animator, string animName, Action callback)
	{
		yield return null;
		while (animator.GetCurrentAnimatorStateInfo(0).normalizedTime < 1f)
		{
			yield return null;
		}
		animator.enabled = false;
		callback();
		animCoroutine = null;
	}
}
