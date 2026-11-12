[AdventureEffect(HotfixEnum.effectType.HITTED_ADDITIONAL_ATTR_FIX)]
public class HittedAdditionalAttriFix : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		if (TryParseStringParamToFDP(effectValueConfig.EffectTypeParam1, out var floatValue))
		{
			AdventureActor.fromAdditionalAttrInfo.attributeList.ChangeValue(effectValueConfig.EffectTypeFirstSubtype, effectValueConfig.EffectTypeSecondSubtype, floatValue);
		}
	}
}
