[AdventureEffect(HotfixEnum.effectType.REMOVE_BUFF)]
public class RemoveBuff : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		int intValue = 0;
		int intValue2 = 0;
		string value = "";
		switch (effectValueConfig.EffectTypeFirstSubtype)
		{
		case 2:
			TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out intValue);
			break;
		case 4:
			TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out intValue2);
			break;
		case 3:
			value = effectValueConfig.EffectTypeParam1;
			break;
		}
		int num = 0;
		while (_targets != null && num < _targets.Count)
		{
			BuffCom logicComponent = _targets.get_Item(num).GetLogicComponent<BuffCom>();
			if (intValue != 0)
			{
				logicComponent?.RemoveBuffByBuffId(intValue);
			}
			else if (intValue2 != 0)
			{
				logicComponent?.RemoveBuffByGroupId(intValue2);
			}
			else if (!string.IsNullOrEmpty(value))
			{
				logicComponent?.RemoveBuffByTag(CommonHelper.StringToHash(value));
			}
			num++;
		}
	}
}
