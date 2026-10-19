using ACT.Event;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行突袭恢复", "Action", new string[] { "raid", "recovery" })]
public class ActionRaidRecovery : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RaidTrapRecovery, null);
	}
}
