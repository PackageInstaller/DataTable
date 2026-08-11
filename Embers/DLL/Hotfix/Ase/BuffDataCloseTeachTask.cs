using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataCloseTeachTask : BuffDataBase
{
	public int teachTaskId;

	public override BuffOperationType EffectType => BuffOperationType.BuffCloseTeachTask;

	protected override int paramsMinCount => 1;

	protected override void OnInit(List<string> paramList)
	{
		teachTaskId = Utility.Convert.StringToInt(paramList[0]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{teachTaskId}";
	}
}
