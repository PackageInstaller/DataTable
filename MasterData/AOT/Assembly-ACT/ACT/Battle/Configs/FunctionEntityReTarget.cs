namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取实体重新目标", "Function", new string[] { "entity", "re", "target", "owner", "caster" })]
public class FunctionEntityReTarget : ConfigFunction<EntityReference>
{
	public ReTargetType reTargetType;

	protected override EntityReference Evaluate(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData getAttackData)
		{
			switch (reTargetType)
			{
			case ReTargetType.Attacker:
				return getAttackData.GetAttackData().attacker;
			case ReTargetType.Attackee:
				return getAttackData.GetAttackData().attackee;
			}
		}
		else
		{
			if (memory.evt is EvtParrySuccess evtParrySuccess)
			{
				return evtParrySuccess.attacker;
			}
			if (memory.evt is EvtBattleChange evtBattleChange)
			{
				switch (reTargetType)
				{
				case ReTargetType.PreviousCharacter:
					return evtBattleChange.last;
				case ReTargetType.NextCharacter:
					return evtBattleChange.next;
				}
			}
			else if (memory.evt is BaseAddAbilityEvt baseAddAbilityEvt)
			{
				switch (reTargetType)
				{
				case ReTargetType.AddAbilityCaster:
					return baseAddAbilityEvt.casterEntity;
				case ReTargetType.AddAbilityOwner:
					return baseAddAbilityEvt.targetEntity;
				}
			}
		}
		_ = LuminApplication.LogEnabled;
		return default;
	}
}
