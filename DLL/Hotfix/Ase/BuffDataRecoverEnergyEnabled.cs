using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataRecoverEnergyEnabled : BuffDataBase
{
	public bool enabled;

	public override BuffOperationType EffectType => BuffOperationType.RecoverEnergyEnabled;

	protected override int paramsMinCount => 1;

	protected override void OnInit(List<string> paramList)
	{
		enabled = Utility.Convert.StringToBool(paramList[0]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{enabled}";
	}
}
