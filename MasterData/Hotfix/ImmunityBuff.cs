[AdventureEffect(HotfixEnum.effectType.IMM_BUFF)]
public class ImmunityBuff : AdventureEffectBase
{
	private int buffId;

	private int buffGroupId;

	private int buffTag;

	public override void Execute()
	{
		base.Execute();
		switch (effectValueConfig.EffectTypeFirstSubtype)
		{
		case 2:
			TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out buffId);
			break;
		case 4:
			TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out buffGroupId);
			break;
		case 3:
			buffTag = CommonHelper.StringToHash(effectValueConfig.EffectTypeParam1);
			break;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets.get_Item(i).GetLogicComponent<BuffCom>()?.AddBuffImmunityTag(buffId, buffGroupId, buffTag);
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets.get_Item(i).GetLogicComponent<BuffCom>()?.RemoveBuffImmunityTag(buffId, buffGroupId, buffTag);
		}
	}
}
