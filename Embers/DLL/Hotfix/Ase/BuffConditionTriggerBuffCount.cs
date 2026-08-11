using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class BuffConditionTriggerBuffCount : BuffConditionBase
{
	private CompareMethodType compare;

	private int count;

	public override BuffConditionType BuffConditionType => BuffConditionType.BuffConditionTriggerBuffCount;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		compare = Utility.Convert.StringToEnum<CompareMethodType>(paramList[0]);
		count = Utility.Convert.StringToInt(paramList[1]);
	}

	protected override string OnGetDataString()
	{
		return $"{compare},{count}";
	}

	public static BuffConditionTriggerBuffCount Create(CompareMethodType compare, int count)
	{
		BuffConditionTriggerBuffCount buffConditionTriggerBuffCount = ReferencePool.Acquire<BuffConditionTriggerBuffCount>();
		buffConditionTriggerBuffCount.compare = compare;
		buffConditionTriggerBuffCount.count = count;
		return buffConditionTriggerBuffCount;
	}

	public override bool OnCheck(Buff buff = null)
	{
		if (buff == null)
		{
			return false;
		}
		return ConditionExtensions.CompareValueMethod(compare, buff.GetTriggerCount(), count);
	}
}
