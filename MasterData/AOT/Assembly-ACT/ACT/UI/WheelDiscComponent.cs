using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Model;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.DualShock;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class WheelDiscComponent : SubUIView<WheelDiscInputController>, IUIFrameElement
{
	private enum OpenFuncDefine
	{
		None = 0,
		Bag = 1004,
		Character = 1017,
		Summary = 1008,
		CardPool = 1007,
		ActivityCenter = 3001,
		Task = 1011,
		Team = 1013,
		Message = 1030,
		BattlePass = 1044,
		Map = 1028,
		CloseWheel = 999
	}

	[Serializable]
	private class SelectionItem
	{
		[SerializeField]
		private RectTransform _itemCenter;

		[SerializeField]
		private RectTransform _selectedNode;

		[SerializeField]
		private OpenFuncDefine _funcDefine;

		[SerializeField]
		private BImage _systemIcon;

		[SerializeField]
		private RedDotItem _redDotItem;

		[SerializeField]
		private int _selectorAngles = 45;

		private float _fromAngle;

		private float _toAngle;

		private bool _isVisible;

		public bool isUnlock { get; set; }

		public OpenFuncDefine FuncDefine => _funcDefine;

		public BImage systemIcon
		{
			get
			{
				return _systemIcon;
			}
			set
			{
				_systemIcon = value;
			}
		}

		public void Init()
		{
			float num = Vector2.SignedAngle(Vector2.right, _itemCenter.localPosition);
			float num2 = (float)_selectorAngles * 0.5f;
			_fromAngle = num - num2;
			_toAngle = num + num2;
			Deselect();
			isUnlock = _funcDefine == OpenFuncDefine.CloseWheel || Singleton<SystemUnlockManager>.instance.IsUnlock((int)_funcDefine);
		}

		public void Deselect()
		{
			_selectedNode.localScale = Vector3.zero;
		}

		public void Select()
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Disk_Click");
			_selectedNode.localScale = Vector3.one;
		}

		public bool ContainsAngle(float angle)
		{
			if (!ContainsAngle(angle, _fromAngle, _toAngle) && !ContainsAngle(angle + 360f, _fromAngle, _toAngle))
			{
				return ContainsAngle(angle, _fromAngle + 360f, _toAngle + 360f);
			}
			return true;
		}

		private static bool ContainsAngle(float angle, float fromAngle, float toAngle)
		{
			if (angle >= fromAngle)
			{
				return angle <= toAngle;
			}
			return false;
		}

		public float GetItemAngle()
		{
			return (_toAngle + _fromAngle) / 2f;
		}

		public void SetVisible(bool isVisible)
		{
			_isVisible = isVisible;
			_systemIcon.icon.transform.localScale = (isVisible ? Vector3.one : Vector3.zero);
			RefreshRedDotVisibleState();
		}

		public void RefreshRedDot(bool systemOpenDotActive)
		{
			if (!(_redDotItem == null))
			{
				RedDotType redDotType;
				if (_funcDefine != OpenFuncDefine.BattlePass)
				{
					redDotType = (systemOpenDotActive ? RedDotType.SystemNew : RedDotType.Dot);
				}
				else
				{
					redDotType = (systemOpenDotActive ? RedDotType.SystemNew : (Model<BattlePassModel>.Interface.NewRedDotExist ? RedDotType.New : RedDotType.Dot));
				}
				_redDotItem.ForbidDotShow = !_isVisible || IsCharacterEntryRedDotForbidden();
				_redDotItem.displayAction = (systemOpenDotActive ? ((RedDotDisplayAction)new CurSystemUnLockDotActive
				{
					isActive = true
				}) : ((RedDotDisplayAction)new SelfNodeActive()));
				_redDotItem.redDotType = redDotType;
				_redDotItem.BindTrieNode();
				_redDotItem.UpdateDisplay();
			}
		}

		private void RefreshRedDotVisibleState()
		{
			if (!(_redDotItem == null))
			{
				_redDotItem.ForbidDotShow = !_isVisible || IsCharacterEntryRedDotForbidden();
				_redDotItem.UpdateDisplay();
			}
		}

		public void SetRedDotVisible(bool shouldShow)
		{
			if (!(_redDotItem == null))
			{
				_redDotItem.ForbidDotShow = !_isVisible || !shouldShow;
				_redDotItem.UpdateDisplay();
			}
		}

		private bool IsCharacterEntryRedDotForbidden()
		{
			if (_funcDefine == OpenFuncDefine.Character && Model<BattleMainModel>.HasInstance())
			{
				if (Model<BattleMainModel>.Interface.hudType != HudType.TeamTeaching)
				{
					return Model<BattleMainModel>.Interface.hudType == HudType.characterTutorial;
				}
				return true;
			}
			return false;
		}
	}

	[Serializable]
	private class ExtraOption
	{
		[SerializeField]
		private OpenFuncDefine _funcDefine;

		[SerializeField]
		private GameObject _optionRoot;

		[SerializeField]
		private RedDotItem _redDotItem;

		private bool _isVisible;

		public bool isUnlock { get; set; }

		public OpenFuncDefine FuncDefine => _funcDefine;

		public void Init()
		{
			isUnlock = _funcDefine == OpenFuncDefine.CloseWheel || Singleton<SystemUnlockManager>.instance.IsUnlock((int)_funcDefine);
		}

		public void SetVisible(bool isVisible)
		{
			_isVisible = isVisible;
			_optionRoot.transform.localScale = (isVisible ? Vector3.one : Vector3.zero);
			RefreshRedDotVisibleState();
		}

		public void RefreshRedDot(bool systemOpenDotActive)
		{
			if (!(_redDotItem == null))
			{
				RedDotType redDotType;
				if (_funcDefine != OpenFuncDefine.BattlePass)
				{
					redDotType = (systemOpenDotActive ? RedDotType.SystemNew : RedDotType.Dot);
				}
				else
				{
					redDotType = (systemOpenDotActive ? RedDotType.SystemNew : (Model<BattlePassModel>.Interface.NewRedDotExist ? RedDotType.New : RedDotType.Dot));
				}
				_redDotItem.ForbidDotShow = !_isVisible;
				_redDotItem.displayAction = (systemOpenDotActive ? ((RedDotDisplayAction)new CurSystemUnLockDotActive
				{
					isActive = true
				}) : ((RedDotDisplayAction)new SelfNodeActive()));
				_redDotItem.redDotType = redDotType;
				_redDotItem.BindTrieNode();
				_redDotItem.UpdateDisplay();
			}
		}

		private void RefreshRedDotVisibleState()
		{
			if (!(_redDotItem == null))
			{
				_redDotItem.ForbidDotShow = !_isVisible;
				_redDotItem.UpdateDisplay();
			}
		}
	}

	[SerializeField]
	private BetterAnimation _animation;

	[SerializeField]
	private LocalizeStringEvent bntPromptTip;

	[SerializeField]
	private RectTransform mouseDeSelectArea;

	private const float RightStickThreshold = 0.5f;

	private const float MousePositionChangeThreshold = 1f;

	private const float StickDeadZone = 0.1f;

	private float mouseDeSelectAreaRadius;

	private Vector2 unSelectAreaCenter;

	private Dictionary<string, object> _promptTMPVariables;

	private const int WHEELPROMPTTXT = 2649;

	private static readonly OpenFuncDefine[] AllFuncDefines = (OpenFuncDefine[])Enum.GetValues(typeof(OpenFuncDefine));

	[SerializeField]
	private RectTransform selectorDir;

	[SerializeField]
	private RectTransform gamepadNode;

	[SerializeField]
	private RectTransform keyboardAndMouseNode;

	[SerializeField]
	private SelectionItem[] selectionItems;

	[SerializeField]
	private ExtraOption[] extraOptions;

	private SelectionItem _curSelectionItem;

	private bool _isGamepadMode;

	private bool _closeHideCursor;

	private bool _isClosing;

	private bool _isInitialized;

	private bool _hasRightStickInputSinceOpen;

	public void AddListener()
	{
	}

	public void RemoveListener()
	{
	}

	public void RefreshSystemEntryState(int systemId)
	{
		SelectionItem[] array = selectionItems;
		foreach (SelectionItem selectionItem in array)
		{
			if (selectionItem.FuncDefine == (OpenFuncDefine)systemId)
			{
				selectionItem.isUnlock = Singleton<SystemUnlockManager>.instance.IsUnlock(systemId);
				RefreshItemVisibleState(selectionItem, Model<BattleMainModel>.Interface.hudType != HudType.MainWorldType);
				break;
			}
		}
		ExtraOption[] array2 = extraOptions;
		foreach (ExtraOption extraOption in array2)
		{
			if (extraOption.FuncDefine == (OpenFuncDefine)systemId)
			{
				extraOption.isUnlock = Singleton<SystemUnlockManager>.instance.IsUnlock(systemId);
				RefreshExtraOptionVisibleState(extraOption, Model<BattleMainModel>.Interface.hudType != HudType.MainWorldType);
				break;
			}
		}
	}

	public void RefreshRedDot(int systemId, bool systemOpenDotActive)
	{
		SelectionItem[] array = selectionItems;
		foreach (SelectionItem selectionItem in array)
		{
			if (selectionItem.FuncDefine == (OpenFuncDefine)systemId)
			{
				selectionItem.RefreshRedDot(systemOpenDotActive);
				break;
			}
		}
		ExtraOption[] array2 = extraOptions;
		foreach (ExtraOption extraOption in array2)
		{
			if (extraOption.FuncDefine == (OpenFuncDefine)systemId)
			{
				extraOption.RefreshRedDot(systemOpenDotActive);
				break;
			}
		}
	}

	public void RefreshCharacterRedDotVisibility(bool shouldShow)
	{
		SelectionItem[] array = selectionItems;
		foreach (SelectionItem selectionItem in array)
		{
			if (selectionItem.FuncDefine == OpenFuncDefine.Character)
			{
				selectionItem.SetRedDotVisible(shouldShow);
				break;
			}
		}
	}

	public void Initialize()
	{
		bool inSubWorld = Model<BattleMainModel>.Interface.hudType != HudType.MainWorldType;
		for (int num = selectionItems.Length - 1; num >= 0; num--)
		{
			selectionItems[num].Init();
			RefreshItemVisibleState(selectionItems[num], inSubWorld);
		}
		for (int num2 = extraOptions.Length - 1; num2 >= 0; num2--)
		{
			extraOptions[num2].Init();
			RefreshExtraOptionVisibleState(extraOptions[num2], inSubWorld);
		}
		_promptTMPVariables = DictionaryPool<string, object>.Get();
		_isInitialized = true;
	}

	public void RefreshOpenState()
	{
		_isGamepadMode = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		UpdateMiddleNodeState(_isGamepadMode);
		if (!_isInitialized)
		{
			Initialize();
		}
		RefreshVisibleState();
	}

	public void RefreshVisibleState()
	{
		bool inSubWorld = Model<BattleMainModel>.Interface.hudType != HudType.MainWorldType;
		for (int num = selectionItems.Length - 1; num >= 0; num--)
		{
			RefreshItemVisibleState(selectionItems[num], inSubWorld);
		}
		for (int num2 = extraOptions.Length - 1; num2 >= 0; num2--)
		{
			RefreshExtraOptionVisibleState(extraOptions[num2], inSubWorld);
		}
	}

	private void UpdateMiddleNodeState(bool isGamePadMode)
	{
		keyboardAndMouseNode.localScale = (isGamePadMode ? Vector3.zero : Vector3.one);
		gamepadNode.localScale = (isGamePadMode ? Vector3.one : Vector3.zero);
	}

	private void Close()
	{
		Deselect();
		if (MonoECS.instance.IsGamePadMode())
		{
			_hasRightStickInputSinceOpen = false;
		}
		IBaseUIController topActivePanel = Singleton<NewUIManager>.instance.GetTopActivePanel();
		if (topActivePanel != null && topActivePanel.UIType == UI_TYPE.UI_BATTLEMAIN)
		{
			MonoBattleMainBaseView monoBattleMainBaseView = topActivePanel.GetUIView() as MonoBattleMainBaseView;
			if (monoBattleMainBaseView != null)
			{
				monoBattleMainBaseView.RefreshMenuListActive(MonoECS.instance.InputMode);
			}
		}
		_animation?.GetSequence("Hide").OnAnimationPlay((AnimationBuilder _) =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Disk_Close");
		}).OnComplete((AnimationBuilder _) =>
		{
			if (IsFocused)
			{
				FocusOut();
			}
			gameObject.SetActive(value: false);
		})
			.Play();
	}

	public void UnInitialize()
	{
		if (Singleton<GameInputActionManager>.HasInstance())
		{
			Singleton<GameInputActionManager>.instance.PointerCursor.ClearCursorVisibleOverride();
		}
		_isInitialized = false;
		DictionaryPool<string, object>.Release(_promptTMPVariables);
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		_isClosing = false;
		_hasRightStickInputSinceOpen = false;
		Deselect();
		_animation?.GetSequence("Show").OnAnimationPlay((AnimationBuilder _) =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Disk_Open");
		}).OnComplete((AnimationBuilder _) =>
		{
			unSelectAreaCenter = mouseDeSelectArea.rect.center;
			mouseDeSelectAreaRadius = mouseDeSelectArea.rect.size.x * 0.5f;
		})
			.Play();
	}

	private void Update()
	{
		if (!_isClosing && IsFocused)
		{
			if (!Singleton<GameInputActionManager>.instance.CheckActionIsPressed("UI/MenuDisc"))
			{
				HandleMenuDiscReleased();
			}
			else if (!_animation.CurrentAnimationPlaying() && !MonoECS.instance.IsGamePadMode())
			{
				UpdateMouseSelection();
			}
		}
	}

	private void OpenLastSelection()
	{
		if (_curSelectionItem != null && _curSelectionItem.isUnlock)
		{
			OpenFuncDefine funcDefine = _curSelectionItem?.FuncDefine ?? OpenFuncDefine.None;
			OpenFunc(funcDefine);
		}
	}

	public void OpenExtraOption(int index)
	{
		if (index >= 0 && index < extraOptions.Length && extraOptions[index].isUnlock)
		{
			OpenFunc(extraOptions[index].FuncDefine);
		}
	}

	public void ResetInputState()
	{
		_hasRightStickInputSinceOpen = false;
	}

	public void HandleMenuDiscReleased()
	{
		if (!_isClosing)
		{
			_isClosing = true;
			if (!MonoECS.instance.IsGamePadMode() && _curSelectionItem != null)
			{
				OpenLastSelection();
			}
			Close();
		}
	}

	public void HandleRightStickInput(Vector2 value)
	{
		if (!_isClosing)
		{
			if (!Singleton<GameInputActionManager>.instance.CheckActionIsPressed("UI/MenuDisc"))
			{
				HandleMenuDiscReleased();
			}
			else if (value.magnitude > 0.5f)
			{
				_hasRightStickInputSinceOpen = true;
				UpdateSelection(value);
			}
			else if (_hasRightStickInputSinceOpen && value.magnitude <= 0.1f && _curSelectionItem != null)
			{
				_isClosing = true;
				OpenLastSelection();
				Close();
			}
		}
	}

	private void OpenFunc(OpenFuncDefine funcDefine)
	{
		if (Model<BattleMainModel>.Interface.hudType != HudType.MainWorldType && !Model<BattleMainModel>.Interface.curSubWorldHudTypeOpenSystems.Contains((int)funcDefine))
		{
			return;
		}
		if (funcDefine <= OpenFuncDefine.Team)
		{
			if (funcDefine <= OpenFuncDefine.CloseWheel)
			{
				if (funcDefine != OpenFuncDefine.None)
				{
					_ = 999;
				}
				return;
			}
			switch (funcDefine)
			{
			case OpenFuncDefine.Team:
				if (MonoECS.instance.playState == PlayState.UnBattle || MonoECS.instance.IsInTrainingground)
				{
					Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TEAM, new TeamViewData
					{
						source = TeamProfileSource.World
					});
				}
				else
				{
					GameUtility.OpenToolTip(479);
				}
				break;
			case OpenFuncDefine.Bag:
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_BAGPANEL);
				break;
			case OpenFuncDefine.Summary:
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_HANDBOOK, new HandBookViewParam
				{
					H1TabIndex = -1
				});
				break;
			case OpenFuncDefine.CardPool:
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_CARDDRAW);
				break;
			case OpenFuncDefine.Task:
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_TASK);
				break;
			}
			return;
		}
		switch (funcDefine)
		{
		case OpenFuncDefine.Character:
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_CHARACTER);
			break;
		case OpenFuncDefine.ActivityCenter:
			if (Model<ActivityCenterModel>.Interface.GetOpeningActivitys().Count > 0)
			{
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_ACTIVITYCENTER);
			}
			break;
		case OpenFuncDefine.Message:
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_SNS);
			break;
		case OpenFuncDefine.BattlePass:
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_BATTLEPASS);
			break;
		case OpenFuncDefine.Map:
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_LARGEMAP);
			break;
		}
	}

	private void RefreshItemVisibleState(SelectionItem item, bool inSubWorld)
	{
		if (item.FuncDefine == OpenFuncDefine.CloseWheel)
		{
			item.SetVisible(isVisible: true);
		}
		else if (inSubWorld)
		{
			bool visible = item.isUnlock && Model<BattleMainModel>.Interface.curSubWorldHudTypeOpenSystems.Contains((int)item.FuncDefine);
			item.SetVisible(visible);
		}
		else if (!item.isUnlock)
		{
			item.SetVisible(isVisible: false);
		}
		else if (item.FuncDefine == OpenFuncDefine.ActivityCenter && Model<ActivityCenterModel>.HasInstance() && Model<ActivityCenterModel>.Interface.GetOpeningActivitys().Count <= 0)
		{
			item.SetVisible(isVisible: false);
		}
		else
		{
			item.SetVisible(isVisible: true);
		}
	}

	private void RefreshExtraOptionVisibleState(ExtraOption option, bool inSubWorld)
	{
		if (option.FuncDefine == OpenFuncDefine.CloseWheel)
		{
			option.SetVisible(isVisible: true);
		}
		else if (inSubWorld)
		{
			bool visible = option.isUnlock && Model<BattleMainModel>.Interface.curSubWorldHudTypeOpenSystems.Contains((int)option.FuncDefine);
			option.SetVisible(visible);
		}
		else if (!option.isUnlock)
		{
			option.SetVisible(isVisible: false);
		}
		else if (option.FuncDefine == OpenFuncDefine.ActivityCenter && Model<ActivityCenterModel>.HasInstance() && Model<ActivityCenterModel>.Interface.GetOpeningActivitys().Count <= 0)
		{
			option.SetVisible(isVisible: false);
		}
		else
		{
			option.SetVisible(isVisible: true);
		}
	}

	private void UpdateSelection(Vector2 inputDirection)
	{
		float dirAngle = Vector2.SignedAngle(Vector2.right, inputDirection);
		if (TryGetSelectionItemByAngle(dirAngle, out var item))
		{
			SetCurrentSelection(item);
		}
		else
		{
			ClearCurrentSelection();
		}
	}

	private void UpdateMouseSelection()
	{
		if (TryGetInputAngleDir(out var dirAngle))
		{
			if (TryGetSelectionItemByAngle(dirAngle, out var item))
			{
				SetCurrentSelection(item);
			}
			else
			{
				ClearCurrentSelection();
			}
		}
	}

	private void UpdateSelection()
	{
		if (TryGetInputAngleDir(out var dirAngle))
		{
			if (TryGetSelectionItemByAngle(dirAngle, out var item))
			{
				SetCurrentSelection(item);
			}
			else
			{
				ClearCurrentSelection();
			}
		}
	}

	private bool TryGetSelectionItemByAngle(float dirAngle, out SelectionItem item)
	{
		for (int num = selectionItems.Length - 1; num >= 0; num--)
		{
			item = selectionItems[num];
			if (item.ContainsAngle(dirAngle))
			{
				return true;
			}
		}
		item = null;
		return false;
	}

	private void SetCurrentSelection(SelectionItem item)
	{
		if (_curSelectionItem != item)
		{
			_curSelectionItem?.Deselect();
			item.Select();
			_curSelectionItem = item;
		}
		selectorDir.localScale = Vector3.one;
		selectorDir.rotation = Quaternion.Euler(0f, 0f, item.GetItemAngle() - 45f);
	}

	private void ClearCurrentSelection()
	{
		_curSelectionItem?.Deselect();
		_curSelectionItem = null;
		HideSelectorDir();
	}

	private void HideSelectorDir()
	{
		selectorDir.localScale = Vector3.zero;
		selectorDir.rotation = Quaternion.identity;
	}

	private void Deselect()
	{
		ClearCurrentSelection();
	}

	private bool TryGetInputAngleDir(out float dirAngle)
	{
		dirAngle = 0f;
		if (MonoECS.instance.IsGamePadMode())
		{
			Gamepad current = Gamepad.current;
			if (current == null)
			{
				return false;
			}
			Vector2 to = current.rightStick.ReadValue();
			if (!(to.magnitude > 0.5f))
			{
				return false;
			}
			_hasRightStickInputSinceOpen = true;
			dirAngle = Vector2.SignedAngle(Vector2.right, to);
			return true;
		}
		Mouse current2 = Mouse.current;
		if (current2 == null)
		{
			return false;
		}
		Vector2 vector = current2.position.ReadValue();
		if (CheckMouseEnterDeSelectArea())
		{
			ClearCurrentSelection();
			return false;
		}
		Vector2 b = current2.position.ReadValueFromPreviousFrame();
		if (!(Vector2.Distance(vector, b) > 1f))
		{
			return false;
		}
		Vector2 to2 = vector - new Vector2((float)Screen.width * 0.5f, (float)Screen.height * 0.5f);
		dirAngle = Vector2.SignedAngle(Vector2.right, to2);
		return true;
	}

	private bool CheckMouseEnterDeSelectArea()
	{
		if (RectTransformUtility.ScreenPointToLocalPointInRectangle(mouseDeSelectArea, Input.mousePosition, GameUtility.uiCamera, out var localPoint))
		{
			return localPoint.sqrMagnitude <= mouseDeSelectAreaRadius * mouseDeSelectAreaRadius;
		}
		return false;
	}

	protected override void OnFocusIn()
	{
		base.OnFocusIn();
		Singleton<GameInputActionManager>.instance.PointerCursor.SetCursorVisibleOverride(visible: true);
	}

	protected override void OnFocusOut()
	{
		base.OnFocusOut();
		Singleton<GameInputActionManager>.instance.PointerCursor.ClearCursorVisibleOverride();
	}

	public void UpdateGamePadTip()
	{
		bntPromptTip.StringReference.TableEntryReference = 0L;
		string bindingAction = "MenuDisc";
		if (MonoECS.instance.GetInputDeviceButtonBindingKeyName(bindingAction, out var bindingKeyName))
		{
			if (!string.IsNullOrEmpty(bindingKeyName))
			{
				bindingKeyName = bindingKeyName.Replace("/", "_");
				if (MonoECS.instance.GetPromptIconDevice() is DualShockGamepad)
				{
					bindingKeyName = bindingKeyName.Replace("gamepad", "gamepad_Sony");
				}
				_promptTMPVariables["0"] = bindingKeyName;
			}
			else if (LuminApplication.LogEnabled)
			{
				return;
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			return;
		}
		bntPromptTip.SetTable("Common");
		Model<GuideTipModel>.Interface.SetVariables(bntPromptTip, _promptTMPVariables);
		bntPromptTip.StringReference.TableEntryReference = 2649L;
	}

	public bool HasUnLockSystemEntries()
	{
		for (int i = 0; i < AllFuncDefines.Length; i++)
		{
			OpenFuncDefine openFuncDefine = AllFuncDefines[i];
			if (openFuncDefine != OpenFuncDefine.None && openFuncDefine != OpenFuncDefine.CloseWheel && Singleton<SystemUnlockManager>.instance.IsUnlock((int)openFuncDefine))
			{
				return true;
			}
		}
		return false;
	}

	public bool HasUnLockSystemEntries(List<int> systemIds)
	{
		if (systemIds == null || systemIds.Count <= 0)
		{
			return false;
		}
		for (int i = 0; i < AllFuncDefines.Length; i++)
		{
			OpenFuncDefine openFuncDefine = AllFuncDefines[i];
			if (openFuncDefine != OpenFuncDefine.None && openFuncDefine != OpenFuncDefine.CloseWheel)
			{
				int num = (int)openFuncDefine;
				if (systemIds.Contains(num) && Singleton<SystemUnlockManager>.instance.IsUnlock(num))
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool UnLockSystemHaveWheelEntry(int systemType)
	{
		return Enum.IsDefined(typeof(OpenFuncDefine), systemType);
	}
}
