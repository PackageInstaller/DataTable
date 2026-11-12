public class HittedAdditionalElementTypeAttriPercentFix : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		if (TryParseStringParamToFDP(effectValueConfig.EffectTypeParam1, out var floatValue))
		{
			AdventureActor.fromAdditionalAttrInfo.AddAttr((HotfixEnum.effectAttributeType)effectValueConfig.EffectTypeFirstSubtype, HotfixEnum.parameterType.PERCENTAGE, (int)(floatValue * 10000L).AsLong(), 1, (HotfixEnum.elementType)effectValueConfig.EffectTypeSecondSubtype, HotfixEnum.damageType.NONE, -1);
		}
	}
}
