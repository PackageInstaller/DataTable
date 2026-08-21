using UnityEngine;

namespace Ase;

[Trigger("Timeline2怪物组事件触发器")]
public class Timeline2MonsterGroupEventTrigger : TimelineEventTrigger
{
	public MonsterGroup triggerMonsterGroup;

	public bool NotLoad;

	public override string TriggerName => "Timeline-怪物组事件触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if ((Object)(object)triggerMonsterGroup != null)
		{
			triggerMonsterGroup.ChangeAcitveState(state: true);
			if (!NotLoad)
			{
				triggerMonsterGroup.ReceiveMapDataEvent(LevelMapDataEvent.LoadNode);
			}
		}
	}
}
