using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataState : BuffDataBase
{
	public int stateId;

	public ChangeType changeType;

	public override BuffOperationType EffectType => BuffOperationType.State;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		stateId = Utility.Convert.StringToInt(paramList[0]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[1]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{stateId},{changeType}";
	}
}
