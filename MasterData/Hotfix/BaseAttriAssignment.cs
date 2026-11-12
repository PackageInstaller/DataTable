using TrueSync;

[AdventureEffect(HotfixEnum.effectType.ATTR_ASSIGNMENT)]
public class BaseAttriAssignment : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		if (TryParseStringParamToFDP(effectValueConfig.EffectTypeParam1, out var floatValue))
		{
			for (int i = 0; i < _targets.Count; i++)
			{
				Process(_targets.get_Item(i), floatValue, assign: true);
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		for (int i = 0; i < _targets.Count; i++)
		{
			Process(_targets.get_Item(i), FDP.Zero, assign: false);
		}
	}

	private void Process(AdventureActor actor, FDP val, bool assign)
	{
		if (effectValueConfig.EffectTypeFirstSubtype != 0 && !(actor == null) && actor.attributeList != null)
		{
			actor.attributeList.ChangeAssignmentValue(effectValueConfig.EffectTypeFirstSubtype, effectValueConfig.EffectTypeSecondSubtype, val, assign);
		}
	}
}
