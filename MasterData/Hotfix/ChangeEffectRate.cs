using System.Collections.Generic;

[AdventureEffect(HotfixEnum.effectType.CHANGE_EFFECT_RATE)]
public class ChangeEffectRate : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		if (effectValueConfig.EffectTypeSecondSubtype != 3 || !TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out var intValue))
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			if (effectValueConfig.EffectTypeFirstSubtype == 2)
			{
				if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue2))
				{
					AdventureEffect effectById = _targets.get_Item(i).effectManage.GetEffectById(intValue2);
					if (effectById != null)
					{
						effectById.effectValueConfig.EffectRate += intValue;
					}
				}
			}
			else
			{
				List<AdventureEffect> effectByTag = _targets.get_Item(i).effectManage.GetEffectByTag(effectValueConfig.EffectTypeParam1);
				for (int j = 0; j < effectByTag.Count; j++)
				{
					effectByTag.get_Item(j).effectValueConfig.EffectRate += intValue;
				}
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		if (effectValueConfig.EffectTypeSecondSubtype != 3 || !TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out var intValue))
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			if (effectValueConfig.EffectTypeFirstSubtype == 2)
			{
				if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue2))
				{
					AdventureEffect effectById = _targets.get_Item(i).effectManage.GetEffectById(intValue2);
					if (effectById != null)
					{
						effectById.effectValueConfig.EffectRate -= intValue;
					}
				}
			}
			else
			{
				List<AdventureEffect> effectByTag = _targets.get_Item(i).effectManage.GetEffectByTag(effectValueConfig.EffectTypeParam1);
				for (int j = 0; j < effectByTag.Count; j++)
				{
					effectByTag.get_Item(j).effectValueConfig.EffectRate -= intValue;
				}
			}
		}
	}
}
