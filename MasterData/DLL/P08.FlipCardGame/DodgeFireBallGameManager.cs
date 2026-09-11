using System;
using System.Collections;
using System.Collections.Generic;
using ControllerExSpace;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class DodgeFireBallGameManager : MonoBehaviour
{
	private DodgeFireBallGameStep config;

	public RectTransform tableItemContentTrans;

	public RectTransform bloodItemContentTrans;

	public GameObject bloodItemGo;

	public DodgeFireBallGamePad gamePad;

	public DodgeFoodItem foodItem;

	private List<List<DodgeTableItem>> tableItemMap = new List<List<DodgeTableItem>>();

	private List<DodgeBloodItem> bloodItemList = new List<DodgeBloodItem>();

	public DodgeFireBallFailView failView;

	public RectTransform fireBallContainerTrans;

	public GameObject playPanelGo;

	public GameObject enterPanelGo;

	public Text enterTalkText;

	public Animator enterTalkAnimator;

	public Animator enterFireAnimator;

	public Animator enterTipsAnimator;

	public Animator hurtAnimator;

	public ControllerExCollection forceGuideControllerEx;

	private ControllerEx forceGuideController;

	public RectTransform gamePageGuideTrans;

	public RectTransform warningGuideTrans;

	public RectTransform burnGuideTrans;

	public RectTransform warmGuideTrans;

	public EventTriggerListener guideCloseBtn;

	public EventTriggerListener guideDialogBtn;

	public Text guideDialogText;

	private CookingGameConst.DodgeFireBallGameStatus gameStatus;

	private bool isLogicBlocking;

	private float _playTime;

	private bool isHurt;

	private int _curBlood;

	private bool needPopFailView;

	private List<DodgeFireBallEvent> dodgeFireBallEventList = new List<DodgeFireBallEvent>();

	private int fireBallEventIndex;

	private bool isEnter;

	private bool isEnterAnimPlaying;

	private IEnumerator animCoroutine;

	private bool isPlayingGuide;

	private bool _needGuide;

	private Dictionary<DodgeFireBallGameStep.GuideType, DodgeFireBallGameStep.GuideStatus> guideStatusDic;

	public Camera uiCamera { get; set; }

	public float playTime
	{
		get
		{
			return _playTime;
		}
		private set
		{
			_playTime = value;
		}
	}

	public float curProgress => foodItem.curProgress;

	public int curBlood
	{
		get
		{
			return _curBlood;
		}
		set
		{
			if (value < _curBlood)
			{
				isHurt = true;
			}
			_curBlood = value;
		}
	}

	private bool needGuide
	{
		get
		{
			return _needGuide;
		}
		set
		{
			_needGuide = value;
		}
	}

	private void Awake()
	{
		config = GetComponent<DodgeFireBallGameStep>();
		uiCamera = GameObject.Find("UICamera/Canvas").GetComponent<Canvas>().worldCamera;
		failView.manager = this;
		InitTableItem();
		InitBloodItem();
		InitFoodItem();
		RegisterInputCallback();
		forceGuideController = forceGuideControllerEx.GetController("forceGuide");
		guideCloseBtn.AddListenerType1(EventTriggerType.PointerClick, OnClickCloseGuideBtn);
		guideDialogBtn.AddListenerType1(EventTriggerType.PointerClick, OnClickCloseGuideBtn);
		playPanelGo.SetActive(value: false);
		enterPanelGo.SetActive(value: true);
	}

	private void OnEnable()
	{
		isEnter = true;
		SwitchToInitStatus();
	}

	private void Update()
	{
		if (!isPlayingGuide)
		{
			if (!isLogicBlocking)
			{
				UpdateLogic();
				UpdateStatus();
			}
			UpdateRender();
		}
	}

	private void InitTableItem()
	{
		int childCount = tableItemContentTrans.childCount;
		int num = 3;
		int num2 = 3;
		for (int i = 0; i < childCount; i++)
		{
			int num3 = i / num;
			int num4 = i % num2;
			DodgeTableItem component = tableItemContentTrans.GetChild(i).GetComponent<DodgeTableItem>();
			component.Init(num3, num4);
			component.gameManager = this;
			component.config = config;
			if (num3 == tableItemMap.Count)
			{
				tableItemMap.Add(new List<DodgeTableItem>());
			}
			if (num4 == tableItemMap[num3].Count)
			{
				tableItemMap[num3].Add(component);
			}
		}
	}

	private void InitBloodItem()
	{
		for (int i = 1; i <= config.bloodCount; i++)
		{
			if (i > bloodItemList.Count)
			{
				GameObject obj = UnityEngine.Object.Instantiate(bloodItemGo, bloodItemContentTrans);
				obj.SetActive(value: true);
				DodgeBloodItem component = obj.GetComponent<DodgeBloodItem>();
				bloodItemList.Add(component);
				component.Init(i);
			}
		}
		for (int j = config.bloodCount; j < bloodItemList.Count; j++)
		{
			bloodItemList[j].gameObject.SetActive(value: false);
		}
	}

	private void InitFoodItem()
	{
		foodItem.Init();
	}

	private void RegisterInputCallback()
	{
		gamePad.RegisterInputCallback(CookingGameConst.DogeFireBallInputType.UP, OnClickUp);
		gamePad.RegisterInputCallback(CookingGameConst.DogeFireBallInputType.DOWN, OnClickDown);
		gamePad.RegisterInputCallback(CookingGameConst.DogeFireBallInputType.LEFT, OnClickLeft);
		gamePad.RegisterInputCallback(CookingGameConst.DogeFireBallInputType.RIGHT, OnClickRight);
	}

	private void UpdateRender()
	{
		switch (gameStatus)
		{
		case CookingGameConst.DodgeFireBallGameStatus.ENTER:
			RenderEnterStatus();
			break;
		case CookingGameConst.DodgeFireBallGameStatus.PLAYING:
			RenderPlayingStatus();
			break;
		case CookingGameConst.DodgeFireBallGameStatus.FAIL:
			RenderFailStatus();
			break;
		case CookingGameConst.DodgeFireBallGameStatus.INIT:
		case CookingGameConst.DodgeFireBallGameStatus.SUCCESS:
			break;
		}
	}

	private void RenderEnterStatus()
	{
		RenderTableItem();
		RenderBloodItem();
		RenderFoodItem();
		if (!isEnterAnimPlaying)
		{
			playPanelGo.SetActive(value: false);
			enterPanelGo.SetActive(value: true);
			enterTalkText.text = GetTips(config.enterTalkTips);
			PlayEnterAnim();
		}
	}

	private void RenderPlayingStatus()
	{
		RenderTableItem();
		RenderBloodItem();
		RenderFoodItem();
		if (isHurt)
		{
			isHurt = false;
			PlayHurtAnim();
		}
		RenderGuide();
	}

	private void RenderTableItem()
	{
		foreach (List<DodgeTableItem> item in tableItemMap)
		{
			foreach (DodgeTableItem item2 in item)
			{
				item2.UpdateRender();
			}
		}
	}

	private void RenderBloodItem()
	{
		foreach (DodgeBloodItem bloodItem in bloodItemList)
		{
			bloodItem.UpdateRender();
		}
	}

	private void RenderFoodItem()
	{
		foodItem.UpdateRender();
	}

	private void RenderFailStatus()
	{
		RenderBloodItem();
		if (needPopFailView)
		{
			needPopFailView = false;
			failView.Show(value: true);
		}
	}

	private void RenderGuide()
	{
		foreach (DodgeFireBallGameStep.GuideStatus value in guideStatusDic.Values)
		{
			if (value.needShowGuide)
			{
				value.needShowGuide = false;
				ShowGuide(value);
			}
		}
	}

	private void UpdateLogic()
	{
		if (gameStatus == CookingGameConst.DodgeFireBallGameStatus.PLAYING)
		{
			UpdatePlayTime();
			UpdateFireBallEventLogic();
			UpdateTableItemLogic();
			UpdateBloodLogic();
			UpdateFoodItemLogic();
			UpdateGuideTime();
		}
	}

	private void UpdatePlayTime()
	{
		playTime += Time.deltaTime;
	}

	private void UpdateFireBallEventLogic()
	{
		while (fireBallEventIndex < dodgeFireBallEventList.Count && dodgeFireBallEventList[fireBallEventIndex].startTime <= playTime && !dodgeFireBallEventList[fireBallEventIndex].isInvoked)
		{
			DodgeFireBallEvent dodgeFireBallEvent = dodgeFireBallEventList[fireBallEventIndex];
			dodgeFireBallEvent.isInvoked = true;
			int row = dodgeFireBallEvent.fireBallDropEventConfig.pos.row;
			int col = dodgeFireBallEvent.fireBallDropEventConfig.pos.col;
			tableItemMap[row][col].AddFireBallEvent(dodgeFireBallEvent);
			fireBallEventIndex++;
		}
		if (fireBallEventIndex != dodgeFireBallEventList.Count)
		{
			return;
		}
		fireBallEventIndex = 0;
		dodgeFireBallEventList.Clear();
		foreach (DodgeFireBallGameStep.FireBallDropEventConfig fireBallDropEvent in config.fireBallDropEventList)
		{
			DodgeFireBallEvent dodgeFireBallEvent2 = new DodgeFireBallEvent(fireBallDropEvent, config);
			dodgeFireBallEvent2.UpdateTime(playTime + fireBallDropEvent.invokeTime);
			dodgeFireBallEventList.Add(dodgeFireBallEvent2);
		}
		dodgeFireBallEventList.Sort(CompareFireBallEventTime);
	}

	private void UpdateTableItemLogic()
	{
		foreach (List<DodgeTableItem> item in tableItemMap)
		{
			foreach (DodgeTableItem item2 in item)
			{
				item2.UpdateLogic();
			}
		}
	}

	private void UpdateBloodLogic()
	{
		int row = foodItem.row;
		int col = foodItem.col;
		if (tableItemMap[row][col].status == CookingGameConst.DogFireBallTableStatus.BURN && !foodItem.isInvincible)
		{
			curBlood--;
			foodItem.Hurt();
		}
		foreach (DodgeBloodItem bloodItem in bloodItemList)
		{
			bloodItem.UpdateLogic();
		}
	}

	private void UpdateFoodItemLogic()
	{
		foodItem.UpdateLogic();
	}

	private void UpdateGuideTime()
	{
		if (!needGuide)
		{
			return;
		}
		if (guideStatusDic.TryGetValue(DodgeFireBallGameStep.GuideType.firstGamePad, out var value) && !value.isTriggered)
		{
			value.Trigger();
		}
		foreach (DodgeFireBallGameStep.GuideStatus value2 in guideStatusDic.Values)
		{
			if (value2.isTriggered)
			{
				if (!value2.isPlayed)
				{
					value2.delayTime += Time.deltaTime;
				}
				if (value2.delayTime >= value2.guideConfig.delayTime && !value2.isPlayed)
				{
					value2.isPlayed = true;
					value2.needShowGuide = true;
				}
			}
		}
	}

	private void UpdateStatus()
	{
		switch (gameStatus)
		{
		case CookingGameConst.DodgeFireBallGameStatus.INIT:
			if (isEnter)
			{
				isEnter = false;
				SwitchToEnterStatus();
			}
			else
			{
				SwitchToPlayingStatus();
			}
			break;
		case CookingGameConst.DodgeFireBallGameStatus.ENTER:
			SwitchToPlayingStatus();
			break;
		case CookingGameConst.DodgeFireBallGameStatus.PLAYING:
			if (curBlood <= 0)
			{
				SwitchToFailStatus();
				CookingGameManager.Instance.AddStepFailure(config.config.stepID);
			}
			else if (curProgress >= config.maxProgress)
			{
				SwitchToSuccessStatus();
				CookingGameManager.Instance.AddStepSuccess(config.config.stepID);
			}
			break;
		}
	}

	private void SwitchToEnterStatus()
	{
		gameStatus = CookingGameConst.DodgeFireBallGameStatus.ENTER;
		isEnterAnimPlaying = false;
		isLogicBlocking = true;
	}

	private void SwitchToInitStatus()
	{
		gameStatus = CookingGameConst.DodgeFireBallGameStatus.INIT;
		curBlood = config.bloodCount;
		isHurt = false;
		playTime = 0f;
		needPopFailView = false;
		isLogicBlocking = false;
		foreach (List<DodgeTableItem> item in tableItemMap)
		{
			foreach (DodgeTableItem item2 in item)
			{
				item2.InitGame(this, config);
			}
		}
		foreach (DodgeBloodItem bloodItem in bloodItemList)
		{
			bloodItem.InitGame(this, config);
		}
		foodItem.InitGame(this, config);
		InitFireBallEventList();
		CloseGuide();
		guideStatusDic = new Dictionary<DodgeFireBallGameStep.GuideType, DodgeFireBallGameStep.GuideStatus>();
		if (config.needGuide)
		{
			object[] array = LuaHelper.CallFunction("getData", "fire_ball_game", "fire_ball_first_guide_played");
			if (array != null && array.Length != 0 && (bool)array[0])
			{
				needGuide = false;
			}
			else
			{
				needGuide = true;
				LuaHelper.CallFunction("saveData", "fire_ball_game", "fire_ball_first_guide_played", true);
			}
		}
		if (!needGuide)
		{
			return;
		}
		foreach (DodgeFireBallGameStep.GuideConfig guideConfig in config.guideConfigList)
		{
			guideStatusDic.Add(guideConfig.type, new DodgeFireBallGameStep.GuideStatus(guideConfig));
		}
	}

	private void SwitchToPlayingStatus()
	{
		gameStatus = CookingGameConst.DodgeFireBallGameStatus.PLAYING;
	}

	private void SwitchToFailStatus()
	{
		gameStatus = CookingGameConst.DodgeFireBallGameStatus.FAIL;
		needPopFailView = true;
	}

	private void SwitchToSuccessStatus()
	{
		gameStatus = CookingGameConst.DodgeFireBallGameStatus.SUCCESS;
		config.OnStepEnd();
		CookingGameManager.Instance.NextStep();
	}

	private void InitFireBallEventList()
	{
		fireBallEventIndex = 0;
		dodgeFireBallEventList.Clear();
		foreach (DodgeFireBallGameStep.FireBallDropEventConfig fireBallDropEvent in config.fireBallDropEventList)
		{
			DodgeFireBallEvent dodgeFireBallEvent = new DodgeFireBallEvent(fireBallDropEvent, config);
			dodgeFireBallEvent.UpdateTime(playTime + fireBallDropEvent.invokeTime);
			dodgeFireBallEventList.Add(dodgeFireBallEvent);
		}
		dodgeFireBallEventList.Sort(CompareFireBallEventTime);
	}

	private int CompareFireBallEventTime(DodgeFireBallEvent a, DodgeFireBallEvent b)
	{
		return a.startTime.CompareTo(b.startTime);
	}

	private void OnClickUp()
	{
		if (gameStatus == CookingGameConst.DodgeFireBallGameStatus.PLAYING && foodItem.row != 0)
		{
			foodItem.row--;
		}
	}

	private void OnClickDown()
	{
		if (gameStatus == CookingGameConst.DodgeFireBallGameStatus.PLAYING && foodItem.row != 2)
		{
			foodItem.row++;
		}
	}

	private void OnClickLeft()
	{
		if (gameStatus == CookingGameConst.DodgeFireBallGameStatus.PLAYING && foodItem.col != 0)
		{
			foodItem.col--;
		}
	}

	private void OnClickRight()
	{
		if (gameStatus == CookingGameConst.DodgeFireBallGameStatus.PLAYING && foodItem.col != 2)
		{
			foodItem.col++;
		}
	}

	public Vector2 GetTableScreenPos(int row, int col)
	{
		DodgeTableItem dodgeTableItem = tableItemMap[row][col];
		return RectTransformUtility.WorldToScreenPoint(uiCamera, dodgeTableItem.transform.position);
	}

	public CookingGameConst.DogFireBallTableStatus GetTableItemStatus(int row, int col)
	{
		return tableItemMap[row][col].status;
	}

	public void RestartGame()
	{
		SwitchToInitStatus();
	}

	private void PlayEnterAnim()
	{
		isEnterAnimPlaying = true;
		PlayAnimWithCallback(enterTalkAnimator, "fireballEnterTalk", EnterTalkEnd);
	}

	private void EnterTalkEnd()
	{
		enterFireAnimator.SetActive(bActive: true);
		PlayAnimWithCallback(enterFireAnimator, "CutToFireBallAnim", EnterAnimEnd, EnterAnimMid);
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_cook_transition02", useStream: false);
	}

	private void EnterAnimMid()
	{
		playPanelGo.SetActive(value: true);
	}

	private void EnterAnimEnd()
	{
		enterPanelGo.SetActive(value: false);
		enterTipsAnimator.SetActive(bActive: true);
		PlayAnimWithCallback(enterTipsAnimator, "FireBallEnterTipsAnim", EnterTipsAnimEnd);
		AudioManager.Instance.Play("effect", "minigame_activity_3_9", "minigame_activity_3_9_ball_turn01", useStream: false);
	}

	private void EnterTipsAnimEnd()
	{
		isLogicBlocking = false;
		isEnterAnimPlaying = false;
		enterTipsAnimator.SetActive(bActive: false);
	}

	private void PlayHurtAnim()
	{
		hurtAnimator.enabled = true;
		hurtAnimator.Play("bg_red", 0, 0f);
		hurtAnimator.Update(0f);
	}

	private void PlayAnimWithCallback(Animator animator, string animName, Action endCallback = null, Action midCallback = null)
	{
		animator.enabled = true;
		animator.Play(animName, 0, 0f);
		animator.Update(0f);
		StopAnimCoroutine();
		animCoroutine = CheckAnimEnd(animator, animName, endCallback, midCallback);
		StartCoroutine(animCoroutine);
	}

	private void StopAnimCoroutine()
	{
		if (animCoroutine != null)
		{
			StopCoroutine(animCoroutine);
		}
	}

	private IEnumerator CheckAnimEnd(Animator animator, string animName, Action endCallback = null, Action midCallback = null)
	{
		yield return null;
		bool midCalled = false;
		while (true)
		{
			AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
			if ((double)currentAnimatorStateInfo.normalizedTime >= 0.5 && !midCalled)
			{
				midCalled = true;
				midCallback?.Invoke();
			}
			if (currentAnimatorStateInfo.normalizedTime >= 1f)
			{
				break;
			}
			yield return null;
		}
		animator.enabled = false;
		endCallback?.Invoke();
	}

	private void ShowGuide(DodgeFireBallGameStep.GuideStatus status)
	{
		isPlayingGuide = true;
		guideDialogText.text = GetTips(status.guideConfig.guideTextKey);
		switch (status.guideConfig.type)
		{
		case DodgeFireBallGameStep.GuideType.firstGamePad:
			forceGuideController.SetSelectedState("gamePad");
			UpdateCloseBtnTrans(gamePageGuideTrans);
			break;
		case DodgeFireBallGameStep.GuideType.firstBurn:
			forceGuideController.SetSelectedState("burn");
			UpdateCloseBtnTrans(burnGuideTrans);
			break;
		case DodgeFireBallGameStep.GuideType.firstWarm:
			forceGuideController.SetSelectedState("warm");
			UpdateCloseBtnTrans(warmGuideTrans);
			break;
		case DodgeFireBallGameStep.GuideType.firstWarning:
			forceGuideController.SetSelectedState("warning");
			UpdateCloseBtnTrans(warningGuideTrans);
			break;
		}
		foreach (List<DodgeTableItem> item in tableItemMap)
		{
			foreach (DodgeTableItem item2 in item)
			{
				item2.PauseAnim();
			}
		}
	}

	private void OnClickCloseGuideBtn(GameObject go, PointerEventData e)
	{
		CloseGuide();
	}

	private void CloseGuide()
	{
		isPlayingGuide = false;
		forceGuideController.SetSelectedState("none");
		foreach (List<DodgeTableItem> item in tableItemMap)
		{
			foreach (DodgeTableItem item2 in item)
			{
				item2.ResumeAnim();
			}
		}
	}

	public void UpdateCloseBtnTrans(RectTransform targetTrans)
	{
		guideCloseBtn.transform.SetSizeDelta(targetTrans.sizeDelta);
		Vector3 localPosition = guideCloseBtn.transform.parent.InverseTransformPoint(targetTrans.position);
		guideCloseBtn.transform.localPosition = localPosition;
	}

	public void TriggerWarning()
	{
		TriggerGuide(DodgeFireBallGameStep.GuideType.firstWarning);
	}

	public void TriggerBurn()
	{
		TriggerGuide(DodgeFireBallGameStep.GuideType.firstBurn);
	}

	public void TriggerWarm()
	{
		TriggerGuide(DodgeFireBallGameStep.GuideType.firstWarm);
	}

	public void TriggerGuide(DodgeFireBallGameStep.GuideType type)
	{
		if (needGuide && guideStatusDic.TryGetValue(type, out var value))
		{
			value.Trigger();
		}
	}

	public string GetTips(string key)
	{
		object[] array = LuaHelper.CallFunction("GetTips", key);
		if (array != null && array[0] != null && array[0] is string result)
		{
			return result;
		}
		return key;
	}
}
