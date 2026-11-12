[AdventureEffect(HotfixEnum.effectType.ADDBUFF)]
public class AddBuffById : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		if (!TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue))
		{
			return;
		}
		int count = _targets.Count;
		for (int i = 0; i < count; i++)
		{
			if (_targets.get_Item(i) != null)
			{
				_targets.get_Item(i).GetLogicComponent<BuffCom>()?.AddBuff(intValue, _owner);
			}
		}
	}
}
