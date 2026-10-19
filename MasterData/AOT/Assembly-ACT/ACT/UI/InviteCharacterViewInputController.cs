using ACT.Battle;
using ACT.Model;
using Fundamental;
using Runtime.Model;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class InviteCharacterViewInputController : BaseUIViewInputController<UI_InviteCharacterView>
{
	public ContinuousNavigateData curNavigateState;

	protected override void OnDeactivate()
	{
		curNavigateState?.Reset();
		base.OnDeactivate();
	}

	[GameInputBindingBool("UI/UISpecial1")]
	private void OnGamepadInvite(bool value)
	{
		if (value && !(View == null))
		{
			View.TryInviteCharacterByGamepad();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null))
		{
			if (Model<InviteCharacterModel>.Interface.CurrSelectIndex < 0)
			{
				View.RefreshGamepadScrollSelection();
			}
			else
			{
				ContinuousNavigateUtility.StartContinuousNavigate(value, ref curNavigateState, ExecuteNavigate);
			}
		}
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		if (!(View == null))
		{
			switch (direction)
			{
			case MoveDirection.Up:
				View.MoveGamepadSelection(-1);
				break;
			case MoveDirection.Down:
				View.MoveGamepadSelection(1);
				break;
			}
		}
	}

	public void StopNavigation()
	{
		curNavigateState?.Reset();
	}

	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		if (Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_INVITECHARACTERCONFIRM) != UIState.Opened)
		{
			base.OnBackPressed(value);
		}
	}
}
