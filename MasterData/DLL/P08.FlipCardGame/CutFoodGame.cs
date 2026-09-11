using System;
using System.Collections;
using UnityEngine;

public class CutFoodGame : MainStepBase
{
	[SerializeField]
	public GameObject unfinishPic;

	[SerializeField]
	public GameObject finishPic;

	public CutContainer cutCon;

	public Animator successAnimator;

	public float imgKeepTime = 3f;

	public GameObject StarGO;

	public float StarKeepTime = 2f;

	private float ActiveStarTimer;

	private bool CheckActiveStar;

	private bool starTimeOver;

	private bool isFinish;

	private bool isBlocking;

	private bool BeforeAnimator = true;

	private IEnumerator animCoroutine;

	private void Start()
	{
		cutCon = GetComponentInChildren<CutContainer>();
		StarGO.SetActive(value: false);
		successAnimator.enabled = false;
		unfinishPic.SetActive(value: true);
		finishPic.SetActive(value: false);
	}

	private void Update()
	{
		dofinishFood();
		if (starTimeOver)
		{
			_ = CookingGameManager.Instance.isPlayingPopStep;
		}
	}

	private void dofinishFood()
	{
		if (!isFinish)
		{
			CookingGameManager.Instance.UpdateProgress(GetProgress());
		}
		if (cutCon.GetIsCover() && BeforeAnimator)
		{
			BeforeAnimator = false;
			PlaySuccessAnim();
		}
		if (isFinish && !CheckActiveStar)
		{
			CheckActiveStar = true;
			StarGO.SetActive(value: true);
		}
		else if (isFinish && CheckActiveStar && ActiveStarTimer < StarKeepTime)
		{
			ActiveStarTimer += Time.deltaTime;
		}
		else if (isFinish && CheckActiveStar)
		{
			starTimeOver = true;
		}
	}

	public override bool IsStepCompleted()
	{
		return starTimeOver;
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		return new CookingGameConst.ProgressData(config.stepDescription, cutCon.GetProcess(), cutCon.GetMaxProcess());
	}

	private void PlaySuccessAnim()
	{
		isBlocking = true;
		successAnimator.SetActive(bActive: true);
		PlayAnimWithCallback(successAnimator, "CuttingSmoke", SuccessAnimEnd, SuccessAnimMid);
		CookingGameManager.Instance.PlayStepPanelFinishAni();
	}

	private void PlayAnimWithCallback(Animator animator, string animName, Action callback = null, Action midCallback = null)
	{
		animator.enabled = true;
		animator.Play(animName, 0, 0f);
		animator.Update(0f);
		StopAnimCoroutine();
		animCoroutine = CheckAnimEnd(animator, animName, callback, midCallback);
		StartCoroutine(animCoroutine);
	}

	private IEnumerator CheckAnimEnd(Animator animator, string animName, Action callback, Action midCallback = null)
	{
		yield return null;
		bool invokedMidCallback = false;
		while (true)
		{
			AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
			if ((double)currentAnimatorStateInfo.normalizedTime >= 0.2 && !invokedMidCallback)
			{
				invokedMidCallback = true;
				midCallback?.Invoke();
				yield return null;
				continue;
			}
			if (!(currentAnimatorStateInfo.normalizedTime < 1f))
			{
				break;
			}
			yield return null;
		}
		animator.enabled = false;
		callback();
		yield return new WaitForSeconds(imgKeepTime);
		StepFinish();
	}

	private void StopAnimCoroutine()
	{
		if (animCoroutine != null)
		{
			StopCoroutine(animCoroutine);
		}
	}

	private void SuccessAnimEnd()
	{
		successAnimator.SetActive(bActive: false);
		isBlocking = false;
		isFinish = true;
	}

	private void SuccessAnimMid()
	{
		cutCon.SetActive(bActive: false);
		unfinishPic.SetActive(value: false);
		finishPic.SetActive(value: true);
	}

	public override float GetPopStepTriggerProgress()
	{
		return (float)cutCon.progress / (float)cutCon.maxProgress;
	}
}
