using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataSkillConsume : BuffDataBase
{
	public InputOptionEnum skillType;

	public SkillCoolingType coolingType;

	public NumberType numberType;

	public ChangeType changeType;

	public float changeVal;

	public override BuffOperationType EffectType => BuffOperationType.SkillConsume;

	protected override int paramsMinCount => 5;

	protected override void OnInit(List<string> paramList)
	{
		skillType = Utility.Convert.StringToEnum<InputOptionEnum>(paramList[0]);
		coolingType = Utility.Convert.StringToEnum<SkillCoolingType>(paramList[1]);
		numberType = Utility.Convert.StringToEnum<NumberType>(paramList[2]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[3]);
		changeVal = Utility.Convert.StringToFloat(paramList[4]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{skillType},{coolingType},{numberType},{changeType},{changeVal}";
	}
}
