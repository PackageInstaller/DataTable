using System;
using System.Collections.Generic;

namespace Ase;

public class BuffDataSkillExecuteState : BuffDataBase
{
	public EntityTeamType teamType;

	public int skillId;

	public string skillLabel;

	public SkillExecuteState executeState;

	public override BuffOperationType EffectType => BuffOperationType.SkillExecuteState;

	protected override int paramsMinCount => 4;

	protected override void OnInit(List<string> paramList)
	{
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[0]);
		skillId = Utility.Convert.StringToInt(paramList[1]);
		skillLabel = paramList[2];
		executeState = Utility.Convert.StringToEnum<SkillExecuteState>(paramList[3]);
		if (skillLabel == "0")
		{
			skillLabel = string.Empty;
		}
		_ = executeState;
		_ = 2;
	}

	protected override void OnResetParams(params object[] args)
	{
		throw new NotImplementedException();
	}

	protected override string OnGetDataString()
	{
		return $"{teamType},{skillId},{skillLabel},{executeState}";
	}
}
