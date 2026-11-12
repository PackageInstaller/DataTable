using TrueSync;

public class DamageTypeAttriAssignment : AdventureEffectBase
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
		int effectTypeFirstSubtype = effectValueConfig.EffectTypeFirstSubtype;
		int effectTypeSecondSubtype = effectValueConfig.EffectTypeSecondSubtype;
		int key = CommonHelper.ConvertAttributeTypeAndElementOrDamageTypeToKey(effectTypeFirstSubtype, effectTypeSecondSubtype, isElementType: false, isBaseValue: false, isAssignValue: true);
		actor.actorInfo.AssignAttributeValueWithElementOrDamageType(key, val, isAssign);
	}
}
