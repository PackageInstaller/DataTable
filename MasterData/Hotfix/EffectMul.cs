using System.Collections.Generic;

[AdventureEffect(HotfixEnum.effectType.EFFECT_MUL)]
public class EffectMul : AdventureEffectBase
{
	private readonly List<int> effList = new List<int>();

	private List<int> effectUniqueIdList = new List<int>();

	public override void InitParams()
	{
		base.InitParams();
		effList.Clear();
		if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam1, out var intValue, allowEmpty: true) && intValue > 0)
		{
			effList.Add(intValue);
		}
		if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out intValue, allowEmpty: true) && intValue > 0)
		{
			effList.Add(intValue);
		}
		if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam3, out intValue, allowEmpty: true) && intValue > 0)
		{
			effList.Add(intValue);
		}
		if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam4, out intValue, allowEmpty: true) && intValue > 0)
		{
			effList.Add(intValue);
		}
		if (TryParseStringParamToInt(effectValueConfig.EffectTypeParam5, out intValue, allowEmpty: true) && intValue > 0)
		{
			effList.Add(intValue);
		}
	}

	public override void Execute()
	{
		base.Execute();
		effectUniqueIdList.Clear();
		for (int i = 0; i < _targets.Count; i++)
		{
			effectUniqueIdList = _targets.get_Item(i).effectManage.AddEffectByBuff(effList, _owner);
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		for (int i = 0; i < _targets.Count; i++)
		{
			_targets.get_Item(i).effectManage.RemoveEffectByBuff(effectUniqueIdList);
		}
	}
}
