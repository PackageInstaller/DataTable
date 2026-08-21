using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataMark : BuffDataBase
{
	public string markId;

	public int layer;

	public float duration;

	public override BuffOperationType EffectType => BuffOperationType.Mark;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		markId = paramList[0];
		layer = Utility.Convert.StringToInt(paramList[1]);
		duration = Utility.Convert.StringToFloat(paramList[2]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{markId},{layer},{duration}";
	}
}
