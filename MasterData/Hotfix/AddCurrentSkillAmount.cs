[AdventureEffect(HotfixEnum.effectType.ADDSKILLAMOUNT)]
public class AddCurrentSkillAmount : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue))
		{
			for (int i = 0; i < _targets.Count; i++)
			{
				_targets.get_Item(i).GetLogicComponent<PlayerSkillCd>()?.AddSectionAmountByEffect(intValue, effectValueConfig.EffectTypeParam2, effectValueConfig.EffectTypeParam3);
			}
		}
	}
}
