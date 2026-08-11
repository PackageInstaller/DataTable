using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataCreateRuntimeBuff : BuffDataBase
{
	public DRBuff buffConfig;

	public BuffRuntimeEnum runtimeEnum;

	public int conditionIndex;

	public int createRuntimeBuffId;

	public int buffLayer;

	public float duration;

	public bool isCheakAddCondition;

	public override BuffOperationType EffectType => BuffOperationType.CreateRuntimeBuff;

	protected override int paramsMinCount => 6;

	protected override void OnInit(List<string> paramList)
	{
		runtimeEnum = Utility.Convert.StringToEnum<BuffRuntimeEnum>(paramList[0]);
		conditionIndex = Utility.Convert.StringToInt(paramList[1]);
		createRuntimeBuffId = Utility.Convert.StringToInt(paramList[2]);
		buffLayer = Utility.Convert.StringToInt(paramList[3]);
		duration = Utility.Convert.StringToFloat(paramList[4]);
		isCheakAddCondition = Utility.Convert.StringToBool(paramList[5]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{runtimeEnum},{conditionIndex},{createRuntimeBuffId},{buffLayer},{duration},{isCheakAddCondition}";
	}
}
