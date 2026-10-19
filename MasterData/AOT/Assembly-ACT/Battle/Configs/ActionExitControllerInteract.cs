using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Event;
using Fundamental;

namespace Battle.Configs;

[AbilityTypeMetadata("执行ExitController交互", "Action", new string[] { "exit", "controller", "interact" })]
public class ActionExitControllerInteract : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (MonoECS.instance.PlayerControlType == MonoECS.ControlType.OreCar)
		{
			ExitStateObjectControlEvt evt = Singleton<EventManager>.instance.GetEvt<ExitStateObjectControlEvt>();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Input_ExitStateObjectControl, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}
}
