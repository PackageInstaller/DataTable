using System;
using System.Collections;
using Spine;
using Spine.Unity;
using UnityEngine;
using UnityEngine.EventSystems;

public class SliceMessilyGameManager : MonoBehaviour
{
	private SliceMessilyGameStep config;

	public EventTriggerListener eventTriggerListener;

	public RectTransform validZoneTrans;

	private Camera uiCamera;

	public SliceMessilyProgressItem progressItem;

	public GameObject rawFoodGo;

	public GameObject sliceFoodGo;

	public RectTransform sliceEffectTrans;

	[Header("动效")]
	public Animator cutAnimator;

	public Animator boardAnimator;

	public Animator successAnimator;

	public GameObject foodSpineGo;

	public SkeletonGraphic foodSpine;

	public string foodHitAnimName;

	public string foodIdleAnimName;

	public GameObject endAnimatorGo;

	private bool isFinish;

	private CookingGameConst.SliceMessilyGameStatus gameStatus;

	private Vector2 lastMousePos;

	private bool needCountDown;

	private bool isClicked;

	private bool isDirty;

	private float _curProgress;

	private bool isBlocking;

	private bool isCutting;

	private bool playedFirstGuide;

	private float lastGuideProgress;

	private float _curCountDownTime;

	private bool _isInCorrectZone;

	private bool isPlayingCutAnim;

	private IEnumerator animCoroutine;

	private bool isPlayingHitAnim;

	private float endKeepTime;

	private Spine.AnimationState.TrackEntryDelegate ac;

	private bool playingSliceAudio;

	public bool isProgressRising { get; private set; }

	public float curProgress
	{
		get
		{
			return _curProgress;
		}
		private set
		{
			isDirty = true;
			_curProgress = value;
		}
	}

	public float curCountDownTime
	{
		get
		{
			return _curCountDownTime;
		}
		private set
		{
			isDirty = true;
			_curCountDownTime = value;
		}
	}

	public bool isInCorrectZone
	{
		get
		{
			return _isInCorrectZone;
		}
		private set
		{
			isDirty = isDirty || _isInCorrectZone != value;
			_isInCorrectZone = value;
		}
	}

	private void Awake()
	{
		config = GetComponent<SliceMessilyGameStep>();
		uiCamera = GameObject.Find("UICamera/Canvas").GetComponent<Canvas>().worldCamera;
		eventTriggerListener.AddListenerType1(EventTriggerType.PointerDown, OnPointerDown);
		progressItem.Init(this, config);
	}

	private void OnEnable()
	{
		Input.multiTouchEnabled = false;
		InitGame();
	}

	private void OnDisable()
	{
		Input.multiTouchEnabled = true;
	}

	private void Update()
	{
		if ((bool)CookingGameManager.Instance && CookingGameManager.Instance.isPlayingPopStep)
		{
			if (isPlayingCutAnim)
			{
				isPlayingCutAnim = false;
				ResetCutParam();
				StopCutAnim();
			}
		}
		else
		{
			UpdateLogic();
			UpdateStatus();
			UpdateRender();
		}
	}

	private void UpdateRender()
	{
		switch (gameStatus)
		{
		case CookingGameConst.SliceMessilyGameStatus.SLICE:
			if (isDirty)
			{
				isDirty = false;
				RenderProgress();
				RenderCutAnim();
			}
			break;
		case CookingGameConst.SliceMessilyGameStatus.SUCCESS:
			if (isDirty)
			{
				isDirty = false;
				RenderProgress();
				StopCutAnim();
				PlaySuccessAnim();
			}
			break;
		case CookingGameConst.SliceMessilyGameStatus.FAIL:
			if (isDirty)
			{
				isDirty = false;
				RenderProgress();
				StopCutAnim();
			}
			break;
		}
		UpdateGuide();
	}

	private void RenderProgress()
	{
		progressItem.UpdateRender();
	}

	private void RenderCutAnim()
	{
		if (isInCorrectZone)
		{
			if (!isPlayingCutAnim)
			{
				PlayCutAnim();
			}
			if (config.needHitAnim && !isPlayingHitAnim)
			{
				isPlayingHitAnim = true;
				PlayHitAnim();
			}
		}
	}

	private void UpdateLogic()
	{
		switch (gameStatus)
		{
		case CookingGameConst.SliceMessilyGameStatus.SLICE:
			UpdateCountDownTime();
			HandleMouseMove();
			break;
		case CookingGameConst.SliceMessilyGameStatus.END:
			endKeepTime += Time.deltaTime;
			break;
		}
	}

	private void HandleMouseMove()
	{
		bool flag = false;
		Vector2 vector = Vector2.zero;
		if (Input.touchCount > 0)
		{
			flag = true;
			vector = new Vector2(Input.touches[0].position.x, Input.touches[0].position.y);
		}
		else if (Input.GetMouseButton(0))
		{
			flag = true;
			vector = new Vector2(Input.mousePosition.x, Input.mousePosition.y);
		}
		if (flag)
		{
			UpdateSliceEffectPos(vector);
			if (IsOnValidZone(vector))
			{
				OnMouseMove(vector);
			}
			else
			{
				ResetCutParam();
			}
			lastMousePos = vector;
		}
		else
		{
			ResetCutParam();
			lastMousePos = Vector2.zero;
		}
	}

	private void OnMouseMove(Vector2 curMousePos)
	{
		if (!lastMousePos.Equals(Vector2.zero))
		{
			float num = Vector2.Distance(lastMousePos, curMousePos);
			if (num > 0.01f)
			{
				isInCorrectZone = true;
				isProgressRising = true;
				curProgress += num / config.distanceUnit * config.risingProgressPerUnit;
				curProgress = ((curProgress > config.maxProgress) ? config.maxProgress : curProgress);
			}
			else
			{
				ResetCutParam();
			}
			lastMousePos = curMousePos;
		}
	}

	private void UpdateCountDownTime()
	{
		if (needCountDown)
		{
			curCountDownTime -= Time.deltaTime;
		}
	}

	private bool IsOnValidZone(Vector2 screenPos)
	{
		return RectTransformUtility.RectangleContainsScreenPoint(validZoneTrans, screenPos, uiCamera);
	}

	private void UpdateSliceEffectPos(Vector2 mousePos)
	{
		RectTransformUtility.ScreenPointToLocalPointInRectangle(sliceEffectTrans.parent as RectTransform, mousePos, uiCamera, out var localPoint);
		sliceEffectTrans.localPosition = localPoint;
	}

	private void UpdateStatus()
	{
		switch (gameStatus)
		{
		case CookingGameConst.SliceMessilyGameStatus.INIT:
			gameStatus = CookingGameConst.SliceMessilyGameStatus.WAIT_TO_CLICK;
			break;
		case CookingGameConst.SliceMessilyGameStatus.WAIT_TO_CLICK:
			if (isClicked)
			{
				SwitchToSliceStatus();
			}
			break;
		case CookingGameConst.SliceMessilyGameStatus.SLICE:
			if (curProgress >= config.maxProgress)
			{
				GameSuccess();
				if ((bool)CookingGameManager.Instance)
				{
					CookingGameManager.Instance.AddStepSuccess(config.config.stepID);
				}
			}
			else if (needCountDown && curCountDownTime <= 0f)
			{
				GameFail();
				if ((bool)CookingGameManager.Instance)
				{
					CookingGameManager.Instance.AddStepFailure(config.config.stepID);
				}
			}
			break;
		case CookingGameConst.SliceMessilyGameStatus.FAIL:
			if (CanRestartGame())
			{
				InitGame();
			}
			break;
		case CookingGameConst.SliceMessilyGameStatus.SUCCESS:
			if (!isBlocking)
			{
				EndGame();
			}
			break;
		case CookingGameConst.SliceMessilyGameStatus.END:
			if (endKeepTime >= config.imgKeepTime && !isFinish)
			{
				isFinish = true;
				config.StepFinish();
			}
			break;
		}
	}

	private void InitGame()
	{
		gameStatus = CookingGameConst.SliceMessilyGameStatus.INIT;
		isFinish = false;
		rawFoodGo.SetActive(value: true);
		sliceFoodGo.SetActive(value: false);
		curProgress = 0f;
		needCountDown = config.countDownTime > 0;
		curCountDownTime = config.countDownTime;
		lastMousePos = Vector2.zero;
		isClicked = false;
		isBlocking = false;
		isCutting = false;
		progressItem.InitGame();
		foodSpineGo.SetActive(config.needHitAnim);
		InitGuide();
	}

	private void EndGame()
	{
		gameStatus = CookingGameConst.SliceMessilyGameStatus.END;
		endKeepTime = 0f;
	}

	private void SwitchToSliceStatus()
	{
		gameStatus = CookingGameConst.SliceMessilyGameStatus.SLICE;
		progressItem.SwitchToSliceStatus();
	}

	private void GameSuccess()
	{
		gameStatus = CookingGameConst.SliceMessilyGameStatus.SUCCESS;
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.UpdateProgress(config.GetProgress());
		}
	}

	private void GameFail()
	{
		gameStatus = CookingGameConst.SliceMessilyGameStatus.FAIL;
	}

	private bool CanRestartGame()
	{
		return !progressItem.isBlocking;
	}

	private void ResetCutParam()
	{
		isInCorrectZone = false;
		isProgressRising = false;
	}

	private void PlayCutAnim()
	{
		isPlayingCutAnim = true;
		PlayAnimWithCallback(boardAnimator, "Board_Shake", StopCutAnim);
		PlayCutAudio();
	}

	private void StopCutAnim()
	{
		isPlayingCutAnim = false;
		boardAnimator.enabled = false;
		StopCutAudio();
	}

	private void PlayHitAnim()
	{
		if (foodSpine.AnimationState == null)
		{
			return;
		}
		foodSpine.AnimationState.SetAnimation(0, foodHitAnimName, loop: false);
		ac = delegate
		{
			isPlayingHitAnim = false;
			if (foodSpine.AnimationState != null)
			{
				foodSpine.AnimationState.Complete -= ac;
			}
		};
		foodSpine.AnimationState.Complete += ac;
	}

	private void PlaySuccessAnim()
	{
		isBlocking = true;
		successAnimator.SetActive(bActive: true);
		PlayAnimWithCallback(successAnimator, "CuttingSmoke", SuccessAnimEnd, SuccessAnimMid);
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.PlayStepPanelFinishAni();
		}
	}

	private void SuccessAnimMid()
	{
		rawFoodGo.SetActive(value: false);
		sliceFoodGo.SetActive(value: true);
		endAnimatorGo.SetActive(value: true);
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_gold03", useStream: false);
	}

	private void SuccessAnimEnd()
	{
		successAnimator.SetActive(bActive: false);
		isBlocking = false;
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

	private void StopAnimCoroutine()
	{
		if (animCoroutine != null)
		{
			StopCoroutine(animCoroutine);
		}
	}

	private IEnumerator CheckAnimEnd(Animator animator, string animName, Action callback, Action midCallback = null)
	{
		yield return null;
		bool invokedMidCallback = false;
		while (true)
		{
			AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
			if ((double)currentAnimatorStateInfo.normalizedTime >= 0.5 && !invokedMidCallback)
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
	}

	private void OnPointerDown(GameObject go, PointerEventData e)
	{
		if ((!CookingGameManager.Instance || !CookingGameManager.Instance.isPlayingPopStep) && gameStatus == CookingGameConst.SliceMessilyGameStatus.WAIT_TO_CLICK)
		{
			isClicked = true;
		}
	}

	private void InitGuide()
	{
		foreach (CookingGameConst.GuideConfig<SliceMessilyGameStep.GuideType> guideConfig in config.guideConfigList)
		{
			guideConfig.Reset();
			if (config.countDownTime > 0 && guideConfig.guideType == SliceMessilyGameStep.GuideType.PROGRESS_COUNT_DOWN)
			{
				object[] array = LuaHelper.CallFunction("GetTips", guideConfig.guidTextKey);
				if (array != null && array[0] != null && array[0] is string format)
				{
					guideConfig.guidText = string.Format(format, config.countDownTime);
				}
			}
		}
	}

	private void UpdateGuide()
	{
		foreach (CookingGameConst.GuideConfig<SliceMessilyGameStep.GuideType> guideConfig in config.guideConfigList)
		{
			switch (guideConfig.guideType)
			{
			case SliceMessilyGameStep.GuideType.PROGRESS:
				if (guideConfig.isPlaying)
				{
					if ((double)((curProgress - lastGuideProgress) / config.maxProgress) >= 0.05)
					{
						HideGuide();
					}
					else if (gameStatus == CookingGameConst.SliceMessilyGameStatus.FAIL || gameStatus == CookingGameConst.SliceMessilyGameStatus.SUCCESS)
					{
						HideGuide();
					}
				}
				else if (gameStatus == CookingGameConst.SliceMessilyGameStatus.WAIT_TO_CLICK)
				{
					if (!playedFirstGuide)
					{
						playedFirstGuide = true;
						ShowGuide();
					}
				}
				else
				{
					if (gameStatus != CookingGameConst.SliceMessilyGameStatus.SLICE)
					{
						break;
					}
					if (!isProgressRising)
					{
						guideConfig.UpdateTime(Time.deltaTime);
						if (guideConfig.TimeReady())
						{
							ShowGuide();
						}
					}
					else
					{
						guideConfig.ResetTime();
					}
				}
				break;
			case SliceMessilyGameStep.GuideType.PROGRESS_COUNT_DOWN:
				if (guideConfig.isPlaying)
				{
					if ((double)((curProgress - lastGuideProgress) / config.maxProgress) >= 0.05)
					{
						HideGuide();
					}
					else if (gameStatus == CookingGameConst.SliceMessilyGameStatus.FAIL || gameStatus == CookingGameConst.SliceMessilyGameStatus.SUCCESS)
					{
						HideGuide();
					}
				}
				else if (gameStatus == CookingGameConst.SliceMessilyGameStatus.WAIT_TO_CLICK)
				{
					if (!playedFirstGuide)
					{
						playedFirstGuide = true;
						ShowGuide();
					}
					else if (config.countDownTime > 0)
					{
						ShowGuide();
					}
				}
				break;
			}
		}
	}

	public void ShowGuide()
	{
		config.guideConfigList[0].ShowGuide();
		lastGuideProgress = curProgress;
	}

	public void HideGuide()
	{
		config.guideConfigList[0].HideGuide();
	}

	private void PlayCutAudio()
	{
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_cut02_loop", useStream: false);
	}

	private void StopCutAudio()
	{
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_cut02_loop_action_stop", useStream: false);
	}
}
