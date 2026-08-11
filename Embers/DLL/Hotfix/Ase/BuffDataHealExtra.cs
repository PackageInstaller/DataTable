using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataHealExtra : BuffDataBase
{
	public float healRatio;

	public float healFixAddition;

	public EntityTeamType teamType;

	public bool formula;

	public override BuffOperationType EffectType => BuffOperationType.HealExtra;

	protected override int paramsMinCount => 4;

	protected override void OnInit(List<string> paramList)
	{
		healRatio = Utility.Convert.StringToFloat(paramList[0]);
		healFixAddition = Utility.Convert.StringToFloat(paramList[1]);
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[2]);
		formula = Utility.Convert.StringToBool(paramList[3]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{healRatio},{healFixAddition},{teamType},{formula}";
	}
}
