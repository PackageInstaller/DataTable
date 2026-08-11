using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataSkillConsumeById : BuffDataBase
{
	public int skillId;

	public SkillCoolingType coolingType;

	public ChangeType changeType;

	public NumberType numberType;

	public float changeVal;

	public override BuffOperationType EffectType => BuffOperationType.SkillConsumeByTag;

	protected override int paramsMinCount => 5;

	protected override void OnInit(List<string> paramList)
	{
		skillId = Utility.Convert.StringToInt(paramList[0]);
		coolingType = Utility.Convert.StringToEnum<SkillCoolingType>(paramList[1]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[2]);
		numberType = Utility.Convert.StringToEnum<NumberType>(paramList[3]);
		changeVal = Utility.Convert.StringToFloat(paramList[4]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{skillId},{coolingType},{changeType},{numberType},{changeVal}";
	}
}
