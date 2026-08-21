using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataSkillBind : BuffDataBase
{
	public InputOptionEnum skillType;

	public int skillId;

	public int deriveSkillId;

	public float deriveTime;

	public bool restoreDeriveTime;

	public int deriveNumber;

	public bool isStateDriver;

	public bool isClose;

	public override BuffOperationType EffectType => BuffOperationType.SkillBind;

	protected override int paramsMinCount => 6;

	protected override void OnInit(List<string> paramList)
	{
		skillType = Utility.Convert.StringToEnum<InputOptionEnum>(paramList[0]);
		skillId = Utility.Convert.StringToInt(paramList[1]);
		deriveSkillId = Utility.Convert.StringToInt(paramList[2]);
		deriveTime = Utility.Convert.StringToFloat(paramList[3]);
		restoreDeriveTime = Utility.Convert.StringToBool(paramList[4]);
		deriveNumber = Utility.Convert.StringToInt(paramList[5]);
		if (paramList.Count > 6)
		{
			isStateDriver = Utility.Convert.StringToBool(paramList[6]);
		}
		if (paramList.Count > 7)
		{
			isClose = Utility.Convert.StringToBool(paramList[7]);
		}
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return string.Format("{0},{1},{2},{3},{4},{5}{6}", skillType, skillId, deriveSkillId, deriveTime, restoreDeriveTime, deriveNumber, isStateDriver ? ",TRUE" : string.Empty);
	}

	protected override void OnClear()
	{
		isStateDriver = false;
		isClose = false;
	}
}
