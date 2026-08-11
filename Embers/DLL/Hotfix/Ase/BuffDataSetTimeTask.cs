using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataSetTimeTask : BuffDataBase
{
	public bool isSuccess;

	public override BuffOperationType EffectType => BuffOperationType.BuffSetTeachTimeTask;

	protected override int paramsMinCount => 1;

	protected override void OnInit(List<string> paramList)
	{
		isSuccess = Utility.Convert.StringToBool(paramList[0]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{isSuccess}";
	}
}
