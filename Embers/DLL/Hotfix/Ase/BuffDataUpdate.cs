using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataUpdate : BuffDataBase
{
	public EntityTeamType teamType;

	public int buffID;

	public int count;

	public override BuffOperationType EffectType => BuffOperationType.BuffUpdate;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[0]);
		buffID = Utility.Convert.StringToInt(paramList[1]);
		count = Utility.Convert.StringToInt(paramList[2]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{teamType},{buffID},{count}";
	}
}
