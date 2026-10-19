using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Lumin.LoungeSystem;
using Lumin.LoungeSystem.UI;
using UnityEngine;
using UnityEngine.Localization.Components;
using frame8.Logic.Misc.Other.Extensions;

namespace ACT.UI;

public class LoungeMainView : BaseUIView<LoungeMainViewInputController>
{
	private readonly struct CharacterSelectHandleAnchor(Transform characterRoot, Vector3 localPosition)
	{
		public readonly Transform CharacterRoot = characterRoot;

		public readonly Vector3 LocalPosition = localPosition;
	}

	[Header("选项相关")]
	public GameObject btnPrefab;

	public GameObject btnGroup;

	public GameObject closeChoicePanel;

	public GameObject switchGroup;

	public GameObject roomChangeGroup;

	[Header("HUD相关")]
	public Transform hudRoot;

	public GameObject hudRootGo;

	public GameObject hudCellPrefab;

	[Header("HUD配置")]
	[Tooltip("HUD高度偏移")]
	public float hudHeightOffset = 2f;

	[Tooltip("角色HUD偏移")]
	public Vector2 hudCharacterOffset = new Vector2(80f, 100f);

	[Tooltip("HUD最大显示距离")]
	public float hudMaxDistance = 20f;

	[Tooltip("屏蔽UI按钮")]
	public ActButton btn_hide;

	public ActButton btn_empty;

	public ActButton btnRoomManagement;

	public ActButton btnInviteCharacter;

	public ActButton btnTreasure;

	public ActButton btnLeftPage;

	public ActButton btnRightPage;

	public GameObject CharacterInteraction;

	public GameObject InteractContent;

	[Tooltip("交互对话")]
	public LoungeConversation conversation;

	public FavorabilityProgressPreviewComponent _favorabilityProgressPreviewComponent;

	public LocalizeStringEvent roomNameText;

	public LoungeRoomSideInfo sideRoomInfo;

	public GameObject cameraTimelineRoot;

	[Tooltip("prompBoard节点")]
	public GameObject prompBoard;

	[Tooltip("A键")]
	public OperateBtnPrompt operateBtnPromptA;

	[Tooltip("B键")]
	public OperateBtnPrompt operateBtnPromptB;

	[Tooltip("菜单键")]
	public OperateBtnPrompt operateBtnPromptMenu;

	[Tooltip("View键")]
	public OperateBtnPrompt operateBtnPromptView;

	[Tooltip("Y键")]
	public OperateBtnPrompt operateBtnPromptY;

	[Tooltip("LT键")]
	public OperateBtnPrompt operateBtnPromptLT;

	[Tooltip("RT键")]
	public OperateBtnPrompt operateBtnPromptRT;

	[Tooltip("X键")]
	public OperateBtnPrompt operateBtnPromptX;

	private const int LocalizeIDA = 13;

	private const int LocalizeIDB = 606;

	private const string CharacterHudTargetPath = "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2";

	private const string CharacterSelectHandleTargetPath = "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2/BN_Bosom_L01/BN_Bosom_L02/BN_Bosom_L03";

	private readonly Dictionary<int, CharacterSelectHandleAnchor> _characterSelectHandleAnchors = new Dictionary<int, CharacterSelectHandleAnchor>();

	private readonly List<LoungeHudCell> _gamepadHudCells = new List<LoungeHudCell>();

	private int _gamepadSelectedHudIndex = -1;

	private LoungeHudCell _lastCachedCharacterSelectHandleCell;

	private bool _applyGamepadHudSelectionAfterLayout;

	private bool _gamepadPromptInited;

	private CancellationTokenSource _gamepadPromptRefreshCts;

	private bool _consumeGamepadConfirmUntilRelease;

	private LoungeRoomSideInfoSubView _roomSideSubView;

	private LoungeCharacterInteractionSubView _characterInteractionSubView;

	private LoungeMainViewData m_data;

	private List<(ActButton, LoungeInteractBtn)> m_choiceBtns;

	internal List<(ActButton, LoungeInteractBtn)> ChoiceBtns;

	private int currentSelectedCharacter;

	private int currentSelectedPoint;

	private Dictionary<int, Dictionary<int, LoungeHudCell>> _activeHudCells;

	private Queue<LoungeHudCell> _hudCellPool;

	private Camera _mainCamera;

	private RectTransform _hudRootRect;

	private bool hasInit;

	private bool isHideView;

	private int _hideViewFrame = -1;

	private int _showViewFrame = -1;

	private bool _hasHiddenUiState;

	private bool _cachedInteractContentActive;

	private bool _cachedCloseChoicePanelActive;

	private bool _cachedSwitchGroupActive;

	private bool _cachedRoomChangeGroupActive;

	private bool _cachedHudRootActive;

	private bool _cachedHideButtonActive;

	private BetterAnimation characterInteractionBetterAnimation;

	private Dictionary<int, LoungePoint> tempHudPoints = new Dictionary<int, LoungePoint>();

	public bool CanEnterIdleMode
	{
		get
		{
			if (GetUIController().State == UIState.Opened && !IsSubViewInputOccupied && !CharacterInteraction.activeSelf && !closeChoicePanel.activeSelf)
			{
				return currentSelectedCharacter <= 0;
			}
			return false;
		}
	}

	public bool IsSubViewInputOccupied
	{
		get
		{
			if (!(_roomSideSubView != null) || !_roomSideSubView.IsFocused)
			{
				if (_characterInteractionSubView != null)
				{
					return _characterInteractionSubView.IsFocused;
				}
				return false;
			}
			return true;
		}
	}

	public bool IsGamepadBlockedByCameraTransition
	{
		get
		{
			if (LoungeUIScene.instance != null)
			{
				if (!LoungeUIScene.instance.IsCameraBlending)
				{
					return LoungeUIScene.instance.IsIdleMode;
				}
				return true;
			}
			return false;
		}
	}

	public bool IsInteractionChoicePanelVisible
	{
		get
		{
			if (InteractContent != null)
			{
				return InteractContent.activeSelf;
			}
			return false;
		}
	}

	protected void Awake()
	{
		_hudRootRect = hudRoot?.GetComponent<RectTransform>();
		characterInteractionBetterAnimation = CharacterInteraction.GetComponent<BetterAnimation>();
		EnsureSubViewInputControllers();
	}

	public void ConsumeGamepadConfirmUntilRelease()
	{
		_consumeGamepadConfirmUntilRelease = true;
	}

	public void ReleaseGamepadConfirmConsume(bool isConfirmPressed)
	{
		if (!isConfirmPressed)
		{
			_consumeGamepadConfirmUntilRelease = false;
		}
	}

	public bool ShouldConsumeGamepadConfirm(bool isConfirmPressed)
	{
		ReleaseGamepadConfirmConsume(isConfirmPressed);
		if (isConfirmPressed)
		{
			return _consumeGamepadConfirmUntilRelease;
		}
		return false;
	}

	public void ForceReleaseGamepadConfirmConsume()
	{
		_consumeGamepadConfirmUntilRelease = false;
	}

	private void EnsureSubViewInputControllers()
	{
		if (sideRoomInfo != null)
		{
			_roomSideSubView = sideRoomInfo.GetComponent<LoungeRoomSideInfoSubView>();
			if (_roomSideSubView == null)
			{
				_roomSideSubView = sideRoomInfo.gameObject.AddComponent<LoungeRoomSideInfoSubView>();
			}
			_roomSideSubView.BindOwner(this);
		}
		if (CharacterInteraction != null)
		{
			_characterInteractionSubView = CharacterInteraction.GetComponent<LoungeCharacterInteractionSubView>();
			if (_characterInteractionSubView == null)
			{
				_characterInteractionSubView = CharacterInteraction.gameObject.AddComponent<LoungeCharacterInteractionSubView>();
			}
			_characterInteractionSubView.BindOwner(this);
		}
	}

	protected override void OnInputControllerCreate()
	{
		base.OnInputControllerCreate();
		InitGamePadPromptBindings();
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.SendGiftGotLikeability, OnRefreshView);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_GiveGiftClose, OnPlayerCharacterInteractionShowAnimation);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.SendGiftGotLikeability, OnRefreshView);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_GiveGiftClose, OnPlayerCharacterInteractionShowAnimation);
	}

	private void OnRefreshView(BaseEventContent obj)
	{
		_favorabilityProgressPreviewComponent.AfterSendGiftRefreshFavorabilityUI(Station);
	}

	public void BackToMainWorld()
	{
		if (!CharacterInteraction.gameObject.activeSelf)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
			{
				texts = new string[1] { "确定退出休息室？" },
				OnConfirm = async () =>
				{
					hasInit = false;
					ClearAllInteraction();
					ClearAllHuds();
					ClearPool();
					MonoECS.instance.PushPause();
					await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
					MonoECS.instance.PopPause();
				}
			});
		}
	}

	public void NextCameraPos()
	{
		LoungeUIScene.instance.SetCamera(LoungeUIScene.instance.GetCurrentCameraIndex() + 1);
		SelectFirstGamepadHudCell();
	}

	public void LastCameraPos()
	{
		LoungeUIScene.instance.SetCamera(LoungeUIScene.instance.GetCurrentCameraIndex() - 1);
		SelectFirstGamepadHudCell();
	}

	public List<(ActButton, LoungeInteractBtn)> GenButtons(List<InteractionData> interactions)
	{
		List<(ActButton, LoungeInteractBtn)> list = new List<(ActButton, LoungeInteractBtn)>();
		ColorUtility.TryParseHtmlString("#7C7C7C", out var _);
		for (int i = 0; i < interactions.Count; i++)
		{
			InteractionData optionData = interactions[i];
			(ActButton, LoungeInteractBtn) button = GetButton(optionData.InteractionType);
			list.Add(button);
			if (optionData.StoryGroupId != 0)
			{
				if (!string.IsNullOrEmpty(optionData.InteractionName))
				{
					button.Item2.text.text = optionData.InteractionName;
				}
			}
			else
			{
				button.Item2.text.text = optionData.InteractionName;
			}
			button.Item1.gameObject.SetActive(value: true);
			button.Item1.OnClick.RemoveAllListeners();
			button.Item1.OnClick.AddListener(() =>
			{
				switch (optionData.InteractionType)
				{
				case LoungeDefine.InteractionType.PersonalStory:
					Singleton<LoungeSystemManager>.instance.TriggerCharacterStory(currentSelectedCharacter, currentSelectedPoint);
					break;
				case LoungeDefine.InteractionType.Gift:
					ShowGiftSelection(currentSelectedCharacter, currentSelectedPoint);
					break;
				case LoungeDefine.InteractionType.Chat:
					Singleton<LoungeSystemManager>.instance.InteractWithCharacter(currentSelectedCharacter, currentSelectedPoint);
					break;
				case LoungeDefine.InteractionType.BackToMain:
					LoungeUIScene.instance.SetCharacterAnimState(currentSelectedCharacter, "LoungeLeaveInteract");
					conversation.Close();
					ResetToEmptyState();
					return;
				}
				conversation.Close();
			});
		}
		return list;
	}

	public void ClearAllInteraction()
	{
		if (m_choiceBtns != null)
		{
			Transform[] children = btnGroup.transform.GetChildren();
			for (int i = 0; i < children.Length; i++)
			{
				Object.DestroyImmediate(children[i].gameObject);
			}
			m_choiceBtns.Clear();
			ChoiceBtns?.Clear();
		}
	}

	public void RecycleButtons(List<(ActButton, LoungeInteractBtn)> choiceBtns)
	{
		if (choiceBtns == null)
		{
			return;
		}
		foreach (var choiceBtn in choiceBtns)
		{
			choiceBtn.Item1.OnClick.RemoveAllListeners();
			choiceBtn.Item1.gameObject.SetActive(value: false);
			choiceBtn.Item2.gameObject.SetActive(value: false);
		}
	}

	public (ActButton, LoungeInteractBtn) GetButton(LoungeDefine.InteractionType type)
	{
		foreach (var choiceBtn in m_choiceBtns)
		{
			if (!choiceBtn.Item1.gameObject.activeSelf)
			{
				return choiceBtn;
			}
		}
		LoungeInteractBtn component = Object.Instantiate(btnPrefab, btnGroup.transform).GetComponent<LoungeInteractBtn>();
		component.Initialize(type, Station);
		ActButton activeButton = component.GetActiveButton();
		m_choiceBtns.Add((activeButton, component));
		return (activeButton, component);
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
	}

	protected override void Init()
	{
		base.Init();
		isHideView = false;
		_hasHiddenUiState = false;
		if (!hasInit)
		{
			if (m_choiceBtns == null)
			{
				m_choiceBtns = ListPool<(ActButton, LoungeInteractBtn)>.Get();
			}
			m_choiceBtns.Clear();
			InitHudSystem();
			btn_hide.SetBtnClick(HideView);
			btn_empty.SetBtnClick(ShowView);
			btnRoomManagement.SetBtnClick(ShowRoomManagement);
			btnInviteCharacter.SetBtnClick(ShowCharacterList);
			btnTreasure.SetBtnClick(ShowTreasureView);
			btnLeftPage.SetBtnClick(LastCameraPos);
			btnRightPage.SetBtnClick(NextCameraPos);
			hasInit = true;
		}
		conversation.Init();
		sideRoomInfo?.HideImmediately();
		Singleton<LoungeSystemManager>.instance.SubscribeLoungeMainViewEvents(this, isSubscribe: true);
		SetGamePadTipsActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		ScheduleEnsureGamepadHudSelection();
		ResetEmptyBtnState();
	}

	private void ResetEmptyBtnState()
	{
		btn_empty.gameObject.SetActive(value: false);
	}

	private void ShowView()
	{
		if (isHideView)
		{
			isHideView = false;
			_showViewFrame = Time.frameCount;
			RestoreHiddenUiState();
			ResetEmptyBtnState();
			if (InteractContent != null && InteractContent.activeSelf)
			{
				_characterInteractionSubView?.OnInteractionChoicesReady();
			}
			else
			{
				_characterInteractionSubView?.RefreshGamepadChoicePrompts();
			}
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				SetGamePadTipsActive(active: true);
			}
		}
	}

	private void HideView()
	{
		if (!isHideView)
		{
			isHideView = true;
			_hideViewFrame = Time.frameCount;
			CacheHiddenUiState();
			InteractContent?.SetActive(value: false);
			closeChoicePanel?.SetActive(value: false);
			switchGroup?.SetActive(value: false);
			roomChangeGroup?.SetActive(value: false);
			SetAllHudsVisible(visible: false);
			btn_hide?.gameObject.SetActive(value: false);
			btn_empty?.gameObject.SetActive(value: true);
			HideAllGamepadPrompts();
			ClearGamepadHudSelection();
			_characterInteractionSubView?.RefreshGamepadChoicePrompts();
		}
	}

	private void CacheHiddenUiState()
	{
		_hasHiddenUiState = true;
		_cachedInteractContentActive = InteractContent != null && InteractContent.activeSelf;
		_cachedCloseChoicePanelActive = closeChoicePanel != null && closeChoicePanel.activeSelf;
		_cachedSwitchGroupActive = switchGroup != null && switchGroup.activeSelf;
		_cachedRoomChangeGroupActive = roomChangeGroup != null && roomChangeGroup.activeSelf;
		_cachedHudRootActive = hudRootGo != null && hudRootGo.activeSelf;
		_cachedHideButtonActive = btn_hide != null && btn_hide.gameObject.activeSelf;
	}

	private void RestoreHiddenUiState()
	{
		if (!_hasHiddenUiState)
		{
			InteractContent?.SetActive(value: true);
			btn_hide?.gameObject.SetActive(value: true);
			return;
		}
		InteractContent?.SetActive(_cachedInteractContentActive);
		closeChoicePanel?.SetActive(_cachedCloseChoicePanelActive);
		switchGroup?.SetActive(_cachedSwitchGroupActive);
		roomChangeGroup?.SetActive(_cachedRoomChangeGroupActive);
		hudRootGo?.SetActive(_cachedHudRootActive);
		btn_hide?.gameObject.SetActive(_cachedHideButtonActive);
		_hasHiddenUiState = false;
	}

	private void EnsureInteractContentShown()
	{
		isHideView = false;
		_hasHiddenUiState = false;
		InteractContent?.SetActive(value: true);
		btn_hide?.gameObject.SetActive(value: true);
		btn_empty?.gameObject.SetActive(value: false);
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show")?.Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
		ScheduleEnsureGamepadHudSelection();
	}

	protected override void UnInit()
	{
		base.UnInit();
		CancelGamepadPromptRefresh();
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		_roomSideSubView?.FocusOut();
		_characterInteractionSubView?.FocusOut();
		ClearGamepadHudSelection();
		_characterSelectHandleAnchors.Clear();
		conversation.UnInit();
		Singleton<LoungeSystemManager>.instance?.SubscribeLoungeMainViewEvents(this, isSubscribe: false);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		SetGamePadTipsActive(type == DeviceInputMode.Gamepad);
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		SetGamePadTipsActive(mode == DeviceInputMode.Gamepad);
	}

	private void InitGamePadPromptBindings()
	{
		if (!_gamepadPromptInited)
		{
			_gamepadPromptInited = true;
			operateBtnPromptA?.SetBindingAction("UI/Confirm");
			operateBtnPromptB?.SetBindingAction("UI/Back");
			operateBtnPromptA?.SetLocalizeString(13);
			operateBtnPromptB?.SetLocalizeString(606);
			operateBtnPromptMenu?.SetBindingAction("UI/Start");
			operateBtnPromptView?.SetBindingAction("UI/View");
			operateBtnPromptY?.SetBindingAction("UI/UISpecial1");
			operateBtnPromptLT?.SetBindingAction("UI/LeftTrigger");
			operateBtnPromptRT?.SetBindingAction("UI/RightTrigger");
			operateBtnPromptX?.SetBindingAction("UI/UISpecial2");
			operateBtnPromptX?.SetLocalizeString(0);
		}
	}

	public void SetGamePadTipsActive(bool active)
	{
		bool flag = active && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		if (isHideView)
		{
			HideAllGamepadPrompts();
			ClearGamepadHudSelection();
			return;
		}
		if (IsGamepadBlockedByCameraTransition)
		{
			HideAllGamepadPrompts();
			ClearGamepadHudSelection();
			return;
		}
		bool flag2 = _roomSideSubView != null && _roomSideSubView.IsFocused;
		bool flag3 = _characterInteractionSubView != null && _characterInteractionSubView.IsFocused;
		bool flag4 = flag && !IsSubViewInputOccupied;
		if (!flag)
		{
			prompBoard?.SetActive(value: false);
			operateBtnPromptA?.SetVisible(vis: false);
			operateBtnPromptB?.SetVisible(vis: false);
			operateBtnPromptMenu?.SetVisible(vis: false);
			operateBtnPromptView?.SetVisible(vis: false);
			operateBtnPromptY?.SetVisible(vis: false);
			operateBtnPromptLT?.SetVisible(vis: false);
			operateBtnPromptRT?.SetVisible(vis: false);
			operateBtnPromptX?.SetVisible(vis: false);
			ClearGamepadHudSelection();
		}
		else if (flag2)
		{
			prompBoard?.SetActive(value: true);
			operateBtnPromptA?.SetVisible(vis: false);
			operateBtnPromptB?.SetVisible(vis: true);
			operateBtnPromptB?.RefreshIcon();
			operateBtnPromptMenu?.SetVisible(vis: false);
			operateBtnPromptView?.SetVisible(vis: false);
			operateBtnPromptY?.SetVisible(vis: false);
			operateBtnPromptLT?.SetVisible(vis: false);
			operateBtnPromptRT?.SetVisible(vis: false);
			operateBtnPromptX?.SetVisible(vis: false);
			ClearGamepadHudSelection();
		}
		else if (flag3)
		{
			if (flag)
			{
				_characterInteractionSubView?.EnsureFirstChoiceSelected();
			}
			prompBoard?.SetActive(value: false);
			operateBtnPromptA?.SetVisible(vis: false);
			operateBtnPromptB?.SetVisible(vis: false);
			operateBtnPromptMenu?.SetVisible(vis: false);
			operateBtnPromptView?.SetVisible(vis: false);
			operateBtnPromptY?.SetVisible(vis: false);
			operateBtnPromptLT?.SetVisible(vis: false);
			operateBtnPromptRT?.SetVisible(vis: false);
			RefreshInteractionGamepadPromptX(flag);
			_characterInteractionSubView?.RefreshGamepadChoicePrompts();
			ClearGamepadHudSelection();
		}
		else
		{
			operateBtnPromptX?.SetVisible(vis: false);
			prompBoard?.SetActive(flag4);
			RefreshMainGamepadPromptA(flag4);
			operateBtnPromptA?.SetVisible(flag4);
			operateBtnPromptB?.SetVisible(flag4);
			operateBtnPromptMenu?.SetVisible(flag4);
			operateBtnPromptView?.SetVisible(flag4);
			operateBtnPromptY?.SetVisible(flag4);
			operateBtnPromptLT?.SetVisible(flag4);
			operateBtnPromptRT?.SetVisible(flag4);
			if (!flag4)
			{
				ClearGamepadHudSelection();
			}
			else
			{
				SelectFirstGamepadHudCell();
			}
		}
	}

	private void HideAllGamepadPrompts()
	{
		prompBoard?.SetActive(value: false);
		operateBtnPromptA?.SetVisible(vis: false);
		operateBtnPromptB?.SetVisible(vis: false);
		operateBtnPromptMenu?.SetVisible(vis: false);
		operateBtnPromptView?.SetVisible(vis: false);
		operateBtnPromptY?.SetVisible(vis: false);
		operateBtnPromptLT?.SetVisible(vis: false);
		operateBtnPromptRT?.SetVisible(vis: false);
		operateBtnPromptX?.SetVisible(vis: false);
		_characterInteractionSubView?.RefreshGamepadChoicePrompts();
	}

	public void OnCameraTransitionStarted(int characterId)
	{
		if (characterId > 0)
		{
			switchGroup.gameObject.SetActive(value: false);
			closeChoicePanel.SetActive(value: true);
		}
		HideAllGamepadPrompts();
		ClearGamepadHudSelection();
	}

	public void OnCameraTransitionEnded()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			if (!IsSubViewInputOccupied)
			{
				SelectFirstGamepadHudCell();
			}
			SetGamePadTipsActive(active: true);
		}
	}

	private void RefreshGamepadPromptsAfterInputRestore()
	{
		CancelGamepadPromptRefresh();
		_gamepadPromptRefreshCts = new CancellationTokenSource();
		RefreshGamepadPromptsAfterInputRestoreAsync(_gamepadPromptRefreshCts.Token).Forget();
	}

	private void CancelGamepadPromptRefresh()
	{
		if (_gamepadPromptRefreshCts != null)
		{
			_gamepadPromptRefreshCts.Cancel();
			_gamepadPromptRefreshCts.Dispose();
			_gamepadPromptRefreshCts = null;
		}
	}

	private async UniTaskVoid RefreshGamepadPromptsAfterInputRestoreAsync(CancellationToken token)
	{
		await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate, token);
		if (!token.IsCancellationRequested && !IsDestroyed && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			SetGamePadTipsActive(active: true);
			((IOperatePromptIconCollectionProvider)this).Refresh();
		}
	}

	private void RefreshGamepadHudList(bool forceSelectFirst = false)
	{
		_gamepadHudCells.Clear();
		if (_activeHudCells == null)
		{
			return;
		}
		foreach (Dictionary<int, LoungeHudCell> value in _activeHudCells.Values)
		{
			foreach (LoungeHudCell value2 in value.Values)
			{
				if (value2 != null && value2.gameObject.activeSelf)
				{
					_gamepadHudCells.Add(value2);
				}
			}
		}
		_gamepadHudCells.Sort(CompareHudCellHorizontalPosition);
		if (_gamepadHudCells.Count == 0)
		{
			_gamepadSelectedHudIndex = -1;
		}
		else if (forceSelectFirst || _gamepadSelectedHudIndex < 0 || _gamepadSelectedHudIndex >= _gamepadHudCells.Count)
		{
			_gamepadSelectedHudIndex = 0;
		}
	}

	private static int CompareHudCellHorizontalPosition(LoungeHudCell a, LoungeHudCell b)
	{
		return a.RectTransform.anchoredPosition.x.CompareTo(b.RectTransform.anchoredPosition.x);
	}

	private void RefreshGamepadHudSelectionVisual()
	{
		bool isGamepadMode = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		LoungeHudCell loungeHudCell = null;
		if (_gamepadSelectedHudIndex >= 0 && _gamepadSelectedHudIndex < _gamepadHudCells.Count)
		{
			loungeHudCell = _gamepadHudCells[_gamepadSelectedHudIndex];
		}
		if (_activeHudCells == null)
		{
			return;
		}
		foreach (Dictionary<int, LoungeHudCell> value in _activeHudCells.Values)
		{
			foreach (LoungeHudCell value2 in value.Values)
			{
				value2?.SetGamepadSelected(value2 == loungeHudCell, isGamepadMode);
			}
		}
		if (loungeHudCell != _lastCachedCharacterSelectHandleCell)
		{
			CacheCharacterSelectHandlePosition(loungeHudCell);
			_lastCachedCharacterSelectHandleCell = loungeHudCell;
		}
	}

	private void ApplyGamepadHudSelection(bool forceSelectFirst = false)
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad && !IsSubViewInputOccupied && !IsGamepadBlockedByCameraTransition)
		{
			RefreshGamepadHudList(forceSelectFirst);
			RefreshGamepadHudSelectionVisual();
		}
	}

	private void RefreshMainGamepadPromptA(bool isGamepad)
	{
		operateBtnPromptA?.SetVisible(isGamepad);
		if (isGamepad)
		{
			operateBtnPromptA?.RefreshIcon();
		}
	}

	private void RefreshGamepadPromptState()
	{
		RefreshGamepadHudSelectionVisual();
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			RefreshMainGamepadPromptA(isGamepad: true);
		}
	}

	private void ScheduleEnsureGamepadHudSelection()
	{
		EnsureGamepadHudSelectionAsync().Forget();
	}

	private async UniTaskVoid EnsureGamepadHudSelectionAsync()
	{
		await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate);
		if (!IsDestroyed && !IsSubViewInputOccupied && !IsGamepadBlockedByCameraTransition)
		{
			_lastCachedCharacterSelectHandleCell = null;
			SelectFirstGamepadHudCell();
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				SetGamePadTipsActive(active: true);
			}
		}
	}

	private void RefreshInteractionGamepadPromptX(bool isGamepad)
	{
		bool flag = isGamepad && CharacterInteraction != null && CharacterInteraction.activeSelf;
		operateBtnPromptX?.SetVisible(flag);
		if (flag)
		{
			operateBtnPromptX?.RefreshIcon();
		}
	}

	private void SelectFirstGamepadHudCell()
	{
		_applyGamepadHudSelectionAfterLayout = true;
		ApplyGamepadHudSelection(forceSelectFirst: true);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			RefreshMainGamepadPromptA(isGamepad: true);
		}
	}

	private void ClearGamepadHudSelection()
	{
		_applyGamepadHudSelectionAfterLayout = false;
		_lastCachedCharacterSelectHandleCell = null;
		if (_activeHudCells != null)
		{
			foreach (Dictionary<int, LoungeHudCell> value in _activeHudCells.Values)
			{
				foreach (LoungeHudCell value2 in value.Values)
				{
					value2?.SetGamepadSelected(selected: false, isGamepadMode: false);
				}
			}
		}
		_gamepadHudCells.Clear();
		_gamepadSelectedHudIndex = -1;
	}

	public void NavigateGamepadHud(int direction)
	{
		if (direction == 0 || IsGamepadBlockedByCameraTransition)
		{
			return;
		}
		RefreshGamepadHudList();
		if (_gamepadHudCells.Count == 0)
		{
			return;
		}
		if (_gamepadSelectedHudIndex < 0)
		{
			_gamepadSelectedHudIndex = 0;
		}
		else
		{
			_gamepadSelectedHudIndex += ((direction > 0) ? 1 : (-1));
			if (_gamepadSelectedHudIndex >= _gamepadHudCells.Count)
			{
				_gamepadSelectedHudIndex = _gamepadHudCells.Count - 1;
			}
			else if (_gamepadSelectedHudIndex < 0)
			{
				_gamepadSelectedHudIndex = 0;
			}
		}
		RefreshGamepadPromptState();
	}

	public void ConfirmGamepadHudSelection()
	{
		if (IsGamepadBlockedByCameraTransition)
		{
			return;
		}
		RefreshGamepadHudList();
		if (_gamepadSelectedHudIndex < 0 || _gamepadSelectedHudIndex >= _gamepadHudCells.Count)
		{
			return;
		}
		LoungeHudCell loungeHudCell = _gamepadHudCells[_gamepadSelectedHudIndex];
		LoungePoint currentData = loungeHudCell.CurrentData;
		if (currentData != null && !loungeHudCell.TrySubmitSelectedAction())
		{
			int num = loungeHudCell.CharacterId;
			if (num <= 0 && currentData.character.Count > 0)
			{
				num = currentData.character[0];
			}
			LoungeUIScene.instance?.TrySelectCharacterForInteraction(num);
		}
	}

	public void ToggleRoomManagementByGamepad()
	{
		if (!(sideRoomInfo == null))
		{
			if (!sideRoomInfo.IsSidePanelVisible)
			{
				SubmitGamepadButton(btnRoomManagement);
			}
			else
			{
				HideRoomManagement();
			}
		}
	}

	public void TryShowTreasureViewByGamepad()
	{
		SubmitGamepadButton(btnTreasure);
	}

	public void TryShowCharacterListByGamepad()
	{
		SubmitGamepadButton(btnInviteCharacter);
	}

	public void TryLastCameraPosByGamepad()
	{
		SubmitGamepadButton(btnLeftPage);
	}

	public void TryNextCameraPosByGamepad()
	{
		SubmitGamepadButton(btnRightPage);
	}

	private static void SubmitGamepadButton(ActButton button)
	{
		if (!(button == null) && button.gameObject.activeInHierarchy)
		{
			EventSystemHelper.Click(button.gameObject);
		}
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide")?.Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public void ShowCharacterList()
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_INVITECHARACTERWITHMAP);
	}

	public void ShowCharacterDetail(int characterId)
	{
	}

	private void OnPlayerCharacterInteractionShowAnimation(BaseEventContent obj)
	{
		characterInteractionBetterAnimation.GetSequence("Show")?.Play();
	}

	public void OnCameraBlendStart(int characterId)
	{
		OnCameraTransitionStarted(characterId);
	}

	public void ShowInteractConversation(int characterId, int pointId)
	{
		prompBoard?.SetActive(value: false);
		ClearGamepadHudSelection();
		_characterInteractionSubView?.FocusIn();
		switchGroup.gameObject.SetActive(value: false);
		roomChangeGroup.gameObject.SetActive(value: false);
		CharacterInteraction.gameObject.SetActive(value: true);
		EnsureInteractContentShown();
		closeChoicePanel.gameObject.SetActive(value: true);
		characterInteractionBetterAnimation.GetSequence("Show")?.Play();
		_favorabilityProgressPreviewComponent.InitFavorabilityUI(Station);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			SetGamePadTipsActive(active: true);
		}
		ShowConversationView(characterId);
	}

	public async UniTask ShowConversationView(int characterId)
	{
		await conversation.Show(characterId, LoungeConversationType.InteractType, () =>
		{
			int key = Model<LoungeModel>.Interface.CharacterToIndex[characterId];
			int pointId = ((Model<LoungeModel>.Interface.IndexToCharacter[key] != null) ? Model<LoungeModel>.Interface.IndexToCharacter[key].id : 0);
			ShowInteractionUI(characterId, pointId);
		});
	}

	public void ShowInteractionUI(int characterId, int pointId)
	{
		currentSelectedCharacter = characterId;
		currentSelectedPoint = pointId;
		if (ChoiceBtns != null && ChoiceBtns.Count > 0)
		{
			ClearAllInteraction();
		}
		EnsureInteractContentShown();
		ChoiceBtns = GenButtons(Singleton<LoungeSystemManager>.instance.InteractionManager.GetAvailableInteractions(characterId));
		_characterInteractionSubView?.FocusIn();
		_characterInteractionSubView?.OnInteractionChoicesReady();
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			SetGamePadTipsActive(active: true);
		}
	}

	public void RefreshCharacterInteractions()
	{
		List<(ActButton, LoungeInteractBtn)> choiceBtns = ChoiceBtns;
		if (choiceBtns != null && choiceBtns.Count > 0)
		{
			ClearAllInteraction();
		}
		CharacterInteraction.gameObject.SetActive(value: true);
		EnsureInteractContentShown();
		ChoiceBtns = GenButtons(Singleton<LoungeSystemManager>.instance.InteractionManager.GetAvailableInteractions(currentSelectedCharacter));
		_characterInteractionSubView?.OnInteractionChoicesReady();
	}

	public void ToggleInteractionChoicePanel()
	{
		if ((MonoECS.instance.InputMode != DeviceInputMode.Gamepad || Time.frameCount != _showViewFrame) && !(InteractContent == null))
		{
			if (isHideView)
			{
				ShowView();
			}
			else
			{
				HideView();
			}
		}
	}

	public void TryHandlePressAnyKeyByGamepad()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad && isHideView && Time.frameCount != _hideViewFrame)
		{
			ShowView();
		}
	}

	public bool IsAllUiHidden()
	{
		return isHideView;
	}

	public bool IsRestoringHiddenUiThisFrame()
	{
		return Time.frameCount == _showViewFrame;
	}

	public void HideInteractionUI()
	{
		ForceReleaseGamepadConfirmConsume();
		_characterInteractionSubView?.FocusOut();
		if (ChoiceBtns != null)
		{
			RecycleButtons(ChoiceBtns);
		}
		isHideView = false;
		_hasHiddenUiState = false;
		currentSelectedCharacter = 0;
		currentSelectedPoint = 0;
		InteractContent?.SetActive(value: false);
		CharacterInteraction.gameObject.SetActive(value: false);
		characterInteractionBetterAnimation.GetSequence("Hide")?.Play();
		closeChoicePanel.gameObject.SetActive(value: false);
		switchGroup.gameObject.SetActive(value: true);
		roomChangeGroup.gameObject.SetActive(RuntimeConfigs.data.areaLists.Keys.Count > 1);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			SetGamePadTipsActive(active: true);
			RefreshGamepadPromptsAfterInputRestore();
		}
	}

	public void ShowTreasureView()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ITEMTREASURECENTER);
	}

	public void ShowGiftSelection(int characterId, int pointId)
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_GiveGiftView, new UI_GiveGiftViewData
		{
			characterId = characterId,
			pointId = pointId
		});
	}

	public void ResetToEmptyState()
	{
		LoungeUIScene.instance.ResetToEmptyState();
	}

	public void OnEnterIdleMode()
	{
		HideAllGamepadPrompts();
		ClearGamepadHudSelection();
		cameraTimelineRoot?.SetActive(value: true);
		switchGroup?.SetActive(value: false);
		roomChangeGroup?.SetActive(value: false);
		SetAllHudsVisible(visible: false);
		if (CharacterInteraction.activeSelf)
		{
			CharacterInteraction.SetActive(value: false);
			closeChoicePanel?.SetActive(value: false);
		}
	}

	public void OnExitIdleMode()
	{
		cameraTimelineRoot?.SetActive(value: false);
		switchGroup?.SetActive(value: true);
		roomChangeGroup?.SetActive(RuntimeConfigs.data.areaLists.Keys.Count > 1);
		SetAllHudsVisible(visible: true);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			SetGamePadTipsActive(active: true);
		}
	}

	public void ShowRoomManagement()
	{
		sideRoomInfo?.Show();
		_roomSideSubView?.FocusIn();
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			SetGamePadTipsActive(active: true);
		}
	}

	public void HideRoomManagement()
	{
		_roomSideSubView?.FocusOut();
		sideRoomInfo?.Hide();
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			SetGamePadTipsActive(active: true);
			RefreshGamepadPromptsAfterInputRestore();
		}
	}

	private void InitHudSystem()
	{
		_activeHudCells = new Dictionary<int, Dictionary<int, LoungeHudCell>>();
		_hudCellPool = new Queue<LoungeHudCell>();
		for (int i = 0; i < 20; i++)
		{
			LoungeHudCell item = CreateHudCell();
			_hudCellPool.Enqueue(item);
		}
	}

	public void SetMainCamera(Camera camera)
	{
		_mainCamera = camera;
	}

	private LoungeHudCell CreateHudCell()
	{
		if (hudCellPrefab == null)
		{
			Debug.LogError("[LoungeMainView] HUD预制体为空！");
			return null;
		}
		GameObject gameObject = Object.Instantiate(hudCellPrefab, hudRoot);
		LoungeHudCell component = gameObject.GetComponent<LoungeHudCell>();
		gameObject.SetActive(value: false);
		return component;
	}

	private LoungeHudCell GetHudCellFromPool()
	{
		if (_hudCellPool.Count > 0)
		{
			return _hudCellPool.Dequeue();
		}
		return CreateHudCell();
	}

	private void ReturnHudCellToPool(LoungeHudCell cell)
	{
		if (!(cell == null))
		{
			if (cell == _lastCachedCharacterSelectHandleCell)
			{
				_lastCachedCharacterSelectHandleCell = null;
			}
			cell.ResetCharacterSelectHandlePosition();
			cell.gameObject.SetActive(value: false);
			_hudCellPool.Enqueue(cell);
		}
	}

	private Transform FindCharacterModelNode(Transform characterRoot, string nodePath)
	{
		if (characterRoot == null || characterRoot.childCount == 0)
		{
			return null;
		}
		return characterRoot.GetChild(0).Find(nodePath);
	}

	private Transform ResolveCharacterHudTarget(Transform characterRoot)
	{
		return FindCharacterModelNode(characterRoot, "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2") ?? characterRoot;
	}

	private Transform ResolveCharacterSelectHandleTarget(Transform characterRoot, Transform fallbackTarget)
	{
		return FindCharacterModelNode(characterRoot, "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2/BN_Bosom_L01/BN_Bosom_L02/BN_Bosom_L03") ?? fallbackTarget;
	}

	private bool TryGetStableCharacterSelectHandleWorldPosition(LoungeHudCell cell, out Vector3 worldPosition)
	{
		worldPosition = default;
		Transform characterSelectTargetTransform = cell.CharacterSelectTargetTransform;
		if (characterSelectTargetTransform == null)
		{
			return false;
		}
		Transform transform = Singleton<LoungeSystemManager>.instance.CharacterManager.GetCharacterGo(cell.CharacterId)?.transform;
		if (transform == null)
		{
			worldPosition = characterSelectTargetTransform.position;
			return true;
		}
		if (!_characterSelectHandleAnchors.TryGetValue(cell.CharacterId, out var value) || value.CharacterRoot != transform)
		{
			value = new CharacterSelectHandleAnchor(transform, transform.InverseTransformPoint(characterSelectTargetTransform.position));
			_characterSelectHandleAnchors[cell.CharacterId] = value;
		}
		worldPosition = transform.TransformPoint(value.LocalPosition);
		return true;
	}

	public void RegisterPointHud(LoungePoint pointData, Transform worldTransform)
	{
		int id = pointData.id;
		if (_activeHudCells.ContainsKey(id))
		{
			UnregisterPointHud(id);
		}
		else
		{
			_activeHudCells.Add(id, new Dictionary<int, LoungeHudCell>());
		}
		if (pointData.character.Count == 0)
		{
			if (pointData.useType == LoungeInteractPointUseType.LoungeInteractPointUseEmpty)
			{
				LoungeHudCell hudCellFromPool = GetHudCellFromPool();
				if (!(hudCellFromPool == null))
				{
					_activeHudCells[id].Add(id, hudCellFromPool);
					hudCellFromPool.Init(pointData, id, worldTransform);
					hudCellFromPool.gameObject.SetActive(value: true);
					hudCellFromPool.transform.SetSiblingIndex(id);
					UpdateHudPosition(id);
				}
			}
			return;
		}
		foreach (int item in pointData.character)
		{
			LoungeHudCell hudCellFromPool2 = GetHudCellFromPool();
			if (hudCellFromPool2 == null)
			{
				break;
			}
			Transform transform = Singleton<LoungeSystemManager>.instance.CharacterManager.GetCharacterGo(item)?.transform;
			if (!(transform == null))
			{
				if (!_activeHudCells.ContainsKey(id))
				{
					_activeHudCells.Add(id, new Dictionary<int, LoungeHudCell>());
				}
				_activeHudCells[id].Add(item, hudCellFromPool2);
				Transform transform2 = ResolveCharacterHudTarget(transform);
				Transform characterSelectTargetTransform = ResolveCharacterSelectHandleTarget(transform, transform2);
				float characterHudHeightOffset = CoreUtils.GetData(item, RuntimeConfigs.data.entityCharacterDatas).characterHeight * 0.16f;
				hudCellFromPool2.Init(pointData, item, transform2, characterSelectTargetTransform, characterHudHeightOffset);
				hudCellFromPool2.gameObject.SetActive(value: true);
				hudCellFromPool2.transform.SetSiblingIndex(id);
				UpdateHudPosition(id);
			}
		}
	}

	private void CacheCharacterSelectHandlePosition(LoungeHudCell cell)
	{
		if (cell == null)
		{
			return;
		}
		if (cell.isEmptyPoint)
		{
			cell.ResetCharacterSelectHandlePosition();
			return;
		}
		if (_mainCamera == null)
		{
			_mainCamera = Camera.main;
			if (_mainCamera == null)
			{
				return;
			}
		}
		if (_hudRootRect == null || cell.RectTransform == null)
		{
			cell.ResetCharacterSelectHandlePosition();
			return;
		}
		if (!TryGetStableCharacterSelectHandleWorldPosition(cell, out var worldPosition))
		{
			cell.ResetCharacterSelectHandlePosition();
			return;
		}
		if (_mainCamera.WorldToViewportPoint(worldPosition).z <= 0f)
		{
			cell.ResetCharacterSelectHandlePosition();
			return;
		}
		Vector3 vector = _mainCamera.WorldToScreenPoint(worldPosition);
		if (!RectTransformUtility.ScreenPointToLocalPointInRectangle(_hudRootRect, vector, Singleton<NewUIManager>.instance.UICamera, out var localPoint))
		{
			cell.ResetCharacterSelectHandlePosition();
		}
		else
		{
			cell.LockCharacterSelectHandleHudRootPosition(localPoint);
		}
	}

	public void RegisterAllPointHuds(Dictionary<int, LoungePoint> pointsData, Dictionary<int, Transform> pointTransforms)
	{
		foreach (KeyValuePair<int, Transform> pointTransform in pointTransforms)
		{
			int key = pointTransform.Key;
			Transform value = pointTransform.Value;
			if (pointsData.TryGetValue(key, out var value2))
			{
				RegisterPointHud(value2, value);
			}
		}
	}

	public void UnregisterPointHud(int pointId)
	{
		if (!_activeHudCells.TryGetValue(pointId, out var value))
		{
			return;
		}
		foreach (LoungeHudCell value2 in value.Values)
		{
			ReturnHudCellToPool(value2);
		}
		_activeHudCells.Remove(pointId);
	}

	public void UpdateHudPosition(int pointId)
	{
		if (!_activeHudCells.TryGetValue(pointId, out var value))
		{
			return;
		}
		if (_mainCamera == null)
		{
			_mainCamera = Camera.main;
			if (_mainCamera == null)
			{
				return;
			}
		}
		if (value.Count == 0)
		{
			return;
		}
		foreach (int key in value.Keys)
		{
			LoungeHudCell loungeHudCell = value[key];
			Vector3 zero = Vector3.zero;
			if (loungeHudCell.TargetHudTransform == null)
			{
				continue;
			}
			zero = ((!loungeHudCell.isEmptyPoint) ? (loungeHudCell.TargetHudTransform.position - loungeHudCell.TargetHudTransform.right * loungeHudCell.CharacterHudHeightOffset) : (loungeHudCell.TargetHudTransform.position + Vector3.up * hudHeightOffset));
			Vector3 vector = _mainCamera.WorldToViewportPoint(zero);
			bool flag = vector.z > 0f;
			bool flag2 = vector.x >= 0f && vector.x <= 1f && vector.y >= 0f && vector.y <= 1f;
			if (!flag || !flag2)
			{
				loungeHudCell.gameObject.SetActive(value: false);
				continue;
			}
			float num = Vector3.Distance(_mainCamera.transform.position, zero);
			if (num > hudMaxDistance)
			{
				loungeHudCell.gameObject.SetActive(value: false);
				continue;
			}
			loungeHudCell.gameObject.SetActive(value: true);
			Vector3 vector2 = _mainCamera.WorldToScreenPoint(zero);
			vector2.x = Mathf.Clamp(vector2.x, 50f, (float)Screen.width - 50f);
			vector2.y = Mathf.Clamp(vector2.y, 50f, (float)Screen.height - 50f);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(_hudRootRect, vector2, Singleton<NewUIManager>.instance.UICamera, out var localPoint);
			if (!loungeHudCell.isEmptyPoint)
			{
				localPoint += hudCharacterOffset;
			}
			loungeHudCell.RectTransform.anchoredPosition = localPoint;
			float num2 = hudMaxDistance * 0.6f;
			if (num > num2)
			{
				float value2 = 1f - (num - num2) / (hudMaxDistance - num2);
				value2 = Mathf.Clamp(value2, 0.5f, 1f);
				loungeHudCell.transform.localScale = Vector3.one * value2;
			}
			else
			{
				loungeHudCell.transform.localScale = Vector3.one;
			}
		}
	}

	private void LateUpdate()
	{
		if (!cameraTimelineRoot.activeSelf)
		{
			UpdateAllHudPositions();
			if (_applyGamepadHudSelectionAfterLayout)
			{
				_applyGamepadHudSelectionAfterLayout = false;
				ApplyGamepadHudSelection(_gamepadSelectedHudIndex < 0);
			}
			_lastCachedCharacterSelectHandleCell?.RefreshLockedCharacterSelectHandlePosition();
		}
	}

	public void UpdateAllHudPositions()
	{
		if (_activeHudCells == null || _activeHudCells.Count == 0 || LoungeUIScene.instance == null)
		{
			return;
		}
		foreach (KeyValuePair<int, Dictionary<int, LoungeHudCell>> activeHudCell in _activeHudCells)
		{
			int key = activeHudCell.Key;
			if (key != 0)
			{
				UpdateHudPosition(key);
			}
		}
	}

	public void SetHudVisible(int pointId, bool visible)
	{
		if (!_activeHudCells.TryGetValue(pointId, out var value))
		{
			return;
		}
		foreach (LoungeHudCell value2 in value.Values)
		{
			value2.gameObject.SetActive(visible);
		}
	}

	public void SetAllHudsVisible(bool visible)
	{
		hudRootGo?.SetActive(visible);
	}

	public void ClearPool()
	{
		if (!(hudRoot == null))
		{
			for (int num = hudRoot.childCount - 1; num >= 0; num--)
			{
				Object.DestroyImmediate(hudRoot.GetChild(num).gameObject);
			}
		}
	}

	public void ClearAllHuds()
	{
		if (_activeHudCells == null)
		{
			return;
		}
		tempHudPoints.Clear();
		foreach (Dictionary<int, LoungeHudCell> value in _activeHudCells.Values)
		{
			foreach (LoungeHudCell value2 in value.Values)
			{
				ReturnHudCellToPool(value2);
			}
		}
		_activeHudCells.Clear();
	}

	public void RefreshHudsFromModel(int preIndex, int curIndex)
	{
		if (LoungeUIScene.instance == null || curIndex < 0)
		{
			return;
		}
		roomChangeGroup.gameObject.SetActive(RuntimeConfigs.data.areaLists.Keys.Count > 1);
		ClearAllHuds();
		Dictionary<int, Transform> dictionary = LoungeUIScene.instance.ModelsPointPosGroup[curIndex];
		Dictionary<int, LoungePoint> indexToCharacter = Model<LoungeModel>.Interface.IndexToCharacter;
		RefreshRoomAreaInfo(curIndex);
		foreach (int key in dictionary.Keys)
		{
			if (indexToCharacter.ContainsKey(key))
			{
				tempHudPoints.Add(key, indexToCharacter[key]);
			}
		}
		RegisterAllPointHuds(tempHudPoints, dictionary);
		SelectFirstGamepadHudCell();
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			SetGamePadTipsActive(active: true);
		}
		ScheduleEnsureGamepadHudSelection();
	}

	public void RefreshRoomAreaInfo(int index)
	{
		roomNameText.StringReference.TableEntryReference = Singleton<LoungeSystemManager>.instance.RoomManager.GetRoom(index).RoomName;
	}
}
