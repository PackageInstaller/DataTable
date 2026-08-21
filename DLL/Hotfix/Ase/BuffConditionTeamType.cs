using System.Collections.Generic;

namespace Ase;

public class BuffConditionTeamType : BuffConditionBase
{
	private EntityTeamType teamType;

	private bool conditionVal;

	private EntityTeamType targetType;

	public override BuffConditionType BuffConditionType => BuffConditionType.TeamType;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[0]);
		conditionVal = Utility.Convert.StringToBool(paramList[1]);
		if (paramList.Count > 2)
		{
			targetType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[2]);
		}
	}

	protected override string OnGetDataString()
	{
		return $"{teamType},{conditionVal}{((targetType == EntityTeamType.DamageTarget) ? $",{EntityTeamType.DamageTarget}" : string.Empty)}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		if (base.IsSyncBattle)
		{
			return false;
		}
		return ConditionUtility.CompareTargetInTeamType((targetType == EntityTeamType.DamageTarget) ? entityFrom : entityTarget, teamType) == conditionVal;
	}

	protected override void OnCheckSyncBattleSafeAction()
	{
		base.OnCheckSyncBattleSafeAction();
		if (teamType == EntityTeamType.Actor || teamType == EntityTeamType.AI)
		{
			LogWarning($"当前为多人模式，此阵营参数无法使用:{teamType}");
		}
	}
}
