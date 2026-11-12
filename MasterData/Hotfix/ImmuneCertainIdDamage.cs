[AdventureEffect(HotfixEnum.effectType.IMM_CERTAIN_HITDAMAGEID)]
public class ImmuneCertainIdDamage : AdventureEffectBase
{
	private int damageId;

	public override void Execute()
	{
		base.Execute();
		if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out damageId, allowEmpty: true))
		{
			for (int i = 0; i < _targets.Count; i++)
			{
				_targets.get_Item(i)?.AddImmuneCertainDamageId(damageId);
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets.get_Item(i)?.RemoveImmuneCertainDamageId(damageId);
		}
	}
}
