using ACT.Battle;
using ACT.Model;
using ACT.UI.InputController;
using UnityEngine;

namespace ACT.UI;

public class AbyssListViewInputController : BaseUIViewInputController<MonoAbyssListView>
{
	private ContinuousNavigateData _curNavigateData;

	public AbyssListViewControllerType ControlType;

	private float lastPressTime;

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControlType == AbyssListViewControllerType.Main)
			{
				View.OnClose();
			}
			else if (ControlType == AbyssListViewControllerType.AbyssTeamCharacter || ControlType == AbyssListViewControllerType.AbyssTeamPreset)
			{
				View.CloseAbyssTeamPanel();
				View.ChangeAbyssListViewControl(AbyssListViewControllerType.Main, isRefocus: true);
			}
			else if (ControlType == AbyssListViewControllerType.MainReward)
			{
				View.ChangeAbyssListViewControl(AbyssListViewControllerType.Main, isRefocus: true);
			}
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		_curNavigateData?.Reset();
		View.OnControllerActivate();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			View.HandleConfirm();
		}
	}

	[GameInputBindingBool("LargeMapView/MapTemple")]
	public void ButtonWest(bool value)
	{
		if (value && (ControlType == AbyssListViewControllerType.AbyssTeamCharacter || ControlType == AbyssListViewControllerType.AbyssTeamPreset))
		{
			View._abyssTeamSubView.OpenCharacterDetailView();
		}
	}

	[GameInputBindingBool("UI/SearchSubmit")]
	public void ButtonNorth(bool value)
	{
		if (value)
		{
			if (ControlType == AbyssListViewControllerType.AbyssTeamCharacter || ControlType == AbyssListViewControllerType.AbyssTeamPreset)
			{
				View._abyssTeamSubView.OnClickGotoButtonHandle();
			}
			else if (ControlType == AbyssListViewControllerType.Main)
			{
				EventSystemHelper.Click(View._battleReport);
			}
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void SelectItemCell(bool value)
	{
		if (value && ControlType == AbyssListViewControllerType.Main)
		{
			View.ChangeAbyssListViewControl(AbyssListViewControllerType.MainReward);
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void RightStickPress(bool value)
	{
		if (value)
		{
			if (ControlType == AbyssListViewControllerType.Main)
			{
				View.OpenDetailView();
			}
			else if (ControlType == AbyssListViewControllerType.AbyssTeamCharacter || ControlType == AbyssListViewControllerType.AbyssTeamPreset)
			{
				View._abyssTeamSubView.OnClickDeleteButtonHandle();
			}
		}
	}

	[GameInputBindingBool("UI/LeftSwitchRole")]
	public void LeftShoulder(bool value)
	{
		if (value)
		{
			if (ControlType == AbyssListViewControllerType.AbyssTeamPreset)
			{
				View._abyssTeamSubView._characterTab.isOn = true;
				View.ChangeAbyssListViewControl(AbyssListViewControllerType.AbyssTeamCharacter);
			}
			else if (ControlType == AbyssListViewControllerType.Main)
			{
				View.ChangeMainTab(AbyssType.Fixed);
			}
		}
	}

	[GameInputBindingBool("UI/RightSwitchRole")]
	public void RightShoulder(bool value)
	{
		if (value)
		{
			if (ControlType == AbyssListViewControllerType.AbyssTeamCharacter)
			{
				View._abyssTeamSubView._presetTab.isOn = true;
				View.ChangeAbyssListViewControl(AbyssListViewControllerType.AbyssTeamPreset);
			}
			else if (ControlType == AbyssListViewControllerType.Main)
			{
				View.ChangeMainTab(AbyssType.Cycle);
			}
		}
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	public void LeftTrigger(bool value)
	{
		if (value && Time.unscaledTime - lastPressTime > 0.5f)
		{
			lastPressTime = Time.unscaledTime;
			if (ControlType == AbyssListViewControllerType.AbyssTeamCharacter || ControlType == AbyssListViewControllerType.AbyssTeamPreset)
			{
				View._abyssTeamSubView.LT();
			}
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	public void RightTrigger(bool value)
	{
		if (value && Time.unscaledTime - lastPressTime > 0.5f)
		{
			lastPressTime = Time.unscaledTime;
			if (ControlType == AbyssListViewControllerType.AbyssTeamCharacter || ControlType == AbyssListViewControllerType.AbyssTeamPreset)
			{
				View._abyssTeamSubView.RT();
			}
		}
	}

	[GameInputBindingBool("UI/View")]
	public void Select(bool value)
	{
		if (value && (ControlType == AbyssListViewControllerType.AbyssTeamCharacter || ControlType == AbyssListViewControllerType.AbyssTeamPreset))
		{
			View._abyssTeamSubView.Select();
		}
	}

	[GameInputBindingBool("UI/Start")]
	public void Start(bool value)
	{
		if (value && (ControlType == AbyssListViewControllerType.AbyssTeamCharacter || ControlType == AbyssListViewControllerType.AbyssTeamPreset))
		{
			View._abyssTeamSubView.OnStart();
		}
	}
}
