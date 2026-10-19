using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Game.Data;
using ACT.Net;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using Runtime.UI.CommonComponent;
using Sirenix.Serialization;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class OneTreatScrapingPrizeView : BaseUIView<OneTreatScrapingPrizeInputController>
{
	private enum RevealState
	{
		Pending,
		Result
	}

	private const float OpenScratchInputBlockSeconds = 0.35f;

	private const string GoldRevealAnimation = "Glod";

	private const string NormalRevealAnimation = "Normal";

	[SerializeField]
	private ActButton skipButton;

	[SerializeField]
	private ActButton closeButton;

	[SerializeField]
	private ActButton drawAgainButton;

	[SerializeField]
	private CommonCoinComponent ticketCurrency;

	[SerializeField]
	private GameObject ticketCurrencyPromptRoot;

	[SerializeField]
	private CommonNumberComponent ticketNumber;

	[SerializeField]
	private TMP_Text ticketCountText;

	[SerializeField]
	private TMP_Text hintText;

	[SerializeField]
	private TMP_Text rewardTierText;

	[SerializeField]
	private TMP_Text rewardCountText;

	[SerializeField]
	private TMP_Text finalRewardCountText;

	[SerializeField]
	private TMP_Text drawAgainText;

	[SerializeField]
	private Image rewardIconImage;

	[SerializeField]
	private ActButton rewardIconButton;

	[SerializeField]
	private Image finalRewardIconImage;

	[SerializeField]
	private ActButton finalRewardIconButton;

	[SerializeField]
	private RectTransform coverRoot;

	[SerializeField]
	private Image _coverImage;

	[SerializeField]
	private UIScratchCard _scratchCard;

	[SerializeField]
	private GameObject pendingHintRoot;

	[SerializeField]
	private GameObject scratchRoot;

	[SerializeField]
	private GameObject goldFlashRoot;

	[SerializeField]
	private GameObject goldFlashParticle;

	[SerializeField]
	private RectTransform normalRewardRoot;

	[SerializeField]
	private RectTransform finalRewardRoot;

	[SerializeField]
	private float doubleRewardOffsetX = 150f;

	[SerializeField]
	private RectTransform normalRewardContentRoot;

	[SerializeField]
	private RectTransform finalRewardContentRoot;

	[SerializeField]
	private GameObject sRewardBackground;

	[SerializeField]
	private GameObject aRewardBackground;

	[SerializeField]
	private GameObject bRewardBackground;

	[SerializeField]
	private GameObject cRewardBackground;

	[SerializeField]
	private GameObject dRewardBackground;

	[SerializeField]
	private GameObject eRewardBackground;

	[SerializeField]
	private GameObject finalRewardBackground;

	[SerializeField]
	private GameObject itemRoot;

	[SerializeField]
	private float brushDiameter = 72f;

	[SerializeField]
	[Range(0.1f, 1f)]
	private float brushHardness = 1f;

	[SerializeField]
	[Range(0.01f, 1f)]
	private float goldLightAreaPercent = 0.35f;

	[SerializeField]
	[Range(0.01f, 1f)]
	private float forceEndAreaPercent = 0.65f;

	[SerializeField]
	[Range(0.01f, 1f)]
	private float revealEffectAreaPercent = 0.4f;

	[SerializeField]
	private float gamepadScratchMoveSpeed = 480f;

	[SerializeField]
	[Range(0f, 0.95f)]
	private float gamepadScratchDeadZone = 0.15f;

	[OdinSerialize]
	public Dictionary<OneTreatScrapingPrizeControllerType, List<GameObject>> ViewControlPrompt;

	[SerializeField]
	private GamePadSelectComponent normalRewardGamePadSelect;

	[SerializeField]
	private GamePadSelectComponent finalRewardGamePadSelect;

	[SerializeField]
	private Image tierIconImage;

	[SerializeField]
	private GameObject promptsScratch;

	[SerializeField]
	private GameObject resultPromptRoot;

	[SerializeField]
	private GameObject promptsB;

	[SerializeField]
	private GameObject promptsA;

	[SerializeField]
	private GameObject promptsSelectItemCell;

	[SerializeField]
	private OperateBtnPrompt promptScratch;

	[SerializeField]
	private OperateBtnPrompt promptB;

	[SerializeField]
	private OperateBtnPrompt promptA;

	[SerializeField]
	private OperateBtnPrompt promptSelectItemCell;

	[SerializeField]
	private GameObject emptyRoot;

	[SerializeField]
	private ActButton emptyBtn;

	private OneTreatScrapingPrizeViewData m_data;

	private RevealState _state;

	private bool _closeCallbackInvoked;

	private bool _drawAgainRequesting;

	private BImage _rewardIconBImage;

	private BImage _finalRewardIconBImage;

	private BImage _tierIconBImage;

	private float _scratchInputBlockedUntilUnscaled;

	private bool _enteringResult;

	private bool _revealEffectPlayed;

	private string _playingRevealAnimation;

	private int _selectedRewardIndex;

	private OneTreatScrapingPrizeControllerType _controllerType;

	private OneTreatScrapingPrizeControllerType CurrentControllerType
	{
		get
		{
			if (GetController() != null)
			{
				return GetController().ControllerType;
			}
			return _controllerType;
		}
		set
		{
			_controllerType = value;
			GetController()?.SetControllerType(value);
		}
	}

	public float BrushDiameter
	{
		get
		{
			return brushDiameter;
		}
		set
		{
			brushDiameter = Mathf.Max(1f, value);
			if (_scratchCard != null)
			{
				_scratchCard.BrushDiameter = brushDiameter;
			}
		}
	}

	public float BrushHardness
	{
		get
		{
			return brushHardness;
		}
		set
		{
			brushHardness = Mathf.Clamp(value, 0.1f, 1f);
			if (_scratchCard != null)
			{
				_scratchCard.BrushHardness = brushHardness;
			}
		}
	}

	public float GoldLightAreaPercent
	{
		get
		{
			return goldLightAreaPercent;
		}
		set
		{
			goldLightAreaPercent = Mathf.Clamp01(value);
			if (_scratchCard != null)
			{
				_scratchCard.GoldLightAreaPercent = goldLightAreaPercent;
			}
		}
	}

	public float ForceEndAreaPercent
	{
		get
		{
			return forceEndAreaPercent;
		}
		set
		{
			forceEndAreaPercent = Mathf.Clamp01(value);
			if (_scratchCard != null)
			{
				_scratchCard.ForceEndAreaPercent = forceEndAreaPercent;
			}
		}
	}

	public float RevealedPercent
	{
		get
		{
			if (!(_scratchCard != null))
			{
				return 0f;
			}
			return _scratchCard.RevealedPercent;
		}
	}

	private void Awake()
	{
		InitializeScratchCard();
	}

	protected override void Init()
	{
		base.Init();
		m_data = uiViewData as OneTreatScrapingPrizeViewData;
		if (m_data == null)
		{
			GameUtility.OpenToolTip("暂无奖励数据");
			Close();
			return;
		}
		NormalizeData(m_data);
		InitializeScratchCard();
		InitializeTierIcon();
		EnsureDefaultViewControlPrompts();
		BindButtons();
		RefreshResultVisual();
		ResetToPending();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/IchibanKuji/Card_Reveal");
	}

	protected override void UnInit()
	{
		UnbindScratchCardEvents();
		if (_scratchCard != null)
		{
			_scratchCard.Interactable = false;
		}
		base.UnInit();
		m_data = null;
		_closeCallbackInvoked = false;
		_drawAgainRequesting = false;
		_enteringResult = false;
		SetActiveIfChanged(itemRoot, active: false);
		SetActiveIfChanged(finalRewardBackground, active: false);
		SetActiveIfChanged((finalRewardRoot == null) ? null : finalRewardRoot.gameObject, active: false);
		SetActiveIfChanged(emptyRoot, active: false);
		HideAllViewControlPrompts();
		RefreshRewardGamePadSelectState();
	}

	private void Update()
	{
		if (!(MonoECS.instance == null) && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && Singleton<GameInputActionManager>.instance != null)
		{
			Vector2 stickInput = Singleton<GameInputActionManager>.instance.ReadActionValue<Vector2>("UI/GamePadNavigate", out var _);
			HandleGamepadScratch(stickInput);
		}
	}

	public void HandleGamepadScratch(Vector2 stickInput)
	{
		if (CanReceiveScratchInput())
		{
			_scratchCard.ScratchByGamepad(stickInput, gamepadScratchMoveSpeed, gamepadScratchDeadZone);
		}
	}

	public void HandleSkip()
	{
		if (!(skipButton != null) || skipButton.gameObject.activeInHierarchy)
		{
			ShowResult(immediate: true);
		}
	}

	public void HandleDrawAgain()
	{
		OneTreatScrapingPrizeControllerType currentControllerType = CurrentControllerType;
		if (currentControllerType == OneTreatScrapingPrizeControllerType.SingleRewardResult || currentControllerType == OneTreatScrapingPrizeControllerType.MultiRewardResult)
		{
			OnDrawAgainClick();
		}
	}

	public void HandleConfirm()
	{
		if (CurrentControllerType == OneTreatScrapingPrizeControllerType.MultiRewardSelection)
		{
			OpenSelectedRewardDetail();
		}
	}

	public void HandleBack()
	{
		if (_state != RevealState.Pending)
		{
			CloseView();
		}
	}

	public void OpenTicketDetailByInput()
	{
		if (CurrentControllerType != OneTreatScrapingPrizeControllerType.MultiRewardSelection)
		{
			OpenTicketDetail();
		}
	}

	public void HandleSelectItemCell()
	{
		switch (CurrentControllerType)
		{
		case OneTreatScrapingPrizeControllerType.SingleRewardResult:
			OpenRewardDetail();
			break;
		case OneTreatScrapingPrizeControllerType.MultiRewardResult:
			ChangeToGamePadInputState(OneTreatScrapingPrizeControllerType.MultiRewardSelection, resetSelection: true);
			break;
		}
	}

	public void HandleGamepadNavigate(MoveDirection direction)
	{
		if (CurrentControllerType == OneTreatScrapingPrizeControllerType.MultiRewardSelection && (direction == MoveDirection.Left || direction == MoveDirection.Right))
		{
			_selectedRewardIndex = ((_selectedRewardIndex == 0) ? 1 : 0);
			RefreshRewardGamePadSelectState();
		}
	}

	private void BindButtons()
	{
		skipButton?.SetBtnClick(() =>
		{
			ShowResult(immediate: true);
		});
		closeButton?.SetBtnClick(CloseView);
		emptyBtn?.SetBtnClick(CloseView);
		drawAgainButton?.SetBtnClick(OnDrawAgainClick);
		rewardIconButton?.SetBtnClick(OpenRewardDetail);
		finalRewardIconButton?.SetBtnClick(OpenFinalRewardDetail);
	}

	private static BImage CreateIconTarget(Image iconImage)
	{
		if (iconImage == null)
		{
			return null;
		}
		iconImage.preserveAspect = true;
		return new BImage
		{
			icon = iconImage
		};
	}

	private void ResetToPending()
	{
		_state = RevealState.Pending;
		_enteringResult = false;
		_revealEffectPlayed = false;
		_selectedRewardIndex = 0;
		_scratchInputBlockedUntilUnscaled = Time.unscaledTime + 0.35f;
		InitializeScratchCard();
		if (_scratchCard != null)
		{
			_scratchCard.BrushDiameter = brushDiameter;
			_scratchCard.BrushHardness = brushHardness;
			_scratchCard.GoldLightAreaPercent = goldLightAreaPercent;
			_scratchCard.ForceEndAreaPercent = forceEndAreaPercent;
			_scratchCard.EnableGoldLight = IsSTier();
			_scratchCard.ResetScratch();
			_scratchCard.ResetGamepadScratchCursorToCenter();
			_scratchCard.Interactable = true;
		}
		SetTopActionButton(showCloseButton: false);
		SetActiveIfChanged((drawAgainButton == null) ? null : drawAgainButton.gameObject, active: false);
		SetActiveIfChanged(pendingHintRoot, active: true);
		SetGoldFlashActive(active: false);
		StopRevealEffect();
		SetActiveIfChanged((coverRoot == null) ? null : coverRoot.gameObject, active: true);
		RefreshTicketInfo();
		RefreshResultVisual();
		ChangeToGamePadInputState(OneTreatScrapingPrizeControllerType.Scratching);
	}

	private bool CanReceiveScratchInput()
	{
		if (_state == RevealState.Pending && !_enteringResult && Time.unscaledTime >= _scratchInputBlockedUntilUnscaled && _scratchCard != null)
		{
			return _scratchCard.Interactable;
		}
		return false;
	}

	private void ShowResult(bool immediate)
	{
		if (_state == RevealState.Result || _enteringResult)
		{
			return;
		}
		_enteringResult = true;
		if (_scratchCard != null)
		{
			_scratchCard.Interactable = false;
			if (immediate)
			{
				_scratchCard.RevealAllImmediate();
				EnterResultState();
			}
			else
			{
				_scratchCard.RevealAllAnimated(EnterResultState);
			}
		}
		else
		{
			EnterResultState();
		}
	}

	private void EnterResultState()
	{
		if (_state != RevealState.Result)
		{
			_state = RevealState.Result;
			_enteringResult = false;
			_selectedRewardIndex = 0;
			SetTopActionButton(showCloseButton: true);
			RefreshRewardContentVisible();
			SetActiveIfChanged(pendingHintRoot, active: true);
			SetActiveIfChanged((coverRoot == null) ? null : coverRoot.gameObject, active: false);
			PlayRevealEffectIfNeeded();
			RefreshDrawAgainButton();
			ChangeToGamePadInputState((m_data == null || !m_data.HasFinalReward) ? OneTreatScrapingPrizeControllerType.SingleRewardResult : OneTreatScrapingPrizeControllerType.MultiRewardResult);
			Action action = m_data?.OnResultDisplayed;
			if (m_data != null)
			{
				m_data.OnResultDisplayed = null;
			}
			action?.Invoke();
		}
	}

	private void OnDrawAgainClick()
	{
		if (_state != RevealState.Result)
		{
			return;
		}
		if (!CanDrawAgain())
		{
			RefreshDrawAgainButton();
			return;
		}
		_drawAgainRequesting = true;
		RefreshDrawAgainButton();
		bool callbackInvoked = false;
		OneTreatScrapingPrizeViewData data = m_data;
		if (!((data != null && data.DrawAgain?.Invoke((OneTreatScrapingPrizeViewData nextData) =>
		{
			callbackInvoked = true;
			OnDrawAgainDataReady(nextData);
		}) == true) | callbackInvoked))
		{
			_drawAgainRequesting = false;
			RefreshDrawAgainButton();
		}
	}

	private void OnDrawAgainDataReady(OneTreatScrapingPrizeViewData nextData)
	{
		_drawAgainRequesting = false;
		if (nextData == null)
		{
			RefreshDrawAgainButton();
			return;
		}
		m_data = nextData;
		NormalizeData(m_data);
		ResetToPending();
	}

	private void CloseView()
	{
		if (!_closeCallbackInvoked)
		{
			_closeCallbackInvoked = true;
			m_data?.OnClose?.Invoke();
		}
		Close();
	}

	private void RefreshTicketInfo()
	{
		int num = Mathf.Max(0, m_data?.TicketCount ?? 0);
		int num2 = m_data?.TicketItemId ?? 0;
		if (ticketCurrency != null && num2 > 0)
		{
			ticketCurrency.InitData(num2, IsBagItem(num2));
			ticketCurrency.Initialize();
		}
		if (ticketNumber != null)
		{
			ticketNumber.UpdateNumber(num);
		}
		if (ticketCountText != null)
		{
			ticketCountText.SetText("{0:0}", num);
		}
	}

	private void RefreshResultVisual()
	{
		if (m_data != null)
		{
			RefreshTicketInfo();
			if (rewardTierText != null)
			{
				rewardTierText.text = (string.IsNullOrEmpty(m_data.Tier) ? "E" : m_data.Tier);
			}
			if (rewardCountText != null)
			{
				rewardCountText.SetText("x{0:0}", Mathf.Max(1, m_data.RewardCount));
			}
			RefreshRewardIcon(rewardIconImage, ref _rewardIconBImage, m_data.RewardId);
			SetRewardIconButtonState(rewardIconButton, m_data.RewardId > 0);
			if (normalRewardRoot != null)
			{
				normalRewardRoot.anchoredPosition = new Vector2(0f, normalRewardRoot.anchoredPosition.y);
			}
			if (normalRewardContentRoot != null)
			{
				normalRewardContentRoot.anchoredPosition = new Vector2(m_data.HasFinalReward ? (0f - doubleRewardOffsetX) : 0f, normalRewardContentRoot.anchoredPosition.y);
			}
			if (finalRewardRoot != null)
			{
				finalRewardRoot.anchoredPosition = new Vector2(0f, finalRewardRoot.anchoredPosition.y);
			}
			if (finalRewardContentRoot != null)
			{
				finalRewardContentRoot.anchoredPosition = new Vector2(m_data.HasFinalReward ? doubleRewardOffsetX : 0f, finalRewardContentRoot.anchoredPosition.y);
			}
			RefreshNormalRewardBackground(m_data.Tier, m_data.HasFinalReward);
			if (finalRewardCountText != null)
			{
				finalRewardCountText.SetText("x{0:0}", Mathf.Max(1, m_data.FinalRewardCount));
			}
			RefreshRewardIcon(finalRewardIconImage, ref _finalRewardIconBImage, m_data.HasFinalReward ? m_data.FinalRewardId : 0);
			SetRewardIconButtonState(finalRewardIconButton, m_data.HasFinalReward && m_data.FinalRewardId > 0);
			RefreshTierIcon(m_data.Tier);
			RefreshRewardContentVisible();
		}
	}

	private void RefreshRewardContentVisible()
	{
		bool flag = _state == RevealState.Result;
		SetActiveIfChanged((normalRewardContentRoot == null) ? null : normalRewardContentRoot.gameObject, active: true);
		SetActiveIfChanged(itemRoot, flag);
		SetActiveIfChanged((finalRewardRoot == null) ? null : finalRewardRoot.gameObject, m_data != null && m_data.HasFinalReward);
		SetActiveIfChanged(finalRewardBackground, flag && m_data != null && m_data.HasFinalReward);
	}

	private void RefreshNormalRewardBackground(string tier, bool hasFinalReward)
	{
		bool flag = !hasFinalReward;
		SetActiveIfChanged(sRewardBackground, flag && string.Equals(tier, "S", StringComparison.OrdinalIgnoreCase));
		SetActiveIfChanged(aRewardBackground, flag && string.Equals(tier, "A", StringComparison.OrdinalIgnoreCase));
		SetActiveIfChanged(bRewardBackground, flag && string.Equals(tier, "B", StringComparison.OrdinalIgnoreCase));
		SetActiveIfChanged(cRewardBackground, flag && string.Equals(tier, "C", StringComparison.OrdinalIgnoreCase));
		SetActiveIfChanged(dRewardBackground, flag && string.Equals(tier, "D", StringComparison.OrdinalIgnoreCase));
		SetActiveIfChanged(eRewardBackground, flag && string.Equals(tier, "E", StringComparison.OrdinalIgnoreCase));
	}

	private void InitializeTierIcon()
	{
		_tierIconBImage = OneTreatPrizeViewUtility.CreateImageTarget(tierIconImage);
		SetActiveIfChanged((tierIconImage == null) ? null : tierIconImage.gameObject, active: false);
	}

	private void RefreshTierIcon(string tier)
	{
		if (!(tierIconImage == null))
		{
			bool flag = OneTreatPrizeViewUtility.LoadTierIcon(tier, Station, _tierIconBImage);
			SetActiveIfChanged(tierIconImage.gameObject, flag);
			if (rewardTierText != null)
			{
				SetActiveIfChanged(rewardTierText.gameObject, !flag);
			}
		}
	}

	private void RefreshRewardIcon(Image iconImage, ref BImage iconBImage, int itemId)
	{
		if (!(iconImage == null))
		{
			if (iconBImage == null)
			{
				iconBImage = CreateIconTarget(iconImage);
			}
			if (Station == null || iconBImage == null || itemId <= 0 || RuntimeConfigs.data == null || RuntimeConfigs.data.itemDatas == null || !RuntimeConfigs.data.itemDatas.TryGetValue(itemId, out var value))
			{
				iconImage.sprite = null;
			}
			else
			{
				Station.LoadItemIcon(value.iconAddress, iconBImage);
			}
		}
	}

	private static void SetRewardIconButtonState(ActButton iconButton, bool interactable)
	{
		if (iconButton != null)
		{
			iconButton.Interactable(interactable);
		}
	}

	private void RefreshDrawAgainButton()
	{
		bool flag = m_data != null && !m_data.HasFinalReward;
		bool active = flag && CanDrawAgain();
		SetActiveIfChanged((drawAgainButton == null) ? null : drawAgainButton.gameObject, flag);
		if (drawAgainButton != null)
		{
			drawAgainButton.Interactable(active);
		}
	}

	private void SetTopActionButton(bool showCloseButton)
	{
		SetActiveIfChanged((skipButton == null) ? null : skipButton.gameObject, !showCloseButton);
		SetActiveIfChanged((closeButton == null) ? null : closeButton.gameObject, showCloseButton);
	}

	public void ChangeToGamePadInputState(OneTreatScrapingPrizeControllerType type, bool resetSelection = false)
	{
		if (resetSelection)
		{
			_selectedRewardIndex = 0;
		}
		CurrentControllerType = type;
		RefreshGamepadStateVisuals();
	}

	private void RefreshGamepadStateVisuals()
	{
		bool flag = MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		bool flag2 = CurrentControllerType == OneTreatScrapingPrizeControllerType.Scratching;
		SetActiveIfChanged(pendingHintRoot, active: true);
		SetActiveIfChanged(scratchRoot, flag2);
		SetActiveIfChanged(resultPromptRoot, flag && !flag2);
		SetActiveIfChanged((hintText == null) ? null : hintText.gameObject, flag2);
		ConfigureGamepadPromptContent(CurrentControllerType);
		RefreshViewControlPrompts(CurrentControllerType);
		RefreshRewardGamePadSelectState();
		RefreshTicketCurrencyPromptState();
		RefreshEmptyCloseState();
	}

	private void RefreshEmptyCloseState()
	{
		bool flag = MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		SetActiveIfChanged(emptyRoot, _state == RevealState.Result && !flag);
	}

	private void RefreshTicketCurrencyPromptState()
	{
		bool active = MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && CurrentControllerType != OneTreatScrapingPrizeControllerType.MultiRewardSelection;
		SetActiveIfChanged(ticketCurrencyPromptRoot, active);
	}

	private void EnsureDefaultViewControlPrompts()
	{
		if (ViewControlPrompt == null)
		{
			ViewControlPrompt = new Dictionary<OneTreatScrapingPrizeControllerType, List<GameObject>>();
		}
		EnsureViewControlPrompt(OneTreatScrapingPrizeControllerType.Scratching, promptsScratch);
		EnsureViewControlPrompt(OneTreatScrapingPrizeControllerType.SingleRewardResult, promptsB, promptsSelectItemCell);
		EnsureViewControlPrompt(OneTreatScrapingPrizeControllerType.MultiRewardResult, promptsB, promptsSelectItemCell);
		EnsureViewControlPrompt(OneTreatScrapingPrizeControllerType.MultiRewardSelection, promptsB, promptsA);
	}

	private void EnsureViewControlPrompt(OneTreatScrapingPrizeControllerType type, params GameObject[] prompts)
	{
		if (ViewControlPrompt.TryGetValue(type, out var value) && value != null && value.Count > 0)
		{
			return;
		}
		List<GameObject> list = new List<GameObject>();
		foreach (GameObject gameObject in prompts)
		{
			if (gameObject != null)
			{
				list.Add(gameObject);
			}
		}
		ViewControlPrompt[type] = list;
	}

	private void ConfigureGamepadPromptContent(OneTreatScrapingPrizeControllerType type)
	{
		switch (type)
		{
		case OneTreatScrapingPrizeControllerType.Scratching:
			ConfigureGamepadPrompt(promptScratch, "UI/GamePadNavigate", 0);
			break;
		case OneTreatScrapingPrizeControllerType.SingleRewardResult:
		case OneTreatScrapingPrizeControllerType.MultiRewardResult:
			ConfigureGamepadPrompt(promptB, "UI/Back", 606);
			ConfigureGamepadPrompt(promptSelectItemCell, "UI/SelectItemCell", 1642);
			break;
		case OneTreatScrapingPrizeControllerType.MultiRewardSelection:
			ConfigureGamepadPrompt(promptB, "UI/Back", 606);
			ConfigureGamepadPrompt(promptA, "UI/Confirm", 774);
			break;
		}
	}

	private static void ConfigureGamepadPrompt(OperateBtnPrompt prompt, string inputAction, int localizeKey)
	{
		if (!(prompt == null))
		{
			prompt.SetBindingAction(inputAction);
			prompt.SetLocalizeString(localizeKey);
			prompt.RefreshIcon();
		}
	}

	private void RefreshViewControlPrompts(OneTreatScrapingPrizeControllerType type)
	{
		HideAllViewControlPrompts();
		if (ViewControlPrompt == null || MonoECS.instance == null || MonoECS.instance.InputMode != DeviceInputMode.Gamepad || !ViewControlPrompt.TryGetValue(type, out var value) || value == null)
		{
			return;
		}
		foreach (GameObject item in value)
		{
			SetActiveIfChanged(item, active: true);
		}
	}

	private void HideAllViewControlPrompts()
	{
		if (ViewControlPrompt == null)
		{
			return;
		}
		foreach (KeyValuePair<OneTreatScrapingPrizeControllerType, List<GameObject>> item in ViewControlPrompt)
		{
			if (item.Value == null)
			{
				continue;
			}
			foreach (GameObject item2 in item.Value)
			{
				SetActiveIfChanged(item2, active: false);
			}
		}
	}

	private void RefreshRewardGamePadSelectState()
	{
		bool flag = MonoECS.instance != null && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && CurrentControllerType == OneTreatScrapingPrizeControllerType.MultiRewardSelection;
		SetGamePadSelectState(normalRewardGamePadSelect, flag && _selectedRewardIndex == 0);
		SetGamePadSelectState(finalRewardGamePadSelect, flag && _selectedRewardIndex == 1);
	}

	private static void SetGamePadSelectState(GamePadSelectComponent selectComponent, bool active)
	{
		if (!(selectComponent == null))
		{
			SetActiveIfChanged(selectComponent.gameObject, active);
			if (selectComponent.select != null && selectComponent.gamePadArrow != null)
			{
				selectComponent.SetSelectState(active);
			}
		}
	}

	private void InitializeScratchCard()
	{
		if (!(_coverImage == null) && !(_scratchCard == null))
		{
			UnbindScratchCardEvents();
			_scratchCard.Setup(_coverImage);
			_scratchCard.BrushDiameter = brushDiameter;
			_scratchCard.BrushHardness = brushHardness;
			_scratchCard.GoldLightAreaPercent = goldLightAreaPercent;
			_scratchCard.ForceEndAreaPercent = forceEndAreaPercent;
			_scratchCard.EnableGoldLight = IsSTier();
			_scratchCard.ForceEndCompleted += OnScratchForceEndCompleted;
		}
	}

	private void UnbindScratchCardEvents()
	{
		if (!(_scratchCard == null))
		{
			_scratchCard.ForceEndCompleted -= OnScratchForceEndCompleted;
		}
	}

	private void PlayRevealEffectIfNeeded()
	{
		if (!_revealEffectPlayed)
		{
			_revealEffectPlayed = true;
			string text = (IsSTier() ? "Glod" : "Normal");
			if (IsSTier())
			{
				Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Activity/IchibanKuji/Card_Gold");
			}
			_playingRevealAnimation = text;
			betterAnimation?.GetSequence(text)?.Play();
		}
	}

	private void StopRevealEffect()
	{
		if (betterAnimation != null && !string.IsNullOrEmpty(_playingRevealAnimation))
		{
			betterAnimation.GetSequence(_playingRevealAnimation)?.Goto(0f);
		}
		_playingRevealAnimation = null;
		_revealEffectPlayed = false;
	}

	private void OnScratchForceEndCompleted()
	{
		if (_state == RevealState.Pending)
		{
			_enteringResult = true;
			EnterResultState();
		}
	}

	private bool CanDrawAgain()
	{
		if (!_drawAgainRequesting && m_data != null && m_data.CanDrawAgain)
		{
			return m_data.TicketCount > 0;
		}
		return false;
	}

	private bool IsSTier()
	{
		if (m_data != null)
		{
			return string.Equals(m_data.Tier, "S", StringComparison.OrdinalIgnoreCase);
		}
		return false;
	}

	private void OpenTicketDetail()
	{
		if (m_data == null || m_data.TicketItemId <= 0)
		{
			GameUtility.OpenToolTip("暂无奖券信息");
			return;
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
		{
			Id = m_data.TicketItemId,
			Count = Mathf.Max(0, m_data.TicketCount)
		});
	}

	private void OpenRewardDetail()
	{
		if (m_data != null && m_data.RewardId > 0)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
			{
				Id = m_data.RewardId,
				Count = Mathf.Max(1, m_data.RewardCount)
			});
		}
	}

	private void OpenFinalRewardDetail()
	{
		if (m_data != null && m_data.HasFinalReward && m_data.FinalRewardId > 0)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
			{
				Id = m_data.FinalRewardId,
				Count = Mathf.Max(1, m_data.FinalRewardCount)
			});
		}
	}

	private void OpenSelectedRewardDetail()
	{
		if (_selectedRewardIndex == 1 && m_data != null && m_data.HasFinalReward)
		{
			OpenFinalRewardDetail();
		}
		else
		{
			OpenRewardDetail();
		}
	}

	private static void NormalizeData(OneTreatScrapingPrizeViewData data)
	{
		if (data != null)
		{
			if (string.IsNullOrEmpty(data.Tier))
			{
				data.Tier = "E";
			}
			data.RewardCount = Mathf.Max(1, data.RewardCount);
			data.FinalRewardCount = Mathf.Max(1, data.FinalRewardCount);
		}
	}

	private static bool IsBagItem(int itemId)
	{
		foreach (PlayerAttribute value in Enum.GetValues(typeof(PlayerAttribute)))
		{
			if (value == (PlayerAttribute)itemId)
			{
				return false;
			}
		}
		return true;
	}

	private void SetGoldFlashActive(bool active)
	{
		SetActiveIfChanged(goldFlashRoot, active);
		SetActiveIfChanged(goldFlashParticle, active);
	}

	private static void SetActiveIfChanged(GameObject target, bool active)
	{
		if (target != null && target.activeSelf != active)
		{
			target.SetActive(active);
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RefreshGamepadStateVisuals();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		if (betterAnimation != null)
		{
			betterAnimation.GetSequence("Hide")?.OnComplete((AnimationBuilder _) =>
			{
				CloseEffectFinishNew();
			}).Play();
		}
	}
}
