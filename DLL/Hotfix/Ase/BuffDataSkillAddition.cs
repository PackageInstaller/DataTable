using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataSkillAddition : BuffDataBase
{
	public int skillId;

	public AdditionKind additionKind;

	public float addition;

	public override BuffOperationType EffectType => BuffOperationType.SkillAddition;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		skillId = Utility.Convert.StringToInt(paramList[0]);
		additionKind = Utility.Convert.StringToEnum<AdditionKind>(paramList[1]);
		addition = Utility.Convert.StringToFloat(paramList[2]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{skillId},{additionKind},{addition}";
	}
}
