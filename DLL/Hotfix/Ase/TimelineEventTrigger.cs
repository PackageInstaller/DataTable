using UnityEngine;

namespace Ase;

public class TimelineEventTrigger : BaseEventTriggerNode
{
	public override string TriggerName => "Timeline事件触发器";

	public override void OnDisposed()
	{
	}

	protected override void UpdateEventTriggerName()
	{
		((Object)(object)this).name = (triggerInitSwitch ? "√" : "×") + " 事件触发器 - " + TriggerName + " - " + Desc;
	}
}
