using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class FryingGameManager : MonoBehaviour
{
	private CookingGameConst.FryingGameStatus gameStatus;

	private FryingStep config;

	public RectTransform rawFoodPlateTrans;

	public RectTransform cookedFoodPlateTrans;

	public RectTransform fryingPanTrans;

	public RectTransform fryingFoodContainerTrans;

	public GameObject foodItemGo;

	public RectTransform dragPanelTrans;

	private Camera uiCamera;

	public GameObject progressMarkGo;

	public RectTransform successProgressMarkContent;

	public RectTransform failProgressMarkContent;

	private List<FryingGameProgressMark> successMarkList = new List<FryingGameProgressMark>();

	private List<FryingGameProgressMark> failMarkList = new List<FryingGameProgressMark>();

	private FryingFoodItem rawDisplayFoodItem;

	private FryingFoodItem needCookFoodItem;

	private float canvasRate;

	private List<FryingFoodItem> cookedFoodItemList = new List<FryingFoodItem>();

	public FryingTemperatureItem fryingTemperatureItem;

	public Animator oilAnimator;

	public Animator successPlateAnimator;

	public Animator successMarkAnimator;

	public Animator failMarkAnimator;

	public GameObject endAnimatorGo;

	private bool isFinish;

	private Vector2 mousePosition;

	private bool isFoodDragged;

	private bool isDraggingSuccessFood;

	private bool isSuccessFoodDragged;

	private bool needToFlipFood;

	private bool isPlayingOilAnim;

	private bool isPlayingSuccessPlateAnim;

	private bool isPlayingSuccessMark;

	private bool isPlayingFailMark;

	private bool needFlipGuide;

	private float endKeepTime;

	private bool playingOilLoopAudio;

	private bool playingCookLoopAudio;

	public bool stopLogic
	{
		get
		{
			if ((bool)needCookFoodItem)
			{
				return needCookFoodItem.NeedStopLogic();
			}
			return false;
		}
	}

	public int curSuccessMarkCount { get; private set; }

	public int curFailMarkCount { get; private set; }

	public int curSuccessFoodCount { get; private set; }

	private void Start()
	{
		config = GetComponent<FryingStep>();
		config.gameManager = this;
		rawDisplayFoodItem = CreateFoodItem();
		rawDisplayFoodItem.SetIsInteractive(value: false);
		needCookFoodItem = CreateFoodItem();
		needCookFoodItem.SetIsInteractive(value: true);
		GameObject gameObject = GameObject.Find("UICamera/Canvas");
		uiCamera = gameObject.GetComponent<Canvas>().worldCamera;
		canvasRate = gameObject.GetComponent<RectTransform>().sizeDelta.x / (float)Screen.width;
		fryingTemperatureItem.gameManager = this;
		fryingTemperatureItem.config = config;
	}

	private void OnEnable()
	{
		StartGame();
	}

	private void OnDisable()
	{
		StopOilLoopAudio();
		StopCookLoopAudio();
	}

	private void Update()
	{
		UpdateGame();
	}

	private void StartGame()
	{
		SwitchToInitStatus();
	}

	private void UpdateGame()
	{
		if (!stopLogic)
		{
			UpdateGameLogic();
		}
		if (!stopLogic)
		{
			UpdateGameStatus();
		}
		UpdateGameRender();
		UpdateGuide();
	}

	private void UpdateGameLogic()
	{
		switch (gameStatus)
		{
		case CookingGameConst.FryingGameStatus.COOKING:
			UpdateTemperatureLogic();
			CheckMaxTemperature();
			UpdateFoodLogic();
			UpdateProgressMarkLogic();
			break;
		case CookingGameConst.FryingGameStatus.END:
			endKeepTime += Time.deltaTime;
			break;
		}
	}

	private void CheckMaxTemperature()
	{
		if (fryingTemperatureItem.curTemperature > fryingTemperatureItem.maxSuccessTemperature)
		{
			curFailMarkCount++;
			fryingTemperatureItem.OnFailMarkAdd();
			needCookFoodItem.OnFailMarkAdd();
			needFlipGuide = true;
		}
	}

	private void UpdateProgress()
	{
		float curTemperature = fryingTemperatureItem.curTemperature;
		if (curTemperature >= fryingTemperatureItem.minSuccessTemperature && curTemperature <= fryingTemperatureItem.maxSuccessTemperature)
		{
			curSuccessMarkCount++;
			if (curSuccessMarkCount == config.markCountForSuccess)
			{
				curSuccessFoodCount++;
			}
			needFlipGuide = false;
		}
		else if (curTemperature > fryingTemperatureItem.maxSuccessTemperature)
		{
			curFailMarkCount++;
			fryingTemperatureItem.OnFailMarkAdd();
			needCookFoodItem.OnFailMarkAdd();
			needFlipGuide = true;
		}
	}

	private void UpdateTemperatureLogic()
	{
		fryingTemperatureItem.UpdateLogic();
	}

	private void UpdateProgressMarkLogic()
	{
		for (int i = 0; i < config.markCountForSuccess; i++)
		{
			successMarkList[i].UpdateLogic();
		}
		for (int j = 0; j < config.markCountForFail; j++)
		{
			failMarkList[j].UpdateLogic();
		}
	}

	private void UpdateGameStatus()
	{
		switch (gameStatus)
		{
		case CookingGameConst.FryingGameStatus.INIT:
			SwitchToPrepareStatus();
			break;
		case CookingGameConst.FryingGameStatus.PREPARE:
			SwitchToWaitToDragFoodStatus();
			break;
		case CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_FOOD:
			if (isFoodDragged)
			{
				SwitchToCookingStatus();
			}
			break;
		case CookingGameConst.FryingGameStatus.COOKING:
			if (curFailMarkCount == config.markCountForFail)
			{
				SwitchToPrepareStatus();
			}
			else if (needToFlipFood)
			{
				SwitchToFlipFoodStatus();
			}
			break;
		case CookingGameConst.FryingGameStatus.FLIP_FOOD:
			if (curFailMarkCount == config.markCountForFail)
			{
				SwitchToPrepareStatus();
				CookingGameManager.Instance.AddStepFailure(config.config.stepID);
			}
			else if (curSuccessMarkCount == config.markCountForSuccess)
			{
				SwitchToWaitToDragSuccessFoodStatus();
				CookingGameManager.Instance.AddStepSuccess(config.config.stepID);
			}
			else
			{
				RestartCookingStatus();
			}
			break;
		case CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_SUCCESS_FOOD:
			if (isSuccessFoodDragged)
			{
				if (curSuccessFoodCount == config.foodCount)
				{
					SwitchToEndStatus();
				}
				else
				{
					SwitchToPrepareStatus();
				}
			}
			break;
		case CookingGameConst.FryingGameStatus.END:
			if (endKeepTime >= config.imgKeepTime && !isFinish)
			{
				isFinish = true;
				config.StepFinish();
				StopOilLoopAudio();
			}
			break;
		}
	}

	private void SwitchToInitStatus()
	{
		gameStatus = CookingGameConst.FryingGameStatus.INIT;
		curSuccessFoodCount = 0;
		isFinish = false;
		RenderInitStatus();
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_stove_loop", useStream: false);
		playingOilLoopAudio = true;
	}

	private void SwitchToPrepareStatus()
	{
		gameStatus = CookingGameConst.FryingGameStatus.PREPARE;
		PrepareCookData();
		InitGuide();
		PlayOilLoopAudio();
	}

	private void PrepareCookData()
	{
		isFoodDragged = false;
		isSuccessFoodDragged = false;
		needToFlipFood = false;
		curSuccessMarkCount = 0;
		curFailMarkCount = 0;
		needFlipGuide = false;
		if (needCookFoodItem == null)
		{
			needCookFoodItem = CreateFoodItem();
			needCookFoodItem.SetIsInteractive(value: true);
		}
	}

	private void SwitchToWaitToDragFoodStatus()
	{
		gameStatus = CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_FOOD;
	}

	private void SwitchToCookingStatus()
	{
		gameStatus = CookingGameConst.FryingGameStatus.COOKING;
		isFoodDragged = false;
		fryingTemperatureItem.InitStatus();
		needCookFoodItem.InitStatus();
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_sizzle_first", useStream: false);
		PlayCookLoopAudio();
	}

	private void RestartCookingStatus()
	{
		gameStatus = CookingGameConst.FryingGameStatus.COOKING;
		isFoodDragged = false;
		fryingTemperatureItem.Reset();
	}

	private void SwitchToFlipFoodStatus()
	{
		gameStatus = CookingGameConst.FryingGameStatus.FLIP_FOOD;
		needToFlipFood = false;
		UpdateProgress();
		UpdateProgressMarkLogic();
		UpdateTemperatureLogic();
		FlipFood();
	}

	private void SwitchToWaitToDragSuccessFoodStatus()
	{
		gameStatus = CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_SUCCESS_FOOD;
		isSuccessFoodDragged = false;
		StopCookLoopAudio();
	}

	private void SwitchToEndStatus()
	{
		gameStatus = CookingGameConst.FryingGameStatus.END;
		endKeepTime = 0f;
		endAnimatorGo.SetActive(value: true);
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.PlayStepPanelFinishAni();
		}
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_gold03", useStream: false);
	}

	private void UpdateGameRender()
	{
		switch (gameStatus)
		{
		case CookingGameConst.FryingGameStatus.PREPARE:
			RenderPrepareStatus();
			break;
		case CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_FOOD:
			RenderWaitToAddFood();
			break;
		case CookingGameConst.FryingGameStatus.COOKING:
			RenderCookingStatus();
			break;
		case CookingGameConst.FryingGameStatus.FLIP_FOOD:
			RenderFlipFoodStatus();
			break;
		case CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_SUCCESS_FOOD:
			RenderWaitToDragSuccessFoodStatus();
			break;
		}
	}

	private void RenderInitStatus()
	{
		foreach (FryingFoodItem cookedFoodItem in cookedFoodItemList)
		{
			cookedFoodItem.SetActive(value: false);
		}
	}

	private void RenderPrepareStatus()
	{
		ResetFoodItem(rawDisplayFoodItem);
		ResetFoodItem(needCookFoodItem);
		InitProgressMark();
		fryingTemperatureItem.SetActive(value: false);
		StopSuccessPlateAnim();
		StopSuccessMarkAnim();
		StopFailMarkAnim();
	}

	private void InitProgressMark()
	{
		for (int i = 0; i < config.markCountForSuccess; i++)
		{
			if (successMarkList.Count <= i)
			{
				FryingGameProgressMark component = Object.Instantiate(progressMarkGo, successProgressMarkContent).GetComponent<FryingGameProgressMark>();
				component.Init(this, i, isSuccessMark: true);
				successMarkList.Add(component);
			}
			successMarkList[i].Reset();
		}
		for (int j = 0; j < config.markCountForFail; j++)
		{
			if (failMarkList.Count <= j)
			{
				FryingGameProgressMark component2 = Object.Instantiate(progressMarkGo, failProgressMarkContent).GetComponent<FryingGameProgressMark>();
				component2.Init(this, j, isSuccessMark: false);
				failMarkList.Add(component2);
			}
			failMarkList[j].Reset();
		}
	}

	private void RenderWaitToAddFood()
	{
		rawDisplayFoodItem.UpdateRender();
		needCookFoodItem.UpdateRender();
		RenderPan();
	}

	private void RenderCookingStatus()
	{
		fryingTemperatureItem.UpdateRender();
		needCookFoodItem.UpdateRender();
		RenderProgressMark();
		RenderPan();
	}

	private void RenderFlipFoodStatus()
	{
		needCookFoodItem.UpdateRender();
		fryingTemperatureItem.UpdateRender();
		RenderProgressMark();
	}

	private void RenderWaitToDragSuccessFoodStatus()
	{
		needCookFoodItem.UpdateRender();
		fryingTemperatureItem.SetActive(value: false);
		RenderProgressMark();
		RenderSuccessPlate();
	}

	private void RenderProgressMark()
	{
		for (int i = 0; i < config.markCountForSuccess; i++)
		{
			successMarkList[i].UpdateRender();
		}
		for (int j = 0; j < config.markCountForFail; j++)
		{
			failMarkList[j].UpdateRender();
		}
		RenderSuccessMarkAnim();
		RenderFailMarkAnim();
	}

	private void RenderSuccessMarkAnim()
	{
		if (curSuccessMarkCount == config.markCountForSuccess)
		{
			if (!isPlayingSuccessMark)
			{
				PlaySuccessMarkAnim();
			}
		}
		else if (isPlayingSuccessMark)
		{
			StopSuccessMarkAnim();
		}
	}

	private void RenderFailMarkAnim()
	{
		if (curFailMarkCount == config.markCountForFail)
		{
			if (!isPlayingFailMark)
			{
				PlayFailMarkAnim();
			}
		}
		else if (isPlayingFailMark)
		{
			StopFailMarkAnim();
		}
	}

	private void RenderPan()
	{
	}

	private void RenderSuccessPlate()
	{
		if (gameStatus == CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_SUCCESS_FOOD && isDraggingSuccessFood && IsInSuccessPlateRange(mousePosition))
		{
			if (!isPlayingSuccessPlateAnim)
			{
				PlaySuccessPlateAnim();
			}
		}
		else if (isPlayingSuccessPlateAnim)
		{
			StopSuccessPlateAnim();
		}
	}

	private bool IsInSuccessPlateRange(Vector2 screenPos)
	{
		return RectTransformUtility.RectangleContainsScreenPoint(cookedFoodPlateTrans, screenPos, uiCamera);
	}

	private void UpdateFoodLogic()
	{
		needCookFoodItem.UpdateLogic();
	}

	private void FlipFood()
	{
		needCookFoodItem.UpdateLogic();
		needCookFoodItem.FlipFood();
	}

	private FryingFoodItem CreateFoodItem()
	{
		FryingFoodItem component = Object.Instantiate(foodItemGo, rawFoodPlateTrans).GetComponent<FryingFoodItem>();
		component.SetActive(value: true);
		component.gameManager = this;
		component.config = config;
		ResetFoodItem(component);
		return component;
	}

	private void ResetFoodItem(FryingFoodItem foodItem)
	{
		foodItem.transform.SetParent(rawFoodPlateTrans);
		foodItem.Reset();
	}

	private void AddSuccessFoodItem()
	{
		if (cookedFoodItemList.Count < curSuccessFoodCount)
		{
			cookedFoodItemList.Add(needCookFoodItem);
		}
		needCookFoodItem.transform.SetParent(cookedFoodPlateTrans);
		needCookFoodItem.SetLocalPosition(Vector3.zero);
		needCookFoodItem.SetLocalScale(Vector3.one);
		needCookFoodItem.SetIsInteractive(value: false);
		needCookFoodItem.ResetAnimStatus();
		needCookFoodItem = null;
	}

	public void OnFoodBeginDrag(FryingFoodItem foodItem, PointerEventData e)
	{
		if (!(needCookFoodItem != foodItem) && (gameStatus == CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_FOOD || gameStatus == CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_SUCCESS_FOOD))
		{
			if (gameStatus == CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_FOOD)
			{
				foodItem.SetLocalScale(config.foodScale);
			}
			foodItem.transform.SetParent(dragPanelTrans);
			AudioManager.Instance.Play("effect", "minigame_activity_3_10", "minigame_activity_3_10_cook_pick", useStream: false);
		}
	}

	public void OnFoodDrag(FryingFoodItem foodItem, PointerEventData e)
	{
		if (!(needCookFoodItem != foodItem) && (gameStatus == CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_FOOD || gameStatus == CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_SUCCESS_FOOD))
		{
			mousePosition = e.position;
			Vector3 deltaLocalPosition = e.delta * canvasRate;
			foodItem.SetDeltaLocalPosition(deltaLocalPosition);
			if (gameStatus == CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_SUCCESS_FOOD)
			{
				isDraggingSuccessFood = true;
			}
		}
	}

	public void OnFoodEndDrag(FryingFoodItem foodItem, PointerEventData e)
	{
		if (needCookFoodItem != foodItem || (gameStatus != CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_FOOD && gameStatus != CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_SUCCESS_FOOD))
		{
			return;
		}
		if (gameStatus == CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_FOOD)
		{
			if (RectTransformUtility.RectangleContainsScreenPoint(fryingPanTrans, e.position, uiCamera))
			{
				foodItem.transform.SetParent(fryingFoodContainerTrans);
				foodItem.SetLocalPosition(Vector3.zero);
				isFoodDragged = true;
			}
			else
			{
				foodItem.ResetPosition();
			}
		}
		else if (gameStatus == CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_SUCCESS_FOOD)
		{
			if (RectTransformUtility.RectangleContainsScreenPoint(cookedFoodPlateTrans, e.position, uiCamera))
			{
				isDraggingSuccessFood = false;
				isSuccessFoodDragged = true;
				AddSuccessFoodItem();
				if ((bool)CookingGameManager.Instance)
				{
					CookingGameManager.Instance.UpdateProgress(config.GetProgress());
				}
				StopSuccessPlateAnim();
			}
			else
			{
				foodItem.ResetPosition();
			}
		}
		AudioManager.Instance.Play("effect", "minigame_activity_3_10", "minigame_activity_3_10_cook_down", useStream: false);
	}

	public void OnClickFood()
	{
		if (gameStatus == CookingGameConst.FryingGameStatus.COOKING)
		{
			needToFlipFood = true;
		}
	}

	private void PlaySuccessPlateAnim()
	{
		isPlayingSuccessPlateAnim = true;
		successPlateAnimator.SetActive(bActive: true);
		successPlateAnimator.enabled = true;
		successPlateAnimator.Play("prompt", 0, 0f);
		successPlateAnimator.Update(0f);
	}

	private void StopSuccessPlateAnim()
	{
		isPlayingSuccessPlateAnim = false;
		successPlateAnimator.enabled = false;
		successPlateAnimator.SetActive(bActive: false);
	}

	private void PlaySuccessMarkAnim()
	{
		isPlayingSuccessMark = true;
		successMarkAnimator.SetActive(bActive: true);
		successMarkAnimator.enabled = true;
		successMarkAnimator.Play("SuccessfulPrompt", 0, 0f);
		successMarkAnimator.Update(0f);
	}

	private void StopSuccessMarkAnim()
	{
		isPlayingSuccessMark = false;
		successMarkAnimator.enabled = false;
		successMarkAnimator.SetActive(bActive: false);
	}

	private void PlayFailMarkAnim()
	{
		isPlayingFailMark = true;
		failMarkAnimator.SetActive(bActive: true);
		failMarkAnimator.enabled = true;
		failMarkAnimator.Play("SuccessfulPrompt", 0, 0f);
		failMarkAnimator.Update(0f);
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_negative", useStream: false);
	}

	private void StopFailMarkAnim()
	{
		isPlayingFailMark = false;
		failMarkAnimator.enabled = false;
		failMarkAnimator.SetActive(bActive: false);
	}

	private void InitGuide()
	{
		foreach (CookingGameConst.GuideConfig<FryingStep.GuideType> guideConfig in config.guideConfigList)
		{
			guideConfig.Reset();
		}
	}

	private void UpdateGuide()
	{
		foreach (CookingGameConst.GuideConfig<FryingStep.GuideType> guideConfig in config.guideConfigList)
		{
			switch (guideConfig.guideType)
			{
			case FryingStep.GuideType.DRAG_RAW_FOOD:
				guideConfig.isReady = gameStatus == CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_FOOD;
				guideConfig.UpdateGuide();
				break;
			case FryingStep.GuideType.FLIP_FOOD:
			{
				bool isReady = false;
				if (gameStatus == CookingGameConst.FryingGameStatus.COOKING && (curSuccessMarkCount == 0 || needFlipGuide) && !needCookFoodItem.NeedStopLogic())
				{
					isReady = true;
				}
				guideConfig.isReady = isReady;
				guideConfig.UpdateGuide();
				break;
			}
			case FryingStep.GuideType.DRAG_COOKED_FOOD:
				guideConfig.isReady = gameStatus == CookingGameConst.FryingGameStatus.WAIT_TO_DRAG_SUCCESS_FOOD;
				guideConfig.UpdateGuide();
				break;
			}
		}
	}

	private void PlayOilLoopAudio()
	{
		if (!playingOilLoopAudio)
		{
			playingOilLoopAudio = true;
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_stove_loop", useStream: false);
		}
	}

	private void StopOilLoopAudio()
	{
		if (playingOilLoopAudio)
		{
			playingOilLoopAudio = false;
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_stove_loop_action_stop", useStream: false);
		}
	}

	private void PlayCookLoopAudio()
	{
		if (!playingCookLoopAudio)
		{
			playingCookLoopAudio = true;
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_sizzle01_loop", useStream: false);
		}
	}

	private void StopCookLoopAudio()
	{
		if (playingCookLoopAudio)
		{
			playingCookLoopAudio = false;
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_sizzle01_loop_action_stop", useStream: false);
		}
	}
}
