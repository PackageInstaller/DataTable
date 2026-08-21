using UnityEngine;

namespace Ase;

[Trigger("怪物组触发器")]
public class MonsterTrigger : BaseTrigger
{
	public MonsterGroup monsterGroup;

	public bool NotLoad;

	public override string TriggerName => "怪物组触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if ((Object)(object)monsterGroup != null)
		{
			monsterGroup.ChangeAcitveState(state: true);
			if (!NotLoad)
			{
				monsterGroup.ReceiveMapDataEvent(LevelMapDataEvent.LoadNode);
			}
		}
	}
}
