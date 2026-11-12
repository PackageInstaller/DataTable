[AdventureEffect(HotfixEnum.effectType.ADD_SHIELD)]
public class AddShield : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue))
		{
			for (int i = 0; i < _targets.Count; i++)
			{
				_targets.get_Item(i).actorShield?.AddShield(intValue, _owner);
			}
		}
	}
}
