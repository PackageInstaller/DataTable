using ACT.BluePrint;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断蓝图全局事件", "Predicate", new string[] { "bp", "global", "event", "predicate", "check", "condition", "trigger", "signal" })]
public class BpGlobalEventPredicate : ConfigPredicate
{
	public enum EventType
	{
		String,
		Integer
	}

	[SerializeField]
	private EventType eventType;

	[SerializeField]
	private string eventName;

	[SerializeField]
	private int eventId;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtBpGlobal evtBpGlobal)
		{
			if (eventType == EventType.String)
			{
				if (evtBpGlobal.eventData is BPGlobalStringEvent bPGlobalStringEvent)
				{
					return bPGlobalStringEvent.eventID == eventName;
				}
			}
			else if (eventType == EventType.Integer && evtBpGlobal.eventData is BPGlobalEvent bPGlobalEvent)
			{
				return bPGlobalEvent.eventID == eventId;
			}
		}
		return false;
	}
}
