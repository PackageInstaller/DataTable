using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataFinishTeach : BuffDataBase
{
	public int teachGuideId;

	public override BuffOperationType EffectType => BuffOperationType.BuffFinsihTeach;

	protected override int paramsMinCount => 1;

	protected override void OnInit(List<string> paramList)
	{
		teachGuideId = Utility.Convert.StringToInt(paramList[0]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{teachGuideId}";
	}
}
