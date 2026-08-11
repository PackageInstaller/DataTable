using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataSkillStrengthState : BuffDataBase
{
	public int skillId;

	public bool state;

	public override BuffOperationType EffectType => BuffOperationType.SkillStrengthState;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		skillId = Utility.Convert.StringToInt(paramList[0]);
		state = Utility.Convert.StringToBool(paramList[1]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{skillId},{state}";
	}
}
