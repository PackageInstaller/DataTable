[AdventureEffect(HotfixEnum.effectType.SET_SKILL_LV)]
public class SkillLevelupTo : AdventureEffectBase
{
	protected int _cachedLevel;

	protected bool _efficient;

	public override void Execute()
	{
		base.Execute();
		if (!TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue) || !TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out var intValue2))
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			PlayerSkillCd logicComponent = _targets.get_Item(i).GetLogicComponent<PlayerSkillCd>();
			if (logicComponent != null)
			{
				(bool, int) tuple = logicComponent.SetSkillSlotBaseLevel((ActionKey)intValue2, intValue);
				if (tuple.Item1)
				{
					_efficient = true;
					_cachedLevel = tuple.Item2;
				}
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		if (!TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out var intValue))
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			if (_efficient)
			{
				_targets.get_Item(i).GetLogicComponent<PlayerSkillCd>()?.SetSkillSlotBaseLevel((ActionKey)intValue, _cachedLevel);
			}
		}
	}
}
