using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.Utility;
using ACT.World.Asset;
using ACT.World.StateObject;
using Fundamental;

namespace ACT.Model;

public class InteractModel : Model<InteractModel>
{
	private int _commonBtnSelectIndex;

	private int _elevatorBtnSelectIndex;

	public StandardElevatorData elevatorData;

	private List<InteractEntry> _interactElevatorEntries = new List<InteractEntry>();

	private readonly List<InteractEntry> _interactEntries = new List<InteractEntry>(4);

	private Comparison<InteractEntry> _buttonListComparison;

	private int _currentElevatorStateId;

	private int _commonInteractBtnCount;

	private CurInteractType _curInteractType;

	private bool _stayInElevator;

	private readonly Dictionary<StateObjectBase, int> _processingStateObjects = new Dictionary<StateObjectBase, int>();

	private Action<bool> _updateHintRoot;

	private Action<int> _updateInteractBtnSelectIndex;

	private Action _updateInteractBtnSelectIndexByPointUp;

	private Action<int> _updateElevatorBtnSelectIndex;

	private Action<bool> _updateElevatorBtnListActive;

	private Action<int, int> _refreshElevatorButtonState;

	private Action<InteractEntry> _addInteractBtnEntry;

	private Action<InteractEntry> _removeInteractBtnEntry;

	private Action<InteractEntry> _refreshInteractBtnEntry;

	private Action _handleInteractBtn;

	private Action<bool> _elevatorHandleMove;

	private Action _onSortChanged;

	public bool NeedShowSelected
	{
		get
		{
			DeviceInputMode? deviceInputMode = MonoECS.instance?.InputMode;
			if (!deviceInputMode.HasValue || deviceInputMode != DeviceInputMode.KeyboardAndMouse)
			{
				deviceInputMode = MonoECS.instance?.InputMode;
				if (deviceInputMode.HasValue)
				{
					return deviceInputMode == DeviceInputMode.Gamepad;
				}
				return false;
			}
			return true;
		}
	}

	public bool ElevatorRunningInSide { get; private set; }

	public int CommonBtnSelectIndex
	{
		get
		{
			return _commonBtnSelectIndex;
		}
		set
		{
			_commonBtnSelectIndex = value;
			_updateInteractBtnSelectIndex?.Invoke(value);
		}
	}

	public int ElevatorBtnSelectIndex
	{
		get
		{
			return _elevatorBtnSelectIndex;
		}
		set
		{
			_elevatorBtnSelectIndex = value;
			if (!IsMoving)
			{
				_updateElevatorBtnSelectIndex?.Invoke(value);
			}
		}
	}

	public InteractStandardElevator CurrentElevator { get; private set; }

	public bool ElevatorButtonsVisible { get; private set; }

	public List<InteractEntry> InteractElevatorEntries => _interactElevatorEntries;

	public List<InteractEntry> InteractEntries => _interactEntries;

	public int CommonInteractBtnCount
	{
		get
		{
			return _commonInteractBtnCount;
		}
		set
		{
			if (value < 0)
			{
				return;
			}
			if (_commonInteractBtnCount > 0 && value == 0)
			{
				if (ElevatorButtonsVisible)
				{
					if (CurInteractType == CurInteractType.Common)
					{
						CurInteractType = CurInteractType.Elevator;
					}
				}
				else
				{
					CurInteractType = CurInteractType.None;
				}
				_updateHintRoot?.Invoke(obj: false);
			}
			if (_commonInteractBtnCount == 0 && value > 0)
			{
				if (!ElevatorButtonsVisible)
				{
					CurInteractType = CurInteractType.Common;
				}
				else
				{
					CommonBtnSelectIndex = -1;
					_updateHintRoot?.Invoke(obj: true);
				}
			}
			if (value != 0 && value < _commonInteractBtnCount && CommonBtnSelectIndex == value && CurInteractType == CurInteractType.Common)
			{
				CommonBtnSelectIndex--;
			}
			_commonInteractBtnCount = value;
		}
	}

	public bool IsMoving { get; private set; }

	public CurInteractType CurInteractType
	{
		get
		{
			return _curInteractType;
		}
		set
		{
			if (_curInteractType != value)
			{
				switch (value)
				{
				case CurInteractType.Common:
					CommonBtnSelectIndex = 0;
					ElevatorBtnSelectIndex = -1;
					break;
				case CurInteractType.Elevator:
				{
					CommonBtnSelectIndex = -1;
					int layerIndex = elevatorData.GetLayerIndex(elevatorData.stateId);
					for (int i = 0; i < InteractElevatorEntries.Count; i++)
					{
						if (InteractElevatorEntries[i].EntryIndex != layerIndex && MonoECS.instance.ruleManager.SharedGetState(elevatorData.layers[InteractElevatorEntries[i].EntryIndex].lockFlag) != -1)
						{
							ElevatorBtnSelectIndex = InteractElevatorEntries[i].EntryIndex;
							break;
						}
					}
					break;
				}
				default:
					CommonBtnSelectIndex = -1;
					ElevatorBtnSelectIndex = -1;
					break;
				}
			}
			_curInteractType = value;
		}
	}

	public bool IsTabLongPress { get; private set; }

	public bool StayInElevator
	{
		get
		{
			return _stayInElevator;
		}
		set
		{
			if (_stayInElevator && !value)
			{
				CurInteractType = ((CommonInteractBtnCount > 0) ? CurInteractType.Common : CurInteractType.None);
				_updateHintRoot?.Invoke(obj: false);
			}
			if (!_stayInElevator & value)
			{
				if (CurInteractType == CurInteractType.Common)
				{
					ElevatorBtnSelectIndex = -1;
				}
				else if (CurInteractType == CurInteractType.None && ElevatorButtonsVisible)
				{
					CurInteractType = CurInteractType.Elevator;
				}
				_updateHintRoot?.Invoke(ElevatorButtonsVisible && CommonInteractBtnCount > 0);
			}
			_stayInElevator = value;
		}
	}

	public bool NeedShowHint
	{
		get
		{
			if (ElevatorButtonsVisible && CommonInteractBtnCount > 0)
			{
				return !IsMoving;
			}
			return false;
		}
	}

	public int ProcessingInteractCount => _processingStateObjects.Count;

	public event Action<bool> UpdateHintRoot
	{
		add
		{
			_updateHintRoot = (Action<bool>)Delegate.Combine(_updateHintRoot, value);
		}
		remove
		{
			_updateHintRoot = (Action<bool>)Delegate.Remove(_updateHintRoot, value);
		}
	}

	public event Action<int> UpdateInteractBtnSelectIndex
	{
		add
		{
			_updateInteractBtnSelectIndex = (Action<int>)Delegate.Combine(_updateInteractBtnSelectIndex, value);
		}
		remove
		{
			_updateInteractBtnSelectIndex = (Action<int>)Delegate.Remove(_updateInteractBtnSelectIndex, value);
		}
	}

	public event Action UpdateInteractBtnSelectIndexByPointUp
	{
		add
		{
			_updateInteractBtnSelectIndexByPointUp = (Action)Delegate.Combine(_updateInteractBtnSelectIndexByPointUp, value);
		}
		remove
		{
			_updateInteractBtnSelectIndexByPointUp = (Action)Delegate.Remove(_updateInteractBtnSelectIndexByPointUp, value);
		}
	}

	public event Action<int> UpdateElevatorBtnSelectIndex
	{
		add
		{
			_updateElevatorBtnSelectIndex = (Action<int>)Delegate.Combine(_updateElevatorBtnSelectIndex, value);
		}
		remove
		{
			_updateElevatorBtnSelectIndex = (Action<int>)Delegate.Remove(_updateElevatorBtnSelectIndex, value);
		}
	}

	public event Action<bool> UpdateElevatorBtnListActive
	{
		add
		{
			_updateElevatorBtnListActive = (Action<bool>)Delegate.Combine(_updateElevatorBtnListActive, value);
		}
		remove
		{
			_updateElevatorBtnListActive = (Action<bool>)Delegate.Remove(_updateElevatorBtnListActive, value);
		}
	}

	public event Action<int, int> RefreshElevatorButtonState
	{
		add
		{
			_refreshElevatorButtonState = (Action<int, int>)Delegate.Combine(_refreshElevatorButtonState, value);
		}
		remove
		{
			_refreshElevatorButtonState = (Action<int, int>)Delegate.Remove(_refreshElevatorButtonState, value);
		}
	}

	public event Action<InteractEntry> AddInteractBtnEntry
	{
		add
		{
			_addInteractBtnEntry = (Action<InteractEntry>)Delegate.Combine(_addInteractBtnEntry, value);
		}
		remove
		{
			_addInteractBtnEntry = (Action<InteractEntry>)Delegate.Remove(_addInteractBtnEntry, value);
		}
	}

	public event Action<InteractEntry> RemoveInteractBtnEntry
	{
		add
		{
			_removeInteractBtnEntry = (Action<InteractEntry>)Delegate.Combine(_removeInteractBtnEntry, value);
		}
		remove
		{
			_removeInteractBtnEntry = (Action<InteractEntry>)Delegate.Remove(_removeInteractBtnEntry, value);
		}
	}

	public event Action<InteractEntry> RefreshInteractBtnEntry
	{
		add
		{
			_refreshInteractBtnEntry = (Action<InteractEntry>)Delegate.Combine(_refreshInteractBtnEntry, value);
		}
		remove
		{
			_refreshInteractBtnEntry = (Action<InteractEntry>)Delegate.Remove(_refreshInteractBtnEntry, value);
		}
	}

	public event Action HandleInteractBtn
	{
		add
		{
			_handleInteractBtn = (Action)Delegate.Combine(_handleInteractBtn, value);
		}
		remove
		{
			_handleInteractBtn = (Action)Delegate.Remove(_handleInteractBtn, value);
		}
	}

	public event Action<bool> ElevatorHandleMove
	{
		add
		{
			_elevatorHandleMove = (Action<bool>)Delegate.Combine(_elevatorHandleMove, value);
		}
		remove
		{
			_elevatorHandleMove = (Action<bool>)Delegate.Remove(_elevatorHandleMove, value);
		}
	}

	public event Action OnSortChanged
	{
		add
		{
			_onSortChanged = (Action)Delegate.Combine(_onSortChanged, value);
		}
		remove
		{
			_onSortChanged = (Action)Delegate.Remove(_onSortChanged, value);
		}
	}

	public void AppendInteractTarget(StateObjectBase target)
	{
		if (_processingStateObjects.TryGetValue(target, out var value))
		{
			_processingStateObjects[target] = value + 1;
		}
		else
		{
			_processingStateObjects[target] = 1;
		}
	}

	public void RemoveInteractTarget(StateObjectBase target)
	{
		if (_processingStateObjects.TryGetValue(target, out var value))
		{
			if (value > 1)
			{
				_processingStateObjects[target] = value - 1;
			}
			else
			{
				_processingStateObjects.Remove(target);
			}
		}
	}

	protected override void Init()
	{
		_buttonListComparison = ButtonListSort;
		Singleton<GameManager>.instance.worldManager.RegisterOnChunkChangedCallback(OnChunkChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ServiceSave_Refresh, OnServiceStateRefresh);
	}

	public void SetRunningInSide(bool value)
	{
		ElevatorRunningInSide = value;
	}

	private void OnChunkChanged(int obj, int oldChunkId)
	{
		_processingStateObjects.Clear();
	}

	protected override void UnInit()
	{
		Singleton<GameManager>.instance.worldManager.RegisterOnChunkChangedCallback(OnChunkChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ServiceSave_Refresh, OnServiceStateRefresh);
		_processingStateObjects.Clear();
		_interactEntries.Clear();
		CommonInteractBtnCount = 0;
		ElevatorRunningInSide = false;
	}

	public void FixedUpdate()
	{
		for (int i = 0; i < _interactEntries.Count; i++)
		{
			_interactEntries[i].EvaluateConditions();
		}
		_interactEntries.Sort(_buttonListComparison);
		_onSortChanged?.Invoke();
	}

	public void UpdateSwitchInteractTypeByGamePad(bool value)
	{
		if (value && CurInteractType == CurInteractType.Elevator)
		{
			CurInteractType = CurInteractType.Common;
		}
		if (!value && ElevatorButtonsVisible && CurInteractType == CurInteractType.Common)
		{
			CurInteractType = CurInteractType.Elevator;
		}
	}

	public void UpdateSwitchInteractType()
	{
		if (CurInteractType == CurInteractType.Common && ElevatorButtonsVisible)
		{
			CurInteractType = CurInteractType.Elevator;
		}
		else if (CurInteractType == CurInteractType.Elevator)
		{
			CurInteractType = CurInteractType.Common;
		}
	}

	public void OnElevatorHandleMove(bool isMoving)
	{
		if (isMoving)
		{
			CurInteractType = ((CommonInteractBtnCount > 0) ? CurInteractType.Common : CurInteractType.None);
		}
		else if (CurInteractType != CurInteractType.Common && CurInteractType == CurInteractType.Elevator)
		{
			CommonBtnSelectIndex = -1;
			int layerIndex = elevatorData.GetLayerIndex(elevatorData.stateId);
			for (int i = 0; i < InteractElevatorEntries.Count; i++)
			{
				if (InteractElevatorEntries[i].EntryIndex != layerIndex && MonoECS.instance.ruleManager.SharedGetState(elevatorData.layers[InteractElevatorEntries[i].EntryIndex].lockFlag) != -1)
				{
					ElevatorBtnSelectIndex = InteractElevatorEntries[i].EntryIndex;
					break;
				}
			}
		}
		_elevatorHandleMove?.Invoke(!isMoving);
	}

	public void EnterExitElevator(bool enter, StandardElevatorData data, List<InteractEntry> entries, InteractStandardElevator elevator = null)
	{
		elevatorData = data;
		_interactElevatorEntries = entries;
		CurrentElevator = (enter ? elevator : null);
		StayInElevator = enter;
		if (!enter)
		{
			SetElevatorButtonsVisible(visible: false);
		}
	}

	public void SetElevatorButtonsVisible(bool visible)
	{
		ElevatorButtonsVisible = StayInElevator & visible;
		if (!ElevatorButtonsVisible && CurInteractType == CurInteractType.Elevator)
		{
			CurInteractType = ((CommonInteractBtnCount > 0) ? CurInteractType.Common : CurInteractType.None);
			_updateHintRoot?.Invoke(obj: false);
		}
		else if (ElevatorButtonsVisible && CurInteractType == CurInteractType.None)
		{
			CurInteractType = CurInteractType.Elevator;
			_updateHintRoot?.Invoke(CommonInteractBtnCount > 0);
		}
		_updateElevatorBtnListActive?.Invoke(ElevatorButtonsVisible);
	}

	private void OnServiceStateRefresh(BaseEventContent content)
	{
		if (!(content is ServiceStateRefresh serviceStateRefresh) || !ElevatorButtonsVisible || elevatorData == null)
		{
			return;
		}
		for (int i = 0; i < elevatorData.layers.Count; i++)
		{
			if (elevatorData.layers[i].lockFlag.value == serviceStateRefresh.swid)
			{
				RefreshElevatorButtonStateAfterLockChanged(serviceStateRefresh.swid, serviceStateRefresh.stateId);
				_refreshElevatorButtonState?.Invoke(serviceStateRefresh.swid, serviceStateRefresh.stateId);
				break;
			}
		}
	}

	private bool IsElevatorLayerUnlocked(int layerIndex, int changedLockSwid = int.MinValue, int changedStateId = 0)
	{
		if (elevatorData != null && 0 <= layerIndex && layerIndex < elevatorData.layers.Count)
		{
			return GetElevatorLayerLockState(layerIndex, changedLockSwid, changedStateId) != -1;
		}
		return false;
	}

	private int GetElevatorLayerLockState(int layerIndex, int changedLockSwid, int changedStateId)
	{
		StateWorldUid lockFlag = elevatorData.layers[layerIndex].lockFlag;
		if (lockFlag.value != changedLockSwid)
		{
			return MonoECS.instance.ruleManager.SharedGetState(lockFlag);
		}
		return changedStateId;
	}

	private void RefreshElevatorButtonStateAfterLockChanged(int changedLockSwid, int changedStateId)
	{
		if (CurInteractType != CurInteractType.Elevator || ElevatorBtnSelectIndex >= elevatorData.layers.Count || IsElevatorLayerUnlocked(ElevatorBtnSelectIndex, changedLockSwid, changedStateId))
		{
			return;
		}
		int layerIndex = elevatorData.GetLayerIndex(elevatorData.stateId);
		ElevatorBtnSelectIndex = -1;
		for (int i = 0; i < elevatorData.layers.Count; i++)
		{
			if (i != layerIndex && IsElevatorLayerUnlocked(i, changedLockSwid, changedStateId))
			{
				ElevatorBtnSelectIndex = i;
				break;
			}
		}
	}

	public void OnInteract()
	{
		if (CurInteractType == CurInteractType.Elevator && ElevatorButtonsVisible)
		{
			if (CurrentElevator != null && CurrentElevator.HasExitPathForCurrentLayer() && ElevatorBtnSelectIndex == elevatorData.layers.Count)
			{
				CurrentElevator.InteractExitPath();
			}
			else if (InteractElevatorEntries != null && ElevatorBtnSelectIndex >= 0 && ElevatorBtnSelectIndex < InteractElevatorEntries.Count)
			{
				InteractEntry interactEntry = InteractElevatorEntries[ElevatorBtnSelectIndex];
				if (IsElevatorLayerUnlocked(interactEntry.EntryIndex) && interactEntry.Interactable)
				{
					interactEntry.NetInteract();
				}
			}
		}
		else if (CurInteractType == CurInteractType.Common)
		{
			_handleInteractBtn?.Invoke();
		}
	}

	public void OnRefreshInteractBtnEntry(InteractEntry entry)
	{
		if (!(entry.Data is StandardElevatorData))
		{
			_refreshInteractBtnEntry?.Invoke(entry);
		}
	}

	public void OnAddInteractBtnEntry(InteractEntry entry)
	{
		if (!(entry.Data is StandardElevatorData))
		{
			CommonInteractBtnCount++;
			if (CommonInteractBtnCount < 4)
			{
				_interactEntries.Add(entry);
				_interactEntries.Sort(_buttonListComparison);
				_addInteractBtnEntry?.Invoke(entry);
			}
		}
	}

	private int ButtonListSort(InteractEntry interactEntry, InteractEntry entry)
	{
		Func<InteractEntry, InteractEntry, int>[] compareInteractEntry = SortUtility.CompareInteractEntry;
		for (int i = 0; i < compareInteractEntry.Length; i++)
		{
			int num = compareInteractEntry[i](interactEntry, entry);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	public void OnRemoveInteractBtnEntry(InteractEntry entry)
	{
		if (!(entry.Data is StandardElevatorData))
		{
			CommonInteractBtnCount--;
			_interactEntries.Remove(entry);
			_interactEntries.Sort(_buttonListComparison);
			_removeInteractBtnEntry?.Invoke(entry);
		}
	}

	public void UpdateBtnSelectIndexByManual(bool positive)
	{
		if (CurInteractType == CurInteractType.Common)
		{
			CommonBtnSelectIndex = (positive ? (CommonBtnSelectIndex + 1 + CommonInteractBtnCount) : (CommonBtnSelectIndex - 1 + CommonInteractBtnCount)) % CommonInteractBtnCount;
		}
		else
		{
			if (CurInteractType != CurInteractType.Elevator || IsMoving || !ElevatorButtonsVisible)
			{
				return;
			}
			bool flag = CurrentElevator != null && CurrentElevator.HasExitPathForCurrentLayer();
			int count = elevatorData.layers.Count;
			int num = elevatorData.layers.Count + (flag ? 1 : 0);
			int num2 = ElevatorBtnSelectIndex;
			int num3 = 0;
			while (num3 < num)
			{
				num2 = (positive ? (num2 + 1 + num) : (num2 - 1 + num)) % num;
				num3++;
				if (flag && num2 == count)
				{
					ElevatorBtnSelectIndex = num2;
					break;
				}
				if (num2 < elevatorData.layers.Count && num2 != elevatorData.GetLayerIndex(elevatorData.stateId) && MonoECS.instance.ruleManager.SharedGetState(elevatorData.layers[num2].lockFlag) != -1)
				{
					ElevatorBtnSelectIndex = num2;
					break;
				}
			}
		}
	}

	public void OnCommonBtnPointUp()
	{
		_updateInteractBtnSelectIndexByPointUp?.Invoke();
	}
}
