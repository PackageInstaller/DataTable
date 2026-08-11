using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataOpenTeach : BuffDataBase
{
	public int teachGuideId;

	public int coverCureentTeach;

	public override BuffOperationType EffectType => BuffOperationType.BuffOpenTeach;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		teachGuideId = Utility.Convert.StringToInt(paramList[0]);
		coverCureentTeach = Utility.Convert.StringToInt(paramList[1]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{teachGuideId},{coverCureentTeach}";
	}
}
