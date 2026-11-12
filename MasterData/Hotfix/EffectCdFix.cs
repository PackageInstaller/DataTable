using TrueSync;

[AdventureEffect(HotfixEnum.effectType.EFFECT_CD_FIX)]
public class EffectCdFix : AdventureEffectBase
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
					refreshEffect(effectById, intValue);
				}
				break;
			}
			case 3:
				foreach (AdventureEffect item in _targets.get_Item(i).effectManage.GetEffectByTag(effectValueConfig.EffectTypeParam1))
				{
					refreshEffect(item, intValue);
				}
				break;
			}
		}
	}

	private void refreshEffect(AdventureEffect eff, int value)
	{
		if (eff != null)
		{
			switch (effectValueConfig.EffectTypeSecondSubtype)
			{
			case 3:
				eff.CD -= (FP)value;
				break;
			case 2:
				eff.CD *= (FP)(1f - (float)value / 100f);
				break;
			}
		}
	}
}
