using TrueSync;

[AdventureEffect(HotfixEnum.effectType.EFFECT_MAX_CD_FIX)]
public class EffectMaxCdFix : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		if (effectValueConfig.EffectTypeSecondSubtype == 1 || !TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out var intValue))
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			if (_targets.get_Item(i).actorInfo == null)
			{
				continue;
			}
			switch (effectValueConfig.EffectTypeFirstSubtype)
			{
			case 2:
			{
				if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue2))
				{
					AdventureEffect effectById = _targets.get_Item(i).effectManage.GetEffectById(intValue2);
					refreshEffect(effectById, isAdd: true, intValue);
				}
				break;
			}
			case 3:
				foreach (AdventureEffect item in _targets.get_Item(i).effectManage.GetEffectByTag(effectValueConfig.EffectTypeParam1))
				{
					refreshEffect(item, isAdd: true, intValue);
				}
				break;
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		if (effectValueConfig.EffectTypeSecondSubtype == 1 || !TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out var intValue))
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			if (_targets.get_Item(i).actorInfo == null)
			{
				continue;
			}
			if (effectValueConfig.EffectTypeFirstSubtype == 2)
			{
				if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue2))
				{
					AdventureEffect effectById = _targets.get_Item(i).effectManage.GetEffectById(intValue2);
					refreshEffect(effectById, isAdd: false, intValue);
				}
			}
			else
			{
				if (effectValueConfig.EffectTypeFirstSubtype != 3)
				{
					continue;
				}
				foreach (AdventureEffect item in _targets.get_Item(i).effectManage.GetEffectByTag(effectValueConfig.EffectTypeParam1))
				{
					refreshEffect(item, isAdd: false, intValue);
				}
			}
		}
	}

	private void refreshEffect(AdventureEffect eff, bool isAdd, int attrValue)
	{
		int num = (isAdd ? attrValue : (-attrValue));
		if (eff != null)
		{
			if (effectValueConfig.EffectTypeSecondSubtype == 3)
			{
				eff.MaxCD -= (FP)num;
			}
			else if (effectValueConfig.EffectTypeSecondSubtype == 2)
			{
				eff.MaxCD -= eff.OrginMaxCd * num / 100f;
			}
			eff.CD = TSMath.Min(eff.MaxCD, eff.CD);
		}
	}
}
