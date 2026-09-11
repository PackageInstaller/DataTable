using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class SoupStep : MainStepBase
{
	public float guideTime = 8f;

	public int totalPourCount = 1;

	public float pourTime = 1f;

	public string guideKey = "";

	public EventTriggerListener eventTriggerListener;

	public GameObject guideGo;

	public Animator pourAnim;

	public Animator rippleAnim1;

	public Animator rippleAnim2;

	public Animator bowlAnim;

	public Animator mixAnim;

	public Animator circleAnim;

	public GameObject finishEffect;

	private float pressTime;

	private bool isPress;

	private bool isGuide;

	private float operateTimer;

	private bool isFinish;

	private int nowPourIndex = 1;

	private float animSpeed = 1f;

	private bool isPlayingAnim;

	private string guideString;

	private bool isFirstPointDown = true;

	private Dictionary<string, List<string>> pourAudioDict = new Dictionary<string, List<string>>
	{
		["10201"] = new List<string> { "minigame_activity_4_3_cook_pour01", "minigame_activity_4_3_cook_pour01_action_stop", "minigame_activity_4_3_cook_pour01_action_pause", "minigame_activity_4_3_cook_pour01_action_resume" },
		["10204"] = new List<string> { "minigame_activity_4_3_cook_pour01", "minigame_activity_4_3_cook_pour01_action_stop", "minigame_activity_4_3_cook_pour01_action_pause", "minigame_activity_4_3_cook_pour01_action_resume" },
		["10505"] = new List<string> { "minigame_activity_4_3_cook_pour02", "minigame_activity_4_3_cook_pour02_action_stop", "minigame_activity_4_3_cook_pour02_action_pause", "minigame_activity_4_3_cook_pour02_action_resume" }
	};

	private List<string> nowAudioList;

	public float imgKeepTime = 2f;

	private void Start()
	{
		nowAudioList = (pourAudioDict.ContainsKey(config.stepID) ? pourAudioDict[config.stepID] : null);
		eventTriggerListener.AddListenerType1(EventTriggerType.PointerDown, OnPointerDown);
		eventTriggerListener.AddListenerType1(EventTriggerType.PointerUp, OnPointerUp);
		eventTriggerListener.AddListenerType1(EventTriggerType.PointerExit, OnPointerExit);
		animSpeed = 1f / pourTime;
		bowlAnim.Play("PourProgress03_04", 0, 0f);
		bowlAnim.speed = 0f;
		circleAnim.speed = 0f;
		CookingGameManager.Instance.UpdateProgress(new CookingGameConst.ProgressData(config.stepDescription, nowPourIndex - 1, totalPourCount));
		object[] array = LuaHelper.CallFunction("GetTips", guideKey);
		guideString = ((array != null) ? array[0].ToString() : "");
		GameGuide(flag: true);
	}

	private void Update()
	{
		if (isFinish || isPlayingAnim)
		{
			return;
		}
		if (isPress)
		{
			operateTimer = 0f;
			pressTime += Time.deltaTime;
			if (pressTime >= pourTime)
			{
				CheckEnd();
			}
		}
		else
		{
			operateTimer += Time.deltaTime;
			if (operateTimer >= guideTime)
			{
				GameGuide(flag: true);
				operateTimer = 0f;
			}
		}
	}

	private IEnumerator PlayAndWaitForCompletion(Animator anim, string stateName, Action callback)
	{
		anim.Play(stateName, 0, 0f);
		yield return null;
		int layerIndex = 0;
		int targetHash = anim.GetCurrentAnimatorStateInfo(layerIndex).fullPathHash;
		while (anim.GetCurrentAnimatorStateInfo(layerIndex).fullPathHash != targetHash)
		{
			yield return null;
		}
		while (anim.GetCurrentAnimatorStateInfo(layerIndex).normalizedTime < 1f)
		{
			yield return null;
		}
		if (anim.GetCurrentAnimatorStateInfo(layerIndex).fullPathHash == targetHash)
		{
			callback?.Invoke();
		}
	}

	private void OnPointerDown(GameObject go, PointerEventData data)
	{
		if (!isFinish && !isPlayingAnim)
		{
			if (isGuide)
			{
				GameGuide(flag: false);
			}
			if (isFirstPointDown)
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", nowAudioList[0], useStream: false);
				isFirstPointDown = false;
			}
			else
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", nowAudioList[3], useStream: false);
			}
			isPress = true;
			pourAnim.Play("Pour", 0, 0f);
			rippleAnim1.Play("soup", 0, 0f);
			rippleAnim2.Play("soup", 0, 0f);
			bowlAnim.speed = 1f;
			circleAnim.gameObject.SetActive(value: true);
			circleAnim.speed = animSpeed;
		}
	}

	private void OnPointerUp(GameObject go, PointerEventData data)
	{
		if (isPress)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", nowAudioList[2], useStream: false);
			pourAnim.Play("Pour_back", 0, 0f);
			rippleAnim1.Play("empty", 0, 0f);
			rippleAnim2.Play("empty", 0, 0f);
			bowlAnim.speed = 0f;
			circleAnim.speed = 0f;
		}
		isPress = false;
	}

	private void OnPointerExit(GameObject go, PointerEventData data)
	{
		if (isPress)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", nowAudioList[2], useStream: false);
			pourAnim.Play("Pour_back", 0, 0f);
			rippleAnim1.Play("empty", 0, 0f);
			rippleAnim2.Play("empty", 0, 0f);
			bowlAnim.speed = 0f;
			circleAnim.speed = 0f;
		}
		isPress = false;
	}

	private void CheckEnd()
	{
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", nowAudioList[1], useStream: false);
		nowPourIndex++;
		pressTime = 0f;
		CookingGameManager.Instance.AddStepSuccess(config.stepID);
		if (nowPourIndex > totalPourCount)
		{
			isFinish = true;
			StartCoroutine(StepFinishCor());
		}
		RestPour();
	}

	private void RestPour()
	{
		isPress = false;
		pourAnim.Play("Pour_back", 0, 0f);
		rippleAnim1.Play("empty", 0, 0f);
		rippleAnim2.Play("empty", 0, 0f);
		bowlAnim.speed = 0f;
		isFirstPointDown = true;
		circleAnim.speed = 1f;
		circleAnim.Play("UI_cicleAni_xs", 0, 0f);
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_gold05", useStream: false);
		CookingGameManager.Instance.UpdateProgress(new CookingGameConst.ProgressData(config.stepDescription, nowPourIndex - 1, totalPourCount));
		if (totalPourCount > 1)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_mix_loop", useStream: false);
			isPlayingAnim = true;
			StartCoroutine(PlayAndWaitForCompletion(mixAnim, "Mixing", delegate
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_mix_loop_action_stop", useStream: false);
				isPlayingAnim = false;
				circleAnim.gameObject.SetActive(value: false);
			}));
		}
	}

	private IEnumerator StepFinishCor()
	{
		finishEffect.SetActive(value: true);
		yield return new WaitForSeconds(imgKeepTime);
		finishEffect.SetActive(value: false);
		StepFinish();
	}

	public override void StepFinish()
	{
		base.StepFinish();
	}

	private void GameGuide(bool flag)
	{
		isGuide = flag;
		guideGo.SetActive(flag);
		CookingGameManager.Instance.ShowGuideText(flag, guideString);
	}

	public override bool IsStepCompleted()
	{
		return isFinish;
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		int currentProgress = (isFinish ? 1 : 0);
		return new CookingGameConst.ProgressData(config.stepDescription, currentProgress, totalPourCount);
	}
}
