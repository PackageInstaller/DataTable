using ACT.Battle;
using ACT.Event;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class MineTrainOperateViewInputController : BaseUIViewInputController<MineTrainOperateBaseView>
{
	protected override void OnActivate()
	{
		base.OnActivate();
		GameManager.inputSystem.SetOverrideOperateEntity(View.GetControlledTarget());
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		GameManager.inputSystem.SetOverrideOperateEntity(default);
	}

	[GameInputBindingVector2("StateObject/StateObjectMove")]
	private void OnStateInputVec2(Vector2 inputVec2)
	{
		GamePlayerInput.GetCurrent().OnStateObjectMove(inputVec2);
	}

	[GameInputBindingBool("UI/Interact")]
	private void OnPlayerInteract(bool value)
	{
		if (value)
		{
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_ExitStateObjectControl, null);
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			ExitStateObjectControlEvt evt = Singleton<EventManager>.instance.GetEvt<ExitStateObjectControlEvt>();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_ExitStateObjectControl, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}
}
