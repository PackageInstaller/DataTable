using TrueSync;

public class ElementAttriFix : AdventureEffectBase
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
			Process(target, value);
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		foreach (AdventureActor target in _targets)
		{
			Process(target, -value);
		}
	}

	private void Process(AdventureActor actor, FDP val)
	{
		int effectTypeFirstSubtype = effectValueConfig.EffectTypeFirstSubtype;
		int effectTypeSecondSubtype = effectValueConfig.EffectTypeSecondSubtype;
		int key = CommonHelper.ConvertAttributeTypeAndElementOrDamageTypeToKey(effectTypeFirstSubtype, effectTypeSecondSubtype, isElementType: true, isBaseValue: true, isAssignValue: false);
		actor.actorInfo.ChangeAttributeValueWithElementOrDamageType(key, val);
	}
}
