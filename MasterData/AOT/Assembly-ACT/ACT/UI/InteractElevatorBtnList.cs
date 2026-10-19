using System.Collections.Generic;
using ACT.Battle;
using ACT.Model;
using ACT.World.Asset;
using ACT.World.StateObject;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class InteractElevatorBtnList : MonoBehaviour
{
	[SerializeField]
	private ActToggleGroup _actToggleGroup;

	[SerializeField]
	private TextMeshProUGUI _CurrentlayerIndexText;

	[SerializeField]
	private LocalizeStringEvent _CurrentlayerIndexTextEvent;

	[SerializeField]
	private List<InteractElevatorBtn> _interactElevatorBtns = new List<InteractElevatorBtn>();

	private bool _hasExitPath;

	private int _lastTotalBtnCount;

	private int _interactSelectedIndex;

	internal List<InteractEntry> _entries;

	private void UpdateSelectIndex(int index)
	{
		List<InteractEntry> interactElevatorEntries = Model<InteractModel>.Interface.InteractElevatorEntries;
		for (int i = 0; i < interactElevatorEntries.Count; i++)
		{
			_interactElevatorBtns[i].Init(interactElevatorEntries[i], index);
		}
		if (_hasExitPath)
		{
			int count = interactElevatorEntries.Count;
			if (count < _interactElevatorBtns.Count)
			{
				_interactElevatorBtns[count].RefreshExitSelection(index);
			}
		}
	}

	private void UpdateElevatorActive(bool active)
	{
		SetElevatorActive(active);
	}

	private void RefreshElevatorButtonState(int changedLockSwid, int changedStateId)
	{
		if (Model<InteractModel>.Interface.ElevatorButtonsVisible)
		{
			List<InteractEntry> interactElevatorEntries = Model<InteractModel>.Interface.InteractElevatorEntries;
			int elevatorBtnSelectIndex = Model<InteractModel>.Interface.ElevatorBtnSelectIndex;
			for (int i = 0; i < interactElevatorEntries.Count && i < _interactElevatorBtns.Count; i++)
			{
				_interactElevatorBtns[i].RefreshUI(elevatorBtnSelectIndex, changedLockSwid, changedStateId);
			}
		}
	}

	private void SetupButtons()
	{
		UnregisterToggles();
		List<InteractEntry> interactElevatorEntries = Model<InteractModel>.Interface.InteractElevatorEntries;
		InteractStandardElevator elevator = Model<InteractModel>.Interface.CurrentElevator;
		StandardElevatorData elevatorData = Model<InteractModel>.Interface.elevatorData;
		int layerIndex = elevatorData.GetLayerIndex(elevatorData.stateId);
		int elevatorBtnSelectIndex = Model<InteractModel>.Interface.ElevatorBtnSelectIndex;
		_hasExitPath = elevator != null && elevator.HasExitPathForCurrentLayer();
		int count = interactElevatorEntries.Count;
		_lastTotalBtnCount = interactElevatorEntries.Count + (_hasExitPath ? 1 : 0);
		for (int i = 0; i < _interactElevatorBtns.Count; i++)
		{
			InteractElevatorBtn interactElevatorBtn = _interactElevatorBtns[i];
			if (i < interactElevatorEntries.Count)
			{
				interactElevatorBtn.gameObject.SetActive(value: true);
				interactElevatorBtn.Init(interactElevatorEntries[i], elevatorBtnSelectIndex);
			}
			else if (_hasExitPath && i == count)
			{
				interactElevatorBtn.gameObject.SetActive(value: true);
				interactElevatorBtn.InitAsExitButton(() =>
				{
					elevator.InteractExitPath();
				}, count, elevatorBtnSelectIndex);
			}
			else
			{
				interactElevatorBtn.gameObject.SetActive(value: false);
			}
		}
		for (int num = 0; num < _lastTotalBtnCount && num < _interactElevatorBtns.Count; num++)
		{
			_actToggleGroup.RegisterToggle(_interactElevatorBtns[num].Toggle);
		}
		_actToggleGroup.Init(layerIndex);
		_CurrentlayerIndexText.text = elevatorData.layers[layerIndex].layerID.ToString();
		UpdateSelectIndex(elevatorBtnSelectIndex);
	}

	private void UnregisterToggles()
	{
		for (int i = 0; i < _lastTotalBtnCount && i < _interactElevatorBtns.Count; i++)
		{
			_actToggleGroup.UnregisterToggle(_interactElevatorBtns[i].Toggle);
		}
		_lastTotalBtnCount = 0;
	}

	private void SetElevatorActive(bool value)
	{
		bool flag = value && Model<InteractModel>.Interface.ElevatorButtonsVisible;
		gameObject.SetActive(flag);
		if (flag && Model<InteractModel>.Interface.StayInElevator)
		{
			SetupButtons();
		}
		else
		{
			UnregisterToggles();
		}
	}

	private void Awake()
	{
		Init();
	}

	private void InteractAt(int index)
	{
		_actToggleGroup.SetToggleOn(index);
	}

	private void PlayPressed(int index)
	{
		_interactElevatorBtns[index].PlayPressed();
	}

	public void Init()
	{
		Model<InteractModel>.Interface.UpdateElevatorBtnSelectIndex += UpdateSelectIndex;
		Model<InteractModel>.Interface.UpdateElevatorBtnListActive += UpdateElevatorActive;
		Model<InteractModel>.Interface.RefreshElevatorButtonState += RefreshElevatorButtonState;
		Model<InteractModel>.Interface.ElevatorHandleMove += SetElevatorActive;
		MonoECS.instance.onInputModeChange.AddListener((DeviceInputMode _) =>
		{
			UpdateSelectIndex(Model<InteractModel>.Interface.ElevatorBtnSelectIndex);
		});
		UpdateElevatorActive(Model<InteractModel>.Interface.ElevatorButtonsVisible);
	}

	private void OnDestroy()
	{
		Model<InteractModel>.Interface.UpdateElevatorBtnSelectIndex -= UpdateSelectIndex;
		Model<InteractModel>.Interface.UpdateElevatorBtnListActive -= UpdateElevatorActive;
		Model<InteractModel>.Interface.RefreshElevatorButtonState -= RefreshElevatorButtonState;
		Model<InteractModel>.Interface.ElevatorHandleMove -= SetElevatorActive;
		MonoECS.instance.onInputModeChange.RemoveListener((DeviceInputMode _) =>
		{
			UpdateSelectIndex(Model<InteractModel>.Interface.ElevatorBtnSelectIndex);
		});
	}
}
