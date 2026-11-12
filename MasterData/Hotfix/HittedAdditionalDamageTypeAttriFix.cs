public class HittedAdditionalDamageTypeAttriFix : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		if (TryParseStringParamToFDP(effectValueConfig.EffectTypeParam1, out var floatValue))
		{
			AdventureActor.fromAdditionalAttrInfo.AddAttr((HotfixEnum.effectAttributeType)effectValueConfig.EffectTypeFirstSubtype, HotfixEnum.parameterType.BASE_VALUE, (int)(floatValue * 10000L).AsLong(), 1, HotfixEnum.elementType.NONE, (HotfixEnum.damageType)effectValueConfig.EffectTypeSecondSubtype, -1);
		}
	}
}
