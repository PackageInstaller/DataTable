using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;

public class RollBeefGameManager : MonoBehaviour
{
	private RollBeefGameStep config;

	private CookingGameConst.RollBeefGameStatus gameStatus;

	public RectTransform wrapperMaskTrans;

	public RectTransform rollPartTrans;

	public RectTransform rollBackImageTrans;

	public EventTriggerListener eventTriggerListener;

	private Vector2 lastDragPos;

	private float canvasRate;

	private Camera uiCamera;

	public Animator successAnimator;

	public GameObject endAnimatorGo;

	private bool isFinish;

	private Vector3 rollPartInitAnchoredPos;

	private Vector3 rollBackImageInitPos;

	private Vector3 wrapperMaskInitPos;

	private Vector2 wrapperMaskInitSizeDelta;

	private bool needSuccessAnim;

	private IEnumerator animCoroutine;

	private bool isProgressRising;

	private bool needGuide;

	private float endKeepTime;

	private bool playedRollAudio;

	public int curSuccessCount { get; private set; }

	public float curProgress { get; private set; }

	public float maxProgress { get; private set; }

	public bool stopLogic { get; private set; }

	private void Awake()
	{
		config = GetComponent<RollBeefGameStep>();
		config.gameManager = this;
		GameObject gameObject = GameObject.Find("UICamera/Canvas");
		uiCamera = gameObject.GetComponent<Canvas>().worldCamera;
		canvasRate = gameObject.GetComponent<RectTransform>().sizeDelta.x / (float)Screen.width;
		rollPartInitAnchoredPos = rollPartTrans.anchoredPosition;
		rollBackImageInitPos = rollBackImageTrans.localPosition;
		wrapperMaskInitPos = wrapperMaskTrans.localPosition;
		wrapperMaskInitSizeDelta = wrapperMaskTrans.sizeDelta;
		maxProgress = 0f - rollPartInitAnchoredPos.y;
		eventTriggerListener.AddListenerType1(EventTriggerType.BeginDrag, OnBeginDrag);
		eventTriggerListener.AddListenerType1(EventTriggerType.Drag, OnDrag);
		eventTriggerListener.AddListenerType1(EventTriggerType.EndDrag, OnEndDrag);
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
		if (!stopLogic)
		{
			UpdateLogic();
			UpdateStatus();
		}
		UpdateRender();
	}

	private void UpdateRender()
	{
		if (needSuccessAnim)
		{
			needSuccessAnim = false;
			PlaySuccessAnim();
		}
		UpdateGuide();
	}

	private void UpdateLogic()
	{
		switch (gameStatus)
		{
		case CookingGameConst.RollBeefGameStatus.WAIT_TO_ROLL:
			UpdateProgress();
			UpdateSuccessCount();
			break;
		case CookingGameConst.RollBeefGameStatus.END:
			endKeepTime += Time.deltaTime;
			break;
		}
	}

	private void UpdateProgress()
	{
		float num = maxProgress + rollPartTrans.anchoredPosition.y;
		if (num > curProgress)
		{
			curProgress = num;
			isProgressRising = true;
		}
		else
		{
			isProgressRising = false;
		}
	}

	private void UpdateSuccessCount()
	{
		if (curProgress >= maxProgress)
		{
			curSuccessCount++;
			if (curSuccessCount != config.totalCount)
			{
				needSuccessAnim = true;
			}
		}
	}

	private void ResetRollStatus()
	{
		rollPartTrans.anchoredPosition = rollPartInitAnchoredPos;
		rollBackImageTrans.localPosition = rollBackImageInitPos;
		wrapperMaskTrans.localPosition = wrapperMaskInitPos;
		wrapperMaskTrans.sizeDelta = wrapperMaskInitSizeDelta;
	}

	private void UpdateStatus()
	{
		switch (gameStatus)
		{
		case CookingGameConst.RollBeefGameStatus.INIT:
			StartGame();
			break;
		case CookingGameConst.RollBeefGameStatus.WAIT_TO_ROLL:
			if (curProgress >= maxProgress)
			{
				if ((bool)CookingGameManager.Instance)
				{
					CookingGameManager.Instance.UpdateProgress(config.GetProgress());
				}
				if (curSuccessCount == config.totalCount)
				{
					EndGame();
					break;
				}
				SwitchToSuccessStatus();
				CookingGameManager.Instance.AddStepSuccess(config.config.stepID);
			}
			break;
		case CookingGameConst.RollBeefGameStatus.SUCCESS:
			StartGame();
			break;
		case CookingGameConst.RollBeefGameStatus.END:
			if (endKeepTime >= config.imgKeepTime && !isFinish)
			{
				isFinish = true;
				config.StepFinish();
			}
			break;
		}
	}

	private void StartGame()
	{
		gameStatus = CookingGameConst.RollBeefGameStatus.WAIT_TO_ROLL;
		curProgress = 0f;
		ResetRollStatus();
		InitGuide();
	}

	private void EndGame()
	{
		gameStatus = CookingGameConst.RollBeefGameStatus.END;
		endAnimatorGo.SetActive(value: true);
		CookingGameManager.Instance.PlayStepPanelFinishAni();
		endKeepTime = 0f;
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_gold03", useStream: false);
	}

	private void InitGame()
	{
		gameStatus = CookingGameConst.RollBeefGameStatus.INIT;
		isFinish = false;
		curSuccessCount = 0;
	}

	private void SwitchToSuccessStatus()
	{
		gameStatus = CookingGameConst.RollBeefGameStatus.SUCCESS;
	}

	private void OnBeginDrag(GameObject go, PointerEventData e)
	{
		if (gameStatus == CookingGameConst.RollBeefGameStatus.WAIT_TO_ROLL)
		{
			lastDragPos = e.position;
		}
	}

	private void OnDrag(GameObject go, PointerEventData e)
	{
		if (gameStatus == CookingGameConst.RollBeefGameStatus.WAIT_TO_ROLL && !(e.position.y - lastDragPos.y < 0.001f))
		{
			Vector3 canvasMoveDelta = e.delta * canvasRate / config.thresholdDistance;
			UpdateRollPartPosition(canvasMoveDelta);
			UpdateRollBackImageLocalPosition(canvasMoveDelta);
			UpdateWrapperMaskHeight(canvasMoveDelta);
			lastDragPos = e.position;
			if (!playedRollAudio)
			{
				playedRollAudio = true;
				AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_roll", useStream: false);
			}
		}
	}

	private void OnEndDrag(GameObject rollPartGo, PointerEventData e)
	{
		playedRollAudio = false;
	}

	private void UpdateRollPartPosition(Vector3 canvasMoveDelta)
	{
		Vector3 localPosition = rollPartTrans.localPosition;
		localPosition.y += canvasMoveDelta.y;
		rollPartTrans.localPosition = localPosition;
	}

	private void UpdateRollBackImageLocalPosition(Vector3 canvasMoveDelta)
	{
		Vector3 localPosition = rollBackImageTrans.localPosition;
		localPosition.y += canvasMoveDelta.y;
		rollBackImageTrans.localPosition = localPosition;
	}

	private void UpdateWrapperMaskHeight(Vector3 canvasMoveDelta)
	{
		Vector2 sizeDelta = wrapperMaskTrans.sizeDelta;
		sizeDelta.y -= canvasMoveDelta.y;
		wrapperMaskTrans.sizeDelta = sizeDelta;
	}

	private void PlaySuccessAnim()
	{
		stopLogic = true;
		successAnimator.enabled = true;
		successAnimator.Play("RollBeef_finish", 0, 0f);
		successAnimator.Update(0f);
		StartCoroutine(CheckSuccessAnim());
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_move03", useStream: false);
	}

	private IEnumerator CheckSuccessAnim()
	{
		yield return null;
		while (true)
		{
			AnimatorStateInfo currentAnimatorStateInfo = successAnimator.GetCurrentAnimatorStateInfo(0);
			if (currentAnimatorStateInfo.normalizedTime >= 1f)
			{
				break;
			}
			if (currentAnimatorStateInfo.normalizedTime >= config.normalizeTimeForSuccessAnimCallback / 100f)
			{
				ResetRollStatus();
			}
			yield return null;
		}
		successAnimator.enabled = false;
		SuccessAnimEnd();
	}

	private void SuccessAnimEnd()
	{
		stopLogic = false;
	}

	private void InitGuide()
	{
		needGuide = true;
		foreach (CookingGameConst.GuideConfig<RollBeefGameStep.GuideType> guideConfig in config.guideConfigList)
		{
			guideConfig.Reset();
		}
	}

	private void UpdateGuide()
	{
		foreach (CookingGameConst.GuideConfig<RollBeefGameStep.GuideType> guideConfig in config.guideConfigList)
		{
			if (guideConfig.guideType != RollBeefGameStep.GuideType.DRAG)
			{
				continue;
			}
			if (guideConfig.isPlaying && isProgressRising)
			{
				guideConfig.HideGuide();
			}
			else if (needGuide)
			{
				needGuide = false;
				guideConfig.ShowGuide();
			}
			else if (gameStatus == CookingGameConst.RollBeefGameStatus.WAIT_TO_ROLL && !isProgressRising)
			{
				guideConfig.UpdateTime(Time.deltaTime);
				if (guideConfig.TimeReady())
				{
					guideConfig.ShowGuide();
				}
			}
			else
			{
				guideConfig.ResetTime();
			}
		}
	}
}
