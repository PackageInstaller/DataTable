[AdventureEffect(HotfixEnum.effectType.CURRENTCD)]
public class CurrentSkillCDAmend : AdventureEffectBase
{
	public override void Execute()
	{
		bool flag = false;
		if (effectValueConfig.EffectTypeSecondSubtype == 1 || !TryParseStringParamToFP(effectValueConfig.EffectTypeParam1, out var fpValue))
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			PlayerSkillCd logicComponent = _targets.get_Item(i).GetLogicComponent<PlayerSkillCd>();
			if (logicComponent == null)
			{
				continue;
			}
			string actionKey = "";
			string skillId = "";
			switch (effectValueConfig.EffectTypeFirstSubtype)
			{
			case 1:
				actionKey = effectValueConfig.EffectTypeParam2;
				break;
			case 2:
				skillId = effectValueConfig.EffectTypeParam2;
				break;
			}
			switch (effectValueConfig.EffectTypeSecondSubtype)
			{
			case 3:
				if (logicComponent.ModifyResumeAbsByEffect(fpValue, actionKey, skillId))
				{
					flag = true;
				}
				break;
			case 2:
				if (logicComponent.ModifyResumeTimePercentByEffect(fpValue, actionKey, skillId))
				{
					flag = true;
				}
				break;
			}
		}
		if (flag)
		{
			base.Execute();
		}
	}
}
