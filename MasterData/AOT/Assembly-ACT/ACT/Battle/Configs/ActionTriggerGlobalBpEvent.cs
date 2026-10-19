using ACT.BluePrint;
using Unity.VisualScripting.Community;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("触发全局蓝图事件", "Action", new string[] { "trigger", "global", "bp", "event", "signal" })]
public class ActionTriggerGlobalBpEvent : ConfigAction
{
	[SerializeReference]
	private string _eventID;

	public override void Do(ActionMemory memory)
	{
		GlobalDefinedEventNode.Trigger(new BPGlobalStringEvent(_eventID));
	}
}
