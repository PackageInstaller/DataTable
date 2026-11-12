using TrueSync;

[AdventureEffect(HotfixEnum.effectType.AMMO_FIX)]
public class AmmoFix : AdventureEffectBase
{
	private FP value;

	public override void Execute()
	{
		base.Execute();
		if (effectValueConfig.EffectTypeFirstSubtype != 3 && TryParseStringParamToFP(effectValueConfig.EffectTypeParam1, out value))
		{
			for (int i = 0; i < _targets.Count; i++)
			{
				_targets.get_Item(i).GetLogicComponent<AmmoInfo>()?.ChangeValue((HotfixEnum.AmmoType)effectValueConfig.EffectTypeFirstSubtype, (HotfixEnum.ammoParameterType)effectValueConfig.EffectTypeSecondSubtype, value);
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		if (effectValueConfig.EffectTypeFirstSubtype != 3)
		{
			for (int i = 0; i < _targets.Count; i++)
			{
				_targets.get_Item(i).GetLogicComponent<AmmoInfo>()?.ChangeValue((HotfixEnum.AmmoType)effectValueConfig.EffectTypeFirstSubtype, (HotfixEnum.ammoParameterType)effectValueConfig.EffectTypeSecondSubtype, -value);
			}
		}
	}
}
