using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataStateAbnormalTime : BuffDataBase
{
	public int stateId;

	public ChangeType changeType;

	public float time;

	public override BuffOperationType EffectType => BuffOperationType.StateAbnormalTime;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		stateId = Utility.Convert.StringToInt(paramList[0]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[1]);
		time = Utility.Convert.StringToFloat(paramList[2]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{stateId},{changeType},{time}";
	}
}
