using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataSkillLayer : BuffDataBase
{
	public int skillId;

	public ChangeType changeType;

	public int layer;

	public override BuffOperationType EffectType => BuffOperationType.SkillLayer;

	protected override int paramsMinCount => 3;

	protected override void OnInit(List<string> paramList)
	{
		skillId = Utility.Convert.StringToInt(paramList[0]);
		changeType = Utility.Convert.StringToEnum<ChangeType>(paramList[1]);
		layer = Utility.Convert.StringToInt(paramList[2]);
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{skillId},{changeType},{layer}";
	}
}
