using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断生命值变化", "Predicate", new string[] { "check", "hp", "changed", "value", "float", "int", "predicate", "condition" })]
public class CheckHPChanged : ConfigPredicate
{
	public bool hpRecover;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is EvtHpChanged evtHpChanged)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"CheckHPChanged - evtHpChanged.preHp: {evtHpChanged.preHp}, evtHpChanged.curHp: {evtHpChanged.curHp}");
			}
			if (!hpRecover)
			{
				return evtHpChanged.curHp < evtHpChanged.preHp;
			}
			return evtHpChanged.curHp > evtHpChanged.preHp;
		}
		return false;
	}
}
