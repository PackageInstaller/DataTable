using ACT.BluePrint;
using Unity.VisualScripting.Community;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行蓝图信号", "Action", new string[] { "bp", "signal", "event", "trigger" })]
public class ActionBPSignal : ConfigAction
{
	public IDefinedEvent bpEvent = new BPGlobalEvent(0);

	protected override AbilityAuth defaultAuth => AbilityAuth.Server;

	public override void Do(ActionMemory memory)
	{
		if (bpEvent != null)
		{
			GlobalDefinedEventNode.Trigger(bpEvent);
		}
	}
}
