using ACT.Battle;
using ACT.Model;
using ACT.ViewControl;
using Fundamental;
using Runtime.Model;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class InviteCharacterWithMapViewInputController : BaseUIViewInputController<UI_InviteCharacterWithMapView>
{
	private ViewControlRoot m_ViewControlRoot;

	private ViewControlLayer m_ViewControlLayer;

	private ContinuousNavigateData curNavigateState;

	protected override void OnInitView(UI_InviteCharacterWithMapView view)
	{
		base.OnInitView(view);
		m_ViewControlRoot = view?.GetComponentInChildren<ViewControlRoot>();
		m_ViewControlLayer = view?.GetComponentInChildren<ViewControlLayer>();
	}

	protected override void OnDeactivate()
	{
		curNavigateState?.Reset();
		base.OnDeactivate();
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnGamepadConfirm(bool value)
	{
		if (value && !(View == null))
		{
			View.HandleGamepadConfirm();
		}
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
		View?.MoveGamepadSelection(direction);
	}

	[GameInputBindingBool("UI/Back")]
	protected override void OnBackPressed(bool value)
	{
		if (value && Singleton<NewUIManager>.instance.GetFirstUIState(UI_TYPE.UI_INVITECHARACTERCONFIRM) != UIState.Opened)
		{
			if (View != null && View.TryHandleGamepadBack())
			{
				curNavigateState?.Reset();
				return;
			}
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
			base.OnBackPressed(value: false);
		}
	}
}
