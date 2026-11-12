using TrueSync;

[AdventureEffect(HotfixEnum.effectType.DROP_ITEM_PICKUP_RANGE_FIX)]
public class DropItemPickupRangeFix : AdventureEffectBase
{
	private FP value;

	public override void Execute()
	{
		base.Execute();
		if (TryParseStringParamToFP(effectValueConfig.EffectTypeParam1, out value))
		{
			SceneSingleton<DropsManager>.Instance.SetAdsorptionChangeValue((HotfixEnum.dropEntityType)effectValueConfig.EffectTypeFirstSubtype, value);
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		SceneSingleton<DropsManager>.Instance.SetAdsorptionChangeValue((HotfixEnum.dropEntityType)effectValueConfig.EffectTypeFirstSubtype, -value);
	}
}
