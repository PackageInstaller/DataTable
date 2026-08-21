using UnityEngine;

namespace Ase;

[Trigger("交互物2怪物组触发器")]
public class MapItem2MonsterGroupEventTrigger : MapItemEventTrigger
{
	public MonsterGroup triggerMonsterGroup;

	public bool IsActive;

	public override string TriggerName => "交互物-怪物组触发器";

	public override void OnDisposed()
	{
	}

	protected override void DoExecute()
	{
		base.DoExecute();
		if ((Object)(object)triggerMonsterGroup != null)
		{
			triggerMonsterGroup.ChangeAcitveState(state: true);
			if (!IsActive)
			{
				triggerMonsterGroup.ReceiveMapDataEvent(LevelMapDataEvent.LoadNode);
			}
		}
	}
}
