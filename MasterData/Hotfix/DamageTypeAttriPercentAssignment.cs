using TrueSync;

public class DamageTypeAttriPercentAssignment : AdventureEffectBase
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
			fDP = actor.actorInfo.GetAttributeValueWithElementOrDamageType((HotfixEnum.effectAttributeType)effectValueConfig.EffectTypeFirstSubtype, HotfixEnum.elementType.NONE, (HotfixEnum.damageType)effectValueConfig.EffectTypeSecondSubtype) * val;
		}
		int effectTypeFirstSubtype = effectValueConfig.EffectTypeFirstSubtype;
		int effectTypeSecondSubtype = effectValueConfig.EffectTypeSecondSubtype;
		int key = CommonHelper.ConvertAttributeTypeAndElementOrDamageTypeToKey(effectTypeFirstSubtype, effectTypeSecondSubtype, isElementType: false, isBaseValue: false, isAssignValue: true);
		actor.actorInfo.AssignAttributeValueWithElementOrDamageType(key, fDP, isAssign);
	}
}
