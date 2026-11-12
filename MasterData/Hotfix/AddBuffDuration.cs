[AdventureEffect(HotfixEnum.effectType.ADD_BUFF_DURATION_EXISTING)]
public class AddBuffDuration : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		if (!TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out var intValue))
		{
			return;
		}
		int intValue2 = 0;
		int intValue3 = 0;
		string value = "";
		switch (effectValueConfig.EffectTypeFirstSubtype)
		{
		case 2:
			TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out intValue2);
			break;
		case 4:
			TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out intValue3);
			break;
		case 3:
			value = effectValueConfig.EffectTypeParam1;
			break;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			BuffCom logicComponent = _targets.get_Item(i).GetLogicComponent<BuffCom>();
			if (intValue2 != 0)
			{
				logicComponent?.AddBuffDurationByBuffID(intValue2, intValue);
			}
			else if (intValue3 != 0)
			{
				logicComponent?.AddBuffDurationByBuffGroupID(intValue3, intValue);
			}
			else if (!string.IsNullOrEmpty(value))
			{
				logicComponent?.AddBuffDurationByBuffTag(CommonHelper.StringToHash(value), intValue);
			}
		}
	}
}
