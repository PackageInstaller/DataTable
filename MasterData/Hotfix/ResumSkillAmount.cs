[AdventureEffect(HotfixEnum.effectType.RESUMSKILLAMOUNT)]
public class ResumSkillAmount : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets.get_Item(i).GetLogicComponent<PlayerSkillCd>()?.ResumeSectionAmountByEffect(effectValueConfig.EffectTypeParam1, effectValueConfig.EffectTypeParam2);
		}
	}
}
