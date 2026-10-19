using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class TeamViewInputController : BaseUIViewInputController<TeamView>
{
	private TeamViewSubControllerType _subControllerType;

	private ContinuousNavigateData _curNavigateData;

	private ViewControlRoot _viewControlRoot;

	protected override void OnInitView(TeamView view)
	{
		base.OnInitView(view);
		_subControllerType = TeamViewSubControllerType.Main;
		_viewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
	}

	public void SetTeamViewSubControllerType(TeamViewSubControllerType type)
	{
		_subControllerType = type;
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnSelectionNavigate(Vector2 value)
	{
		if (View != null)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value && !(View == null))
		{
			if (_subControllerType == TeamViewSubControllerType.Main)
			{
				View.OpenSelectedCharacterBagByGamePad();
			}
			else if (_subControllerType == TeamViewSubControllerType.BloodBottleBag)
			{
				View.BloodBottleBar.InvokeEquip();
			}
			else if (EventSystemHelper.CurrentSelected != null)
			{
				EventSystemHelper.ClickCurrent();
			}
			else
			{
				_viewControlRoot?.ReFocus();
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnSpecial1(bool value)
	{
		if (value && !(View == null))
		{
			View.HandleGamePadSpecial1(_subControllerType);
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnSpecial2(bool value)
	{
		if (value && !(View == null))
		{
			View.HandleGamePadSpecial2(_subControllerType);
		}
	}

	[GameInputBindingBool("UI/UISpecial3")]
	public void OnSpecial3(bool value)
	{
		if (value && !(View == null) && _subControllerType != TeamViewSubControllerType.CharacterBag && _subControllerType != TeamViewSubControllerType.BloodBottleBag)
		{
			View.OpenBloodBottleBagByGamePad();
		}
	}

	[GameInputBindingBool("UI/UISpecial4")]
	public void OnSpecial4(bool value)
	{
		if (value && !(View == null) && _subControllerType == TeamViewSubControllerType.Main)
		{
			View.OpenTeamBagByGamePad();
		}
	}

	[GameInputBindingBool("UI/UISpecial5")]
	public void OnSpecial5(bool value)
	{
		if (value && !(View == null))
		{
			View.HandleGamePadSpecial5(_subControllerType);
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void SwitchPageUp(bool value)
	{
		if (value && !(View == null) && _subControllerType == TeamViewSubControllerType.Main)
		{
			View.SelectPreviousTeamByGamePad();
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void SwitchPageDown(bool value)
	{
		if (value && !(View == null) && _subControllerType == TeamViewSubControllerType.Main)
		{
			View.SelectNextTeamByGamePad();
		}
	}

	[GameInputBindingBool("UI/Team")]
	private void OnBackTeamPressed(bool value)
	{
		if (!value && _subControllerType == TeamViewSubControllerType.Main)
		{
			View.CloseByGamePad();
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		if (_viewControlRoot == null)
		{
			_viewControlRoot = View?.GetComponentInChildren<ViewControlRoot>();
			if (_viewControlRoot == null)
			{
				return;
			}
		}
		EnsureCurrentFocusLayer();
		switch (dir)
		{
		case MoveDirection.Down:
			_viewControlRoot.SelectDown();
			break;
		case MoveDirection.Up:
			_viewControlRoot.SelectUp();
			break;
		}
		switch (dir)
		{
		case MoveDirection.Left:
			if (_subControllerType == TeamViewSubControllerType.Main)
			{
				View.SelectPreviousTeamCharacterByGamePad();
			}
			else
			{
				_viewControlRoot.SelectLeft();
			}
			break;
		case MoveDirection.Right:
			if (_subControllerType == TeamViewSubControllerType.Main)
			{
				View.SelectNextTeamCharacterByGamePad();
			}
			else
			{
				_viewControlRoot.SelectRight();
			}
			break;
		}
		if (_subControllerType == TeamViewSubControllerType.CharacterBag && EventSystemHelper.CurrentSelected != null)
		{
			EventSystemHelper.ClickCurrent();
		}
	}

	private void EnsureCurrentFocusLayer()
	{
		if (!(_viewControlRoot == null) && !(_viewControlRoot.CurrentFocusLayer != null))
		{
			(_subControllerType switch
			{
				TeamViewSubControllerType.CharacterBag => View.CharacterBagControlLayer, 
				TeamViewSubControllerType.BloodBottleBag => View.BloodBottleBagControlLayer, 
				TeamViewSubControllerType.TeamBag => View.TeamBagControlLayer, 
				_ => View.MainControlLayer, 
			})?.Focus();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (View.teamSelectSidebar.isNormal)
			{
				View.teamSelectSidebar.UnInit();
			}
			else if (View.CharacterSelectBar.IsNormal)
			{
				View.CharacterSelectBar.Close();
			}
			else if (View.BloodBottleBar.IsNormal)
			{
				View.BloodBottleBar.CloseBar();
			}
			else
			{
				View.OpenBlackLoadView();
			}
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}
}
