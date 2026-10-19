using System;
using ACT.Battle;
using ACT.Model;
using ACT.World.Asset;
using ACT.World.StateObject;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class InteractElevatorBtn : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IPointerClickHandler
{
	private const string Lock = "Locked";

	private InteractEntry _mInteractEntry;

	[SerializeField]
	private TextMeshProUGUI _layerIndexText;

	[SerializeField]
	private LocalizeStringEvent _layerIndexEvent;

	[SerializeField]
	private ActToggle _toggle;

	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private GameObject _pcSwitch;

	[SerializeField]
	private GameObject _gamePadSwitch;

	[SerializeField]
	private GameObject _interactPrompt;

	[SerializeField]
	private GameObject _exitIcon;

	private bool _isExitMode;

	private Action _exitAction;

	private int _exitEntryIndex;

	public ActToggle Toggle => _toggle;

	public void Init(InteractEntry entry, int selectedIndex)
	{
		_isExitMode = false;
		_mInteractEntry = entry;
		if (_exitIcon != null)
		{
			_exitIcon.SetActive(value: false);
		}
		if (_layerIndexText != null)
		{
			_layerIndexText.gameObject.SetActive(value: true);
		}
		RefreshUI(selectedIndex);
		_toggle.onToggleOn.RemoveAllListeners();
		_toggle.onToggleOn.AddListener(On);
	}

	public void InitAsExitButton(Action exitAction, int entryIndex, int selectedIndex)
	{
		_isExitMode = true;
		_exitAction = exitAction;
		_exitEntryIndex = entryIndex;
		_mInteractEntry = null;
		_toggle.Interactable(active: true);
		_toggle.isLock = false;
		_toggle.onToggleOn.RemoveAllListeners();
		_toggle.onToggleOn.AddListener(OnExitClick);
		if (_exitIcon != null)
		{
			_exitIcon.SetActive(value: true);
		}
		if (_layerIndexText != null)
		{
			_layerIndexText.gameObject.SetActive(value: false);
		}
		RefreshExitSelection(selectedIndex);
	}

	public void RefreshExitSelection(int selectedIndex)
	{
		if (_isExitMode)
		{
			bool flag = selectedIndex == _exitEntryIndex;
			_toggle.SetIsSelected(flag && Model<InteractModel>.Interface.NeedShowSelected);
			_toggle.Interactable(active: true);
			if (Model<InteractModel>.Interface.NeedShowSelected)
			{
				_betterAnimation.GetSequence(flag ? "Selected" : "Normal").Play();
			}
			else
			{
				_betterAnimation.GetSequence("Normal").Play();
			}
			InternalOnInputDeviceChange(MonoECS.instance.InputMode);
		}
	}

	private void OnExitClick()
	{
		if (_toggle.interactable)
		{
			_exitAction?.Invoke();
		}
	}

	public void Start()
	{
		MonoECS.instance.onInputModeChange.AddListener(InternalOnInputDeviceChange);
		InternalOnInputDeviceChange(MonoECS.instance.InputMode);
	}

	private void OnDestroy()
	{
		MonoECS.instance.onInputModeChange.RemoveListener(InternalOnInputDeviceChange);
	}

	private void InternalOnInputDeviceChange(DeviceInputMode type)
	{
		int elevatorBtnSelectIndex = Model<InteractModel>.Interface.ElevatorBtnSelectIndex;
		bool flag = (_isExitMode ? (elevatorBtnSelectIndex == _exitEntryIndex) : (elevatorBtnSelectIndex == _mInteractEntry.EntryIndex));
		_pcSwitch.SetActive((type == DeviceInputMode.KeyboardAndMouse) & flag);
		_gamePadSwitch.SetActive((type == DeviceInputMode.Gamepad) & flag);
		_interactPrompt.SetActive(flag && Model<InteractModel>.Interface.NeedShowSelected);
	}

	private void On()
	{
		if (_toggle.interactable && _mInteractEntry != null)
		{
			StandardElevatorData standardElevatorData = (StandardElevatorData)_mInteractEntry.Data;
			if (standardElevatorData.GetLayerIndex(standardElevatorData.stateId) != _mInteractEntry.EntryIndex)
			{
				_mInteractEntry.NetInteract();
			}
		}
	}

	public void PlayPressed()
	{
		_betterAnimation.GetSequence("Pressed").Play();
	}

	private void PlayLockAnimation()
	{
		_toggle.Interactable(active: false);
		_toggle.isLock = true;
		_betterAnimation.GetSequence("Locked").Play();
	}

	public void RefreshUI(int selectedIndex, int changedLockSwid = int.MinValue, int changedStateId = 0)
	{
		if (_isExitMode || _mInteractEntry == null)
		{
			return;
		}
		StandardElevatorData elevatorData = Model<InteractModel>.Interface.elevatorData;
		int layerIndex = elevatorData.GetLayerIndex(elevatorData.stateId);
		StateWorldUid lockFlag = elevatorData.layers[_mInteractEntry.EntryIndex].lockFlag;
		int num = ((lockFlag.value == changedLockSwid) ? changedStateId : MonoECS.instance.ruleManager.SharedGetState(lockFlag));
		bool flag = selectedIndex == _mInteractEntry.EntryIndex && Model<InteractModel>.Interface.NeedShowSelected;
		if (num == -1)
		{
			PlayLockAnimation();
		}
		else
		{
			_toggle.Interactable(layerIndex != _mInteractEntry.EntryIndex);
			_toggle.SetIsSelected(flag);
			_toggle.isLock = false;
			if (!_toggle.interactable)
			{
				_betterAnimation.GetSequence("Disabled").Play();
			}
			else if (Model<InteractModel>.Interface.NeedShowSelected)
			{
				_betterAnimation.GetSequence(flag ? "Selected" : "Normal").Play();
			}
			else
			{
				_betterAnimation.GetSequence("Normal").Play();
			}
		}
		_layerIndexText.text = elevatorData.layers[_mInteractEntry.EntryIndex].layerID.ToString();
		InternalOnInputDeviceChange(MonoECS.instance.InputMode);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
	}

	public void OnPointerUp(PointerEventData eventData)
	{
	}

	public void OnPointerClick(PointerEventData eventData)
	{
	}
}
