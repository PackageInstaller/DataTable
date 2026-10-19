using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行ZeroThis伤害", "Action", new string[] { "zero", "this", "damage", "hit", "attack" })]
public class ActionZeroThisDamage : ConfigAction
{
	[HideInInspector]
	public bool isSuccess;

	public override void Do(ActionMemory memory)
	{
		isSuccess = false;
		if (memory.evt is EvtAttackeeModifyDamage && !isSuccess)
		{
			((EvtAttackeeModifyDamage)memory.evt).attackData.finalPhaseMul = 0f;
			isSuccess = true;
		}
		if (memory.evt is EvtSetActualDamage && !isSuccess)
		{
			EvtSetActualDamage evtSetActualDamage = (EvtSetActualDamage)memory.evt;
			evtSetActualDamage.attackData.finalPhaseMul = 0f;
			evtSetActualDamage.attackData.actualDamage = 0;
			isSuccess = true;
		}
	}
}
