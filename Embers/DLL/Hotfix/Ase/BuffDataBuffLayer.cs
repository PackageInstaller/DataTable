using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataBuffLayer : BuffDataBase
{
	public EntityTeamType teamType;

	public int buffId;

	public int buffLayer;

	public ChangeType changeType;

	public override BuffOperationType EffectType => BuffOperationType.BuffLayer;

	protected override int paramsMinCount => 4;

	protected override void OnInit(List<string> paramList)
	{
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[0]);
		buffId = Utility.Convert.StringToInt(paramList[1]);
		buffLayer = Utility.Convert.StringToInt(paramList[2]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[3]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{teamType},{buffId},{buffLayer},{changeType}";
	}
}
