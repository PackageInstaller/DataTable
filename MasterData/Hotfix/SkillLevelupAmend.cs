[AdventureEffect(HotfixEnum.effectType.ADD_SKILL_LV)]
public class SkillLevelupAmend : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue) && TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out var intValue2))
		{
			for (int i = 0; i < _targets.Count; i++)
			{
				_targets.get_Item(i).GetLogicComponent<PlayerSkillCd>()?.AddSkillSlotLevel((ActionKey)intValue2, intValue);
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue) && TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out var intValue2))
		{
			for (int i = 0; i < _targets.Count; i++)
			{
				_targets.get_Item(i).GetLogicComponent<PlayerSkillCd>()?.AddSkillSlotLevel((ActionKey)intValue2, -intValue);
			}
		}
	}
}
