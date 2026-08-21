using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataSkillCooling : BuffDataBase
{
	public int skillId;

	public PropertyType propertyType;

	public ChangeType changeType;

	public float value;

	public override BuffOperationType EffectType => BuffOperationType.SkillCooling;

	protected override int paramsMinCount => 4;

	protected override void OnInit(List<string> paramList)
	{
		skillId = Utility.Convert.StringToInt(paramList[0]);
		propertyType = Utility.Convert.StringToEnum<PropertyType>(paramList[1]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[2]);
		value = Utility.Convert.StringToFloat(paramList[3]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{skillId},{propertyType},{changeType},{value}";
	}
}
