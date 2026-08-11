using UnityEngine;

namespace Ase;

[Trigger("怪物组2怪物组触发器")]
public class MonsterGroupEvent2MonsterGroupEventTrigger : MonsterGroupEventTrigger
{
	public MonsterGroup triggerMonsterGroup;

	public bool NotLoad;

	public override string TriggerName => "怪物组-怪物组触发器";

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
