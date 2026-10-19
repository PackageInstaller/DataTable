using ACT.UI;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.Battle;

public class SettingsInputViewInputController : BaseUIViewInputController<MonoSettingsView>
{
	public enum OperationType
	{
		Submit,
		Cancel,
		PreTab,
		NextTab,
		PreTab1,
		NextTab1,
		SliderLeft,
		SliderRight,
		SliderLeftShift,
		SliderRightShift,
		Left,
		Right,
		Up,
		Down,
		SwitchDetail,
		ResetToDefault
	}

	private InputPanel m_InputPanel;

	private ViewControlRoot m_ViewControlRoot;

	private bool m_LeftSliderShiftPressing;

	private long m_LeftSliderShiftLastTriggerTime;

	private bool m_RightSliderShiftPressing;

	private long m_RightSliderShiftLastTriggerTime;

	private ContinuousNavigateData navData;

	private SettingCell currentCell;

	protected override void OnInitView(MonoSettingsView view)
	{
		base.OnInitView(view);
		m_ViewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
	}

	public void SetupInputPanel(InputPanel inputPanel)
	{
		m_InputPanel = inputPanel;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		m_ViewControlRoot.ReFocus();
	}

	public void Tick()
	{
		SliderOffset(m_LeftSliderShiftPressing, ref m_LeftSliderShiftLastTriggerTime, OperationType.SliderLeftShift);
		SliderOffset(m_RightSliderShiftPressing, ref m_RightSliderShiftLastTriggerTime, OperationType.SliderRightShift);
	}

	protected override void OnBackPressed(bool value)
	{
		if (!m_InputPanel.IsRebinding && !value)
		{
			TriggerEvent(OperationType.Cancel);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value)
		{
			TriggerEvent(OperationType.Submit);
		}
	}

	[GameInputBindingBool("Settings/SettingsBackHUD")]
	public void OnBackHUD(bool value)
	{
	}

	private void OnBackHUDLongPress()
	{
	}

	[GameInputBindingBool("Settings/SettingsSliderLeft")]
	public void OnSliderLeft(bool value)
	{
		if (value)
		{
			TriggerEvent(OperationType.SliderLeft);
		}
	}

	[GameInputBindingBool("Settings/SettingsSliderRight")]
	public void OnSliderRight(bool value)
	{
		if (value)
		{
			TriggerEvent(OperationType.SliderRight);
		}
	}

	private void SliderOffset(bool pressing, ref long lastTime, OperationType operationType)
	{
		if (pressing && TimeManager.GetTimeSpan(TimeManager.LocalTime.NowTimestamp - lastTime).TotalSeconds > 0.15)
		{
			lastTime = TimeManager.LocalTime.NowTimestamp;
			TriggerEvent(operationType);
		}
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	public void SwitchInputLeft(bool value)
	{
		if (value)
		{
			if (View.InputPanel.isActiveAndEnabled)
			{
				View.InputPanel.OnBtnPreTabClicked();
			}
			else if ((bool)currentCell && GetCellType() == SettingCellType.Switch)
			{
				currentCell.settingSwitch.LeftButton.OnClick.Invoke();
			}
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	public void SwitchInputRight(bool value)
	{
		if (value)
		{
			if (View.InputPanel.isActiveAndEnabled)
			{
				View.InputPanel.OnBtnNextTabClicked();
			}
			else if ((bool)currentCell && GetCellType() == SettingCellType.Switch)
			{
				currentCell.settingSwitch.RightButton.OnClick.Invoke();
			}
		}
	}

	[GameInputBindingBool("Settings/SettingsSliderLeftShift")]
	public void OnSliderLeftShift(bool value)
	{
		if (value)
		{
			TriggerEvent(OperationType.SliderLeftShift);
		}
	}

	[GameInputBindingBool("Settings/SettingsSliderRightShift")]
	public void OnSliderRightShift(bool value)
	{
		if (value)
		{
			TriggerEvent(OperationType.SliderRightShift);
		}
	}

	[GameInputBindingBool("Settings/SettingsPreTab")]
	public void OnPreTab(bool value)
	{
		if (value)
		{
			TriggerEvent(OperationType.PreTab);
		}
	}

	[GameInputBindingBool("Settings/SettingsNextTab")]
	public void OnNextTab(bool value)
	{
		if (value)
		{
			TriggerEvent(OperationType.NextTab);
		}
	}

	[GameInputBindingBool("Settings/PreTab1")]
	public void OnPreTab1(bool value)
	{
		if (value)
		{
			TriggerEvent(OperationType.PreTab1);
		}
	}

	[GameInputBindingBool("Settings/NextTab1")]
	public void OnNextTab1(bool value)
	{
		if (value)
		{
			TriggerEvent(OperationType.NextTab1);
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnSwitchDetail(bool value)
	{
		if (value)
		{
			TriggerEvent(OperationType.SwitchDetail);
		}
	}

	private SettingCellType GetCellType()
	{
		if (currentCell == null)
		{
			return SettingCellType.Button;
		}
		SettingCellType result = SettingCellType.Dropdown;
		foreach (SettingCellBindings binding in currentCell.bindings)
		{
			if (binding.enabled)
			{
				result = binding.type;
				break;
			}
		}
		return result;
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
	}

	[GameInputBindingBool("Settings/SettingsResetToDefault")]
	public void OnResetToDefault(bool value)
	{
		if (value)
		{
			TriggerEvent(OperationType.ResetToDefault);
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		navData?.Reset();
	}

	public void RebindBtnPrompt()
	{
		if ((object)currentCell == null)
		{
			View.ReBindBtnPrompt(false, false, "UI/Back", "UI/Confirm");
			return;
		}
		SettingCellType cellType = GetCellType();
		bool useDescription = currentCell.useDescription;
		bool descriptionShown = currentCell.DescriptionShown;
		switch (cellType)
		{
		case SettingCellType.Slider:
		case SettingCellType.IntSlider:
			View.ReBindBtnPrompt(useDescription, descriptionShown, "UI/Back", "Settings/SettingsSliderLeft", "Settings/SettingsSliderRight", "UI/RSLeftRightSelect");
			break;
		case SettingCellType.Dropdown:
			View.ReBindBtnPrompt(useDescription, descriptionShown, "UI/Confirm", "UI/Back");
			break;
		default:
			View.ReBindBtnPrompt(useDescription, descriptionShown, "UI/Back");
			break;
		}
	}

	public void FindCurrentCell()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			SetSwitchPrompt(value: false);
			currentCell = currentSelected.transform.GetComponentInChildren<SettingCell>();
			SetSwitchPrompt(value: true);
			RebindBtnPrompt();
		}
	}

	private void SetSwitchPrompt(bool value)
	{
		if ((bool)currentCell && GetCellType() == SettingCellType.Switch)
		{
			currentCell.settingSwitch.SetButtonPrompt(value);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			m_ViewControlRoot.SelectUp();
			break;
		case MoveDirection.Down:
			m_ViewControlRoot.SelectDown();
			break;
		case MoveDirection.Left:
			m_ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			m_ViewControlRoot.SelectRight();
			break;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
			FindCurrentCell();
		}
	}

	public void TriggerEvent(OperationType operationType, object userData = null)
	{
		if (operationType == OperationType.Submit)
		{
			EventSystemHelper.Click(EventSystemHelper.CurrentSelected);
		}
		if (View.UIOffSet.gameObject.activeInHierarchy)
		{
			int num2;
			int num;
			int num3;
			switch (operationType)
			{
			case OperationType.Cancel:
				View.UIOffSet.m_BtnCancel.OnClick.Invoke();
				return;
			case OperationType.SliderLeft:
				num2 = -1;
				goto IL_0079;
			case OperationType.SliderLeftShift:
				num2 = -10;
				goto IL_0079;
			case OperationType.SliderRight:
				num = 1;
				break;
			case OperationType.SliderRightShift:
				num = 10;
				break;
			default:
				return;
				IL_0079:
				num3 = num2;
				ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new AxisEventData(EventSystemHelper.Shared)
				{
					moveDir = MoveDirection.Left,
					moveVector = new Vector2(num3, 0f)
				}, (IMoveHandler handler, BaseEventData eventData) =>
				{
					if (handler is SettingCell)
					{
						handler.OnMove(eventData as AxisEventData);
					}
				});
				return;
			}
			int num4 = num;
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new AxisEventData(EventSystemHelper.Shared)
			{
				moveDir = MoveDirection.Right,
				moveVector = new Vector2(num4, 0f)
			}, (IMoveHandler handler, BaseEventData eventData) =>
			{
				if (handler is SettingCell)
				{
					handler.OnMove(eventData as AxisEventData);
				}
			});
		}
		else
		{
			if (View.modifyCustomSchemePanel.gameObject.activeInHierarchy)
			{
				return;
			}
			int num5;
			int num7;
			int num6;
			int num8;
			switch (operationType)
			{
			case OperationType.PreTab:
				View.PreTab();
				break;
			case OperationType.NextTab:
				View.NextTab();
				break;
			case OperationType.Cancel:
				if ((bool)EventSystemHelper.CurrentSelected)
				{
					bool canceled = false;
					ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), (ICancelHandler handler, BaseEventData eventData) =>
					{
						if (handler is SelectionUGUI selectionUGUI)
						{
							if (selectionUGUI.HasEvent<ICancelHandler>())
							{
								handler.OnCancel(eventData);
								canceled = true;
							}
						}
						else
						{
							handler.OnCancel(eventData);
							canceled = true;
						}
					});
					if (canceled)
					{
						break;
					}
				}
				View.Close();
				break;
			case OperationType.SliderLeft:
				num5 = -1;
				goto IL_01fe;
			case OperationType.SliderLeftShift:
				num5 = -10;
				goto IL_01fe;
			case OperationType.SliderRight:
				num7 = 1;
				goto IL_025b;
			case OperationType.SliderRightShift:
				num7 = 10;
				goto IL_025b;
			case OperationType.SwitchDetail:
				{
					SettingCell settingCell = currentCell;
					if ((object)settingCell != null && settingCell.useDescription)
					{
						currentCell?.optionDescriptionBtn?.OnClick.Invoke();
						RebindBtnPrompt();
					}
					break;
				}
				IL_01fe:
				num6 = num5;
				ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new AxisEventData(EventSystemHelper.Shared)
				{
					moveDir = MoveDirection.Left,
					moveVector = new Vector2(num6, 0f)
				}, (IMoveHandler handler, BaseEventData eventData) =>
				{
					handler.OnMove(eventData as AxisEventData);
				});
				break;
				IL_025b:
				num8 = num7;
				ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new AxisEventData(EventSystemHelper.Shared)
				{
					moveDir = MoveDirection.Right,
					moveVector = new Vector2(num8, 0f)
				}, (IMoveHandler handler, BaseEventData eventData) =>
				{
					handler.OnMove(eventData as AxisEventData);
				});
				break;
			}
			if (!m_InputPanel)
			{
				return;
			}
			switch (operationType)
			{
			case OperationType.PreTab1:
				EventSystemHelper.Click(m_InputPanel.BtnPreTab);
				break;
			case OperationType.NextTab1:
				EventSystemHelper.Click(m_InputPanel.BtnNextTab);
				break;
			case OperationType.ResetToDefault:
				switch (m_InputPanel.SelectedTabIndex)
				{
				case 0:
					EventSystemHelper.Click(m_InputPanel.PCTab.BtnResetToDefault);
					break;
				case 1:
					EventSystemHelper.Click(m_InputPanel.ControllerTab.BtnResetToDefault);
					break;
				}
				break;
			}
		}
	}
}
