using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionMark : BuffConditionBase
{
	private string markId;

	private int layer;

	private CompareMethodType methodType;

	public override BuffConditionType BuffConditionType => BuffConditionType.Mark;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		markId = paramList[0];
		layer = Utility.Convert.StringToInt(paramList[1]);
		methodType = Utility.Convert.StringToEnum<CompareMethodType>(paramList[2]);
	}

	protected override string OnGetDataString()
	{
		return $"{markId},{layer},{methodType}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		return CompareMarkValue();
	}

	private bool CompareMarkValue()
	{
		int v = 0;
		if (entityTarget.GetComponent<DataNodeComponent>() != null)
		{
			v = entityTarget.GetComponent<DataNodeComponent>().GetMarkLayer(markId);
		}
		return ConditionExtensions.CompareValueMethod(methodType, v, layer);
	}
}
