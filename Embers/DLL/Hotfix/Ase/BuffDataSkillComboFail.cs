using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataSkillComboFail : BuffDataBase
{
	public override BuffOperationType EffectType => BuffOperationType.BuffSkillComboFail;

	protected override int paramsMinCount => -1;

	protected override void OnInit(List<string> paramList)
	{
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return "";
	}
}
