using TrueSync;

public class ElementAttriPercentAssignment : AdventureEffectBase
{
	private FDP value;

	public override void Execute()
	{
		base.Execute();
		if (!TryParseStringParamToFDP(effectValueConfig.EffectTypeParam1, out value))
		{
			return;
		}
		foreach (AdventureActor target in _targets)
		{
			Process(target, value, isAssign: true);
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		foreach (AdventureActor target in _targets)
		{
			Process(target, -value, isAssign: false);
		}
	}

	private void Process(AdventureActor actor, FDP val, bool isAssign)
	{
		FDP fDP = val;
		if (isAssign)
		{
			fDP = actor.actorInfo.GetAttributeValueWithElementOrDamageType((HotfixEnum.effectAttributeType)effectValueConfig.EffectTypeFirstSubtype, (HotfixEnum.elementType)effectValueConfig.EffectTypeSecondSubtype, HotfixEnum.damageType.NONE) * val;
		}
		int effectTypeFirstSubtype = effectValueConfig.EffectTypeFirstSubtype;
		int effectTypeSecondSubtype = effectValueConfig.EffectTypeSecondSubtype;
		int key = CommonHelper.ConvertAttributeTypeAndElementOrDamageTypeToKey(effectTypeFirstSubtype, effectTypeSecondSubtype, isElementType: true, isBaseValue: false, isAssignValue: true);
		actor.actorInfo.AssignAttributeValueWithElementOrDamageType(key, fDP, isAssign);
	}
}
