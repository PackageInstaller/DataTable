namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行ZeroDamageable伤害", "Action", new string[] { "zero", "damageable", "damage", "hit", "attack" })]
public class ActionZeroDamageableDamage : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		if (memory.evt is EvtAttackeeModifyDamage)
		{
			((EvtAttackeeModifyDamage)memory.evt).attackData.damage = 0f;
		}
	}
}
