using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class PourSauceGameManager : MonoBehaviour
{
	private PourSauceStep config;

	private CookingGameConst.PourSauceGameStatus gameStatus;

	public EventTriggerListener dragEventTriggerListener;

	public Image pourZoneImage;

	public RectTransform pourZoneStartPointTrans;

	public RectTransform pourZoneEndPointTrans;

	private Vector3 pourZoneStartPoint;

	private Vector3 pourZoneEndPoint;

	private Vector2 pourZoneStart2EndVector;

	private float start2EndMagnitude;

	public Animator successAnimator;

	public GameObject endAnimatorGo;

	public PourSauceItem sauceItem;

	private RectTransform sauceItemTrans;

	public RectTransform pourSauceItemInitPointTrans;

	public RectTransform pourSauceItemDragPointTrans;

	private Vector2 lastDragPos;

	private float canvasRate;

	private Camera uiCamera;

	public RectTransform sauceFrontTrans;

	private bool isFinish;

	private bool stopLogic;

	private bool isClickedSauce;

	private float _curProgress;

	private bool isDirty;

	private float _maxProgress;

	private bool needSuccessAnim;

	private IEnumerator animCoroutine;

	private bool isProgressRising;

	private bool needDragGuide;

	private float endKeepTime;

	private bool isDragging;

	public int curSuccessCount { get; private set; }

	public float curProgress
	{
		get
		{
			return _curProgress;
		}
		private set
		{
			isDirty = isDirty || _curProgress != value;
			_curProgress = value;
		}
	}

	public float maxProgress
	{
		get
		{
			return _maxProgress;
		}
		private set
		{
			_maxProgress = value;
		}
	}

	private void Awake()
	{
		config = GetComponent<PourSauceStep>();
		uiCamera = GameObject.Find("UICamera/Canvas").GetComponent<Canvas>().worldCamera;
		canvasRate = GameObject.Find("UICamera/Canvas").GetComponent<RectTransform>().sizeDelta.x / (float)Screen.width;
		sauceItemTrans = (RectTransform)sauceItem.transform;
		pourZoneStartPoint = pourZoneStartPointTrans.localPosition;
		pourZoneEndPoint = pourZoneEndPointTrans.localPosition;
		pourZoneStart2EndVector = pourZoneEndPoint - pourZoneStartPoint;
		start2EndMagnitude = pourZoneStart2EndVector.magnitude;
		maxProgress = start2EndMagnitude;
		sauceItem.Init(this);
		dragEventTriggerListener.AddListenerType1(EventTriggerType.BeginDrag, OnBeginDrag);
		dragEventTriggerListener.AddListenerType1(EventTriggerType.Drag, OnDrag);
		dragEventTriggerListener.AddListenerType1(EventTriggerType.EndDrag, OnEndDrag);
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
		switch (gameStatus)
		{
		case CookingGameConst.PourSauceGameStatus.END:
			if (isDirty)
			{
				sauceItem.PlayRecoverAnim();
				if ((bool)CookingGameManager.Instance)
				{
					CookingGameManager.Instance.PlayStepPanelFinishAni();
				}
			}
			break;
		case CookingGameConst.PourSauceGameStatus.SUCCESS:
			if (needSuccessAnim)
			{
				needSuccessAnim = false;
				PlaySuccessAnim();
				sauceItem.PlayRecoverAnim();
				sauceItem.SetLocalPositionByTween(pourSauceItemDragPointTrans.localPosition);
			}
			break;
		}
		UpdateGuide();
		isDirty = false;
	}

	private void ResetFood()
	{
		pourZoneImage.fillAmount = 0f;
		sauceFrontTrans.gameObject.SetActive(value: false);
		isDragging = false;
	}

	public void UpdateLogic()
	{
		switch (gameStatus)
		{
		case CookingGameConst.PourSauceGameStatus.WAIT_TO_POUR_SAUCE:
			UpdateProgress();
			UpdateSuccessCount();
			break;
		case CookingGameConst.PourSauceGameStatus.END:
			endKeepTime += Time.deltaTime;
			break;
		}
	}

	public void UpdateProgress()
	{
		float num = Vector2.Dot(sauceItemTrans.localPosition - pourZoneStartPoint, pourZoneStart2EndVector) / start2EndMagnitude;
		if (num > curProgress)
		{
			curProgress = ((!(num > curProgress)) ? curProgress : ((num > maxProgress) ? maxProgress : num));
			float fillAmount = curProgress / maxProgress;
			pourZoneImage.fillAmount = fillAmount;
			sauceFrontTrans.SetAnchoredPositionX(curProgress);
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
			needSuccessAnim = true;
			if ((bool)CookingGameManager.Instance)
			{
				CookingGameManager.Instance.UpdateProgress(config.GetProgress());
			}
		}
	}

	private void UpdateStatus()
	{
		switch (gameStatus)
		{
		case CookingGameConst.PourSauceGameStatus.INIT:
			StartGame();
			break;
		case CookingGameConst.PourSauceGameStatus.WAIT_TO_CLICK_SAUCE:
			if (isClickedSauce)
			{
				SwitchToPourStatus();
			}
			break;
		case CookingGameConst.PourSauceGameStatus.WAIT_TO_POUR_SAUCE:
			if (!(curProgress >= maxProgress))
			{
				break;
			}
			if (curSuccessCount == config.totalCount)
			{
				EndGame();
				break;
			}
			SwitchToSuccessStatus();
			if ((bool)CookingGameManager.Instance)
			{
				CookingGameManager.Instance.AddStepSuccess(config.config.stepID);
			}
			break;
		case CookingGameConst.PourSauceGameStatus.SUCCESS:
			SwitchToPourStatus();
			break;
		case CookingGameConst.PourSauceGameStatus.END:
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
		gameStatus = CookingGameConst.PourSauceGameStatus.INIT;
		curSuccessCount = 0;
		isFinish = false;
	}

	private void StartGame()
	{
		gameStatus = CookingGameConst.PourSauceGameStatus.WAIT_TO_CLICK_SAUCE;
		curProgress = 0f;
		isClickedSauce = false;
		sauceFrontTrans.SetAnchoredPositionX(0f);
		sauceItem.SetLocalPosition(pourSauceItemInitPointTrans.localPosition);
		ResetFood();
		dragEventTriggerListener.SetActive(bActive: false);
		InitGuide();
	}

	private void SwitchToPourStatus()
	{
		gameStatus = CookingGameConst.PourSauceGameStatus.WAIT_TO_POUR_SAUCE;
		curProgress = 0f;
		ResetFood();
		needDragGuide = true;
	}

	private void EndGame()
	{
		gameStatus = CookingGameConst.PourSauceGameStatus.END;
		endKeepTime = 0f;
		endAnimatorGo.SetActive(value: true);
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_gold03", useStream: false);
	}

	private void SwitchToSuccessStatus()
	{
		gameStatus = CookingGameConst.PourSauceGameStatus.SUCCESS;
	}

	private void OnBeginDrag(GameObject go, PointerEventData e)
	{
		if (gameStatus == CookingGameConst.PourSauceGameStatus.WAIT_TO_POUR_SAUCE)
		{
			lastDragPos = e.position;
			sauceItem.PlayPourAnim();
			sauceFrontTrans.gameObject.SetActive(value: true);
			isDragging = true;
		}
	}

	private void OnDrag(GameObject go, PointerEventData e)
	{
		if (gameStatus == CookingGameConst.PourSauceGameStatus.WAIT_TO_POUR_SAUCE && isDragging && !(RectTransformUtility.WorldToScreenPoint(uiCamera, sauceItemTrans.position).x > e.position.x))
		{
			if (Vector2.Dot(e.position - lastDragPos, pourZoneStart2EndVector) > 0f)
			{
				Vector3 deltaLocalPosition = e.delta * canvasRate / config.thresholdDistance;
				sauceItem.SetDeltaLocalPosition(deltaLocalPosition);
			}
			lastDragPos = e.position;
		}
	}

	private void OnEndDrag(GameObject go, PointerEventData e)
	{
		if (gameStatus == CookingGameConst.PourSauceGameStatus.WAIT_TO_POUR_SAUCE && isDragging)
		{
			isDragging = false;
			sauceItem.PlayRecoverAnim();
		}
	}

	public void OnSauceClick()
	{
		if (gameStatus == CookingGameConst.PourSauceGameStatus.WAIT_TO_CLICK_SAUCE)
		{
			isClickedSauce = true;
			sauceItem.SetLocalPosition(pourSauceItemDragPointTrans.localPosition);
			dragEventTriggerListener.SetActive(bActive: true);
		}
	}

	private void PlaySuccessAnim()
	{
		stopLogic = true;
		successAnimator.enabled = true;
		successAnimator.Play("Squid_finish", 0, 0f);
		successAnimator.Update(0f);
		StartCoroutine(CheckSuccessAnim());
	}

	private IEnumerator CheckSuccessAnim()
	{
		yield return null;
		bool resetFoodCalled = false;
		while (true)
		{
			AnimatorStateInfo currentAnimatorStateInfo = successAnimator.GetCurrentAnimatorStateInfo(0);
			if (currentAnimatorStateInfo.normalizedTime >= 1f)
			{
				break;
			}
			if (!resetFoodCalled && currentAnimatorStateInfo.normalizedTime >= config.normalizeTimeForSuccessAnimCallback / 100f)
			{
				resetFoodCalled = true;
				ResetFood();
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
		needDragGuide = false;
		foreach (CookingGameConst.GuideConfig<PourSauceStep.GuideType> guideConfig in config.guideConfigList)
		{
			guideConfig.Reset();
		}
	}

	private void UpdateGuide()
	{
		foreach (CookingGameConst.GuideConfig<PourSauceStep.GuideType> guideConfig in config.guideConfigList)
		{
			switch (guideConfig.guideType)
			{
			case PourSauceStep.GuideType.CLICK:
				guideConfig.isReady = gameStatus == CookingGameConst.PourSauceGameStatus.WAIT_TO_CLICK_SAUCE;
				guideConfig.UpdateGuide();
				break;
			case PourSauceStep.GuideType.DRAG:
				if (needDragGuide)
				{
					needDragGuide = false;
					guideConfig.ShowGuide();
				}
				else if (guideConfig.isPlaying && isProgressRising)
				{
					guideConfig.HideGuide();
				}
				else
				{
					if (gameStatus != CookingGameConst.PourSauceGameStatus.WAIT_TO_POUR_SAUCE)
					{
						break;
					}
					if (!isProgressRising)
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
				break;
			}
		}
	}
}
