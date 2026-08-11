using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataSkillConsumeByTag : BuffDataBase
{
	public string tag;

	public bool isSel;

	public SkillCoolingType coolingType;

	public ChangeType changeType;

	public NumberType numberType;

	public float changeVal;

	public override BuffOperationType EffectType => BuffOperationType.SkillConsumeByTag;

	protected override int paramsMinCount => 6;

	protected override void OnInit(List<string> paramList)
	{
		tag = paramList[0];
		isSel = Utility.Convert.StringToBool(paramList[1]);
		coolingType = Utility.Convert.StringToEnum<SkillCoolingType>(paramList[2]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[3]);
		numberType = Utility.Convert.StringToEnum<NumberType>(paramList[4]);
		changeVal = Utility.Convert.StringToFloat(paramList[5]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{tag},{isSel},{coolingType},{changeType},{numberType},{changeVal}";
	}
}
