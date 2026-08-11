using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataBuffDuration : BuffDataBase
{
	public EntityTeamType teamType;

	public int buffId;

	public float buffDuration;

	public ChangeType changeType;

	public override BuffOperationType EffectType => BuffOperationType.BuffDuration;

	protected override int paramsMinCount => 4;

	protected override void OnInit(List<string> paramList)
	{
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[0]);
		buffId = Utility.Convert.StringToInt(paramList[1]);
		buffDuration = Utility.Convert.StringToFloat(paramList[2]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[3]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{(int)teamType},{buffId},{buffDuration},{changeType}";
	}
}
