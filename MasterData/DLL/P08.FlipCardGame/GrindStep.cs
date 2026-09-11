using System;
using System.Collections;
using System.Collections.Generic;
using ControllerExSpace;
using Spine.Unity;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class GrindStep : MainStepBase
{
	[Serializable]
	public class AreaInfo
	{
		public int showStartAngle;

		public int showEndAngle;

		public int phase;
	}

	public class ReleaseArea
	{
		private Image releaseImageAlpha;

		private Image releaseImage;

		private GameObject go;

		private float fillAmount;

		public ReleaseArea(GameObject go)
		{
			releaseImageAlpha = go.transform.Find("greenAlpha").GetComponent<Image>();
			releaseImage = go.transform.Find("green").GetComponent<Image>();
			this.go = go;
		}

		public void SetInfo(AreaInfo areaInfo)
		{
			go.transform.localPosition = Vector3.zero;
			go.transform.localRotation = Quaternion.Euler(0f, 0f, totalAngle - areaInfo.showEndAngle);
			fillAmount = (float)(areaInfo.showEndAngle - areaInfo.showStartAngle) / 360f;
			releaseImageAlpha.fillAmount = fillAmount;
			releaseImage.fillAmount = fillAmount;
			SetActive(active: true);
		}

		public void SetActive(bool active)
		{
			go.SetActive(active);
		}

		public void ResetImage()
		{
			releaseImageAlpha.gameObject.SetActive(value: true);
			releaseImage.gameObject.SetActive(value: true);
			releaseImage.fillAmount = fillAmount;
		}

		public void SetImageFillAmount(float fillAmount)
		{
			if (fillAmount < 0.01f)
			{
				fillAmount = 0f;
			}
			releaseImage.fillAmount = fillAmount;
		}
	}

	public List<string> guideKeyList = new List<string>();

	public float angleSpeed = 6f;

	public int releaseBufferAngle = 10;

	public int pressBufferAngle = 10;

	public bool isRice;

	public float imgKeepTime = 2f;

	private EventTriggerListener eventTriggerListener;

	private Animator riceAnim;

	private SkeletonGraphic riceSkeleton;

	private GameObject riceSmoke;

	private GameObject riceEffectGo;

	private GameObject squareRiceGo;

	private Animator grindAnim;

	private ControllerEx grindCon;

	private GameObject grindEffectGo;

	private Animator resultAnim;

	public Transform dialItem;

	private Image bgImage;

	private Transform rotateHand;

	private GameObject releaseAreaGo;

	private Transform areaContent;

	private List<ControllerExCollection> controllerList = new List<ControllerExCollection>();

	private List<Animator> successAnimList = new List<Animator>();

	private GameObject successPrompt;

	private GameObject guideGo;

	private string[] guideText = new string[2] { "", "" };

	private static int totalAngle = 240;

	private bool isFinish;

	private bool isPress;

	private bool isPlayingAnim;

	private int nowTimes = 1;

	private int totalTimes = 1;

	private float nowAngle;

	private bool isStart;

	private bool isInReleaseBuffer;

	private bool isInPressBuffer;

	private bool isInRealeaseArea;

	private bool isInSomeArea;

	private bool isPhaseFinish;

	private int guideStep;

	private bool isGuide;

	private bool isFirstPointDown = true;

	private int timer;

	private int smokeTimer;

	private int nowAreaIndex;

	public List<AreaInfo> releaseAreas = new List<AreaInfo>();

	private Dictionary<int, List<AreaInfo>> phaseAreas = new Dictionary<int, List<AreaInfo>>();

	private List<AreaInfo> nowAreaList;

	private List<ReleaseArea> releaseAreaGos = new List<ReleaseArea>();

	private void Start()
	{
		resultAnim = base.transform.GetComponent<Animator>();
		eventTriggerListener = base.transform.Find("panel/middle_adapt/eventTriggerListener").GetComponent<EventTriggerListener>();
		grindAnim = base.transform.Find("panel/middle_adapt/Grind").GetComponent<Animator>();
		grindCon = base.transform.GetComponent<ControllerExCollection>().GetController("material");
		grindEffectGo = base.transform.Find("panel/middle_adapt/Grind/root").gameObject;
		Transform transform = base.transform.Find("panel/middle_adapt/SqueezeRice");
		riceAnim = transform.GetComponent<Animator>();
		riceSkeleton = transform.Find("Dmeal/spine").GetComponent<SkeletonGraphic>();
		riceSmoke = transform.Find("CuttingSmoke").gameObject;
		riceEffectGo = transform.Find("root").gameObject;
		squareRiceGo = transform.Find("plate02/squarRice").gameObject;
		bgImage = dialItem.Find("Root/Slider_brown").GetComponent<Image>();
		rotateHand = dialItem.Find("pointer/needle2");
		releaseAreaGo = dialItem.Find("AreaGo").gameObject;
		areaContent = dialItem.Find("AreaContent");
		guideGo = base.transform.Find("guidePanel").gameObject;
		object[] array = LuaHelper.CallFunction("GetTips", guideKeyList[0]);
		object[] array2 = LuaHelper.CallFunction("GetTips", guideKeyList[1]);
		guideText[0] = ((array != null) ? array[0].ToString() : "");
		guideText[1] = ((array2 != null) ? array2[0].ToString() : "");
		foreach (AreaInfo releaseArea in releaseAreas)
		{
			int phase = releaseArea.phase;
			if (!phaseAreas.ContainsKey(phase))
			{
				phaseAreas[phase] = new List<AreaInfo>();
			}
			phaseAreas[phase].Add(releaseArea);
		}
		totalTimes = phaseAreas.Count;
		for (int i = 1; i <= 3; i++)
		{
			Transform transform2 = base.transform.Find("panel/middle_adapt/stepBoard/bg/bg01/stepcontent/panel_True_layout/FryProgressMark" + i);
			if (i > totalTimes)
			{
				transform2.gameObject.SetActive(value: false);
				continue;
			}
			controllerList.Add(transform2.GetComponent<ControllerExCollection>());
			successAnimList.Add(transform2.GetComponent<Animator>());
		}
		successPrompt = base.transform.Find("panel/middle_adapt/stepBoard/bg/SuccessfulPrompt").gameObject;
		successPrompt.SetActive(value: false);
		eventTriggerListener.AddListenerType1(EventTriggerType.PointerDown, OnPointerDown);
		eventTriggerListener.AddListenerType1(EventTriggerType.PointerUp, OnPointerUp);
		CookingGameManager.Instance.UpdateProgress(new CookingGameConst.ProgressData(config.stepDescription, nowTimes - 1, totalTimes));
		GenerateQTEMap();
		nowAngle = 0f;
		if (!isRice)
		{
			isPlayingAnim = true;
			StartCoroutine(PlayAndWaitForCompletion(grindAnim, "Grind_1", delegate
			{
				isPlayingAnim = false;
				StartCoroutine(EnterGuide());
			}));
		}
		else
		{
			StartCoroutine(EnterGuide());
		}
	}

	private IEnumerator EnterGuide()
	{
		isGuide = true;
		while (guideStep == 0)
		{
			CookingGameManager.Instance.ShowGuideText(flag: true, guideText[0]);
			guideGo.SetActive(value: true);
			yield return null;
		}
		isPress = true;
		CookingGameManager.Instance.ShowGuideText(flag: true, guideText[1]);
		guideGo.SetActive(value: true);
		yield return null;
		guideGo.SetActive(value: false);
		isGuide = false;
		guideStep = 0;
		PointDownEvent();
		yield return null;
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

	private void GenerateQTEMap()
	{
		phaseAreas.TryGetValue(nowTimes, out nowAreaList);
		for (int i = 0; i < nowAreaList.Count; i++)
		{
			AreaInfo info = nowAreaList[i];
			ReleaseArea releaseArea;
			if (i >= releaseAreaGos.Count)
			{
				releaseArea = new ReleaseArea(UnityEngine.Object.Instantiate(releaseAreaGo, areaContent));
				releaseAreaGos.Add(releaseArea);
			}
			else
			{
				releaseArea = releaseAreaGos[i];
			}
			releaseArea.SetInfo(info);
		}
		for (int j = nowAreaList.Count; j < releaseAreaGos.Count; j++)
		{
			releaseAreaGos[j].SetActive(active: false);
		}
	}

	private void Update()
	{
		if (!isGuide && !isFinish && isStart && !isPlayingAnim)
		{
			nowAngle += angleSpeed * Time.deltaTime;
			rotateHand.Rotate(0f, 0f, (0f - angleSpeed) * Time.deltaTime);
			CheckPoint();
		}
	}

	private void CheckPoint()
	{
		isInSomeArea = false;
		isInReleaseBuffer = false;
		isInPressBuffer = false;
		isInRealeaseArea = false;
		AreaInfo areaInfo = null;
		if (nowAreaIndex < nowAreaList.Count)
		{
			areaInfo = nowAreaList.getValueByIndex(nowAreaIndex);
			if (nowAreaIndex + 1 < nowAreaList.Count && nowAngle > (float)(areaInfo.showEndAngle + pressBufferAngle))
			{
				nowAreaIndex++;
				areaInfo = nowAreaList.getValueByIndex(nowAreaIndex);
			}
		}
		if (areaInfo != null && nowAngle >= (float)(areaInfo.showStartAngle - releaseBufferAngle) && nowAngle <= (float)(areaInfo.showEndAngle + pressBufferAngle))
		{
			isInSomeArea = true;
			int num = areaInfo.showStartAngle + releaseBufferAngle;
			int num2 = areaInfo.showEndAngle - pressBufferAngle;
			isInReleaseBuffer = nowAngle < (float)num;
			isInPressBuffer = nowAngle > (float)num2;
			if (nowAngle >= (float)num && nowAngle <= (float)num2)
			{
				isInRealeaseArea = true;
				if (isPress)
				{
					GoNextPhase(isWin: false);
					return;
				}
			}
			if (nowAngle >= (float)areaInfo.showStartAngle && nowAngle <= (float)areaInfo.showEndAngle)
			{
				releaseAreaGos[nowAreaIndex].SetImageFillAmount(((float)areaInfo.showEndAngle - nowAngle) / 360f);
			}
		}
		else if (nowAngle >= (float)(totalAngle - pressBufferAngle))
		{
			isInSomeArea = true;
		}
		if (!isInSomeArea && !isPress)
		{
			GoNextPhase(isWin: false);
		}
		else if (nowAngle >= (float)totalAngle && !isPhaseFinish)
		{
			GoNextPhase(isWin: true);
		}
		else
		{
			bgImage.fillAmount = 0.833f - nowAngle / 360f;
		}
	}

	private void OnPointerDown(GameObject go, PointerEventData data)
	{
		if (isFinish)
		{
			return;
		}
		if (isGuide)
		{
			guideStep++;
		}
		else if (!isPlayingAnim)
		{
			isPress = true;
			PointDownEvent();
			if (isInReleaseBuffer || isInRealeaseArea)
			{
				GoNextPhase(isWin: false);
			}
		}
	}

	private void PointDownEvent()
	{
		isStart = true;
		if (isFirstPointDown)
		{
			isFirstPointDown = false;
			if (isRice)
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_pinch", useStream: false);
				riceSkeleton.timeScale = 1f;
				riceSkeleton.AnimationState.SetAnimation(0, "animation", loop: false);
			}
			else
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_pound", useStream: false);
				grindAnim.Play("Grind_2", 0, 0f);
			}
		}
		else
		{
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_tip", useStream: false);
			if (isRice)
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_pinch", useStream: false);
			}
			resultAnim.Play("success", 0, 0f);
		}
	}

	private void OnPointerUp(GameObject go, PointerEventData data)
	{
		if (isFinish)
		{
			return;
		}
		isPress = false;
		if (!isPlayingAnim)
		{
			if (isInPressBuffer)
			{
				GoNextPhase(isWin: false);
			}
			else if (isStart)
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_tip", useStream: false);
				resultAnim.Play("success", 0, 0f);
			}
		}
	}

	private void GoNextPhase(bool isWin)
	{
		if (isWin)
		{
			controllerList[nowTimes - 1].GetController("complete").SetSelectedState("true");
			successAnimList[nowTimes - 1].Play("stepsTemplate", 0, 0f);
			successAnimList[nowTimes - 1].Update(0f);
			AudioManager.Instance.Play("effect", "minigame_activity_3_9", "minigame_activity_3_9_pipe_success", useStream: false);
			nowTimes++;
			isPhaseFinish = true;
			CookingGameManager.Instance.UpdateProgress(new CookingGameConst.ProgressData(config.stepDescription, nowTimes - 1, totalTimes));
			CookingGameManager.Instance.AddStepSuccess(config.stepID);
			if (nowTimes > totalTimes)
			{
				isFinish = true;
				isStart = false;
				if (isRice)
				{
					squareRiceGo.SetActive(value: true);
					riceEffectGo.SetActive(value: true);
					riceSmoke.SetActive(value: true);
					riceSkeleton.gameObject.SetActive(value: false);
					timer = FuncTimerManager.inst.CreateFuncTimer(delegate
					{
						riceSmoke.SetActive(value: false);
						StartCoroutine(StepFinishCor());
					}, 2f, 1);
				}
				else
				{
					grindCon.SetSelectedIndex(nowTimes - 1);
					AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_pound_action_stop", useStream: false);
					StartCoroutine(PlayAndWaitForCompletion(grindAnim, "Grind_3", delegate
					{
						StartCoroutine(StepFinishCor());
					}));
				}
				return;
			}
			if (!isRice)
			{
				grindCon.SetSelectedIndex(nowTimes - 1);
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_pound_action_stop", useStream: false);
				isPlayingAnim = true;
				StartCoroutine(PlayAndWaitForCompletion(grindAnim, "Grind_3", delegate
				{
					AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_gold06", useStream: false);
					grindEffectGo.SetActive(value: true);
					timer = FuncTimerManager.inst.CreateFuncTimer(delegate
					{
						grindEffectGo.SetActive(value: false);
						StartCoroutine(PlayAndWaitForCompletion(grindAnim, "Grind_1", delegate
						{
							isPlayingAnim = false;
							rotateHand.localEulerAngles = new Vector3(0f, 0f, 120f);
							StartCoroutine(EnterGuide());
							ResetGame();
							GenerateQTEMap();
						}));
					}, 2f, 1);
				}));
				return;
			}
			isPlayingAnim = true;
			squareRiceGo.SetActive(value: true);
			riceEffectGo.SetActive(value: true);
			riceSmoke.SetActive(value: true);
			riceSkeleton.gameObject.SetActive(value: false);
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_gold06", useStream: false);
			timer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_move01", useStream: false);
				squareRiceGo.SetActive(value: false);
				riceEffectGo.SetActive(value: false);
				riceSmoke.SetActive(value: false);
				StartCoroutine(PlayAndWaitForCompletion(riceAnim, "plate", delegate
				{
					isPlayingAnim = false;
					riceSkeleton.gameObject.SetActive(value: true);
					riceSkeleton.AnimationState.ClearTracks();
					riceSkeleton.AnimationState.SetAnimation(0, "animation", loop: false);
					riceSkeleton.timeScale = 0f;
					rotateHand.localEulerAngles = new Vector3(0f, 0f, 120f);
					StartCoroutine(EnterGuide());
					ResetGame();
					GenerateQTEMap();
				}));
			}, 2f, 1);
		}
		else
		{
			if (isPlayingAnim)
			{
				return;
			}
			CookingGameManager.Instance.AddStepFailure(config.stepID);
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_negative", useStream: false);
			isPlayingAnim = true;
			StartCoroutine(PlayAndWaitForCompletion(resultAnim, "defeat", delegate
			{
				rotateHand.localEulerAngles = new Vector3(0f, 0f, 120f);
				isPlayingAnim = false;
				StartCoroutine(EnterGuide());
			}));
			if (isRice)
			{
				riceSmoke.SetActive(value: true);
				riceSkeleton.AnimationState.ClearTracks();
				riceSkeleton.AnimationState.SetAnimation(0, "animation", loop: false);
				riceSkeleton.timeScale = 0f;
				smokeTimer = FuncTimerManager.inst.CreateFuncTimer(delegate
				{
					riceSmoke.SetActive(value: false);
				}, 0.2f, 1);
			}
			else
			{
				grindAnim.Play("Grind_4", 0, 0f);
			}
			ResetGame();
		}
	}

	private IEnumerator StepFinishCor()
	{
		CookingGameManager.Instance.PlayStepPanelFinishAni();
		yield return new WaitForSeconds(imgKeepTime);
		StepFinish();
	}

	private void ResetGame()
	{
		isStart = false;
		isPress = false;
		isInReleaseBuffer = false;
		isInPressBuffer = false;
		isInRealeaseArea = false;
		nowAngle = 0f;
		nowAreaIndex = 0;
		isPhaseFinish = false;
		isFirstPointDown = true;
		foreach (ReleaseArea releaseAreaGo in releaseAreaGos)
		{
			releaseAreaGo.ResetImage();
		}
		bgImage.fillAmount = 0.833f;
	}

	public override void StepFinish()
	{
		if (timer > 0)
		{
			FuncTimerManager.inst.RemoveFuncTimer(timer);
			timer = -1;
		}
		if (smokeTimer > 0)
		{
			FuncTimerManager.inst.RemoveFuncTimer(smokeTimer);
			smokeTimer = -1;
		}
		successPrompt.SetActive(value: true);
		base.StepFinish();
	}

	public override bool IsStepCompleted()
	{
		return isFinish;
	}

	public override CookingGameConst.ProgressData GetProgress()
	{
		return new CookingGameConst.ProgressData(config.stepDescription, nowTimes - 1, totalTimes);
	}
}
