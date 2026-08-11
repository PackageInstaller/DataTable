using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class BuffConditionCheckBattleState : BuffConditionBase
{
	private EntityTeamType teamType;

	protected bool compare;

	public override BuffConditionType BuffConditionType => BuffConditionType.CheckBattleState;

	protected override int paramsMinCount => 2;

	protected override void OnInit(List<string> paramList)
	{
		teamType = Utility.Convert.StringToEnum<EntityTeamType>(paramList[0]);
		compare = Utility.Convert.StringToBool(paramList[1]);
	}

	protected override string OnGetDataString()
	{
		return $"{teamType},{compare}";
	}

	public override bool OnCheck(Buff buff = null)
	{
		if (entityTarget == null || !(entityTarget is HeroEntity entity))
		{
			return false;
		}
		if (ConditionUtility.CompareTargetInTeamType(entityTarget, teamType))
		{
			return entity.GetSystem<BattleStateSystem>().GetEntityBattleState(entityTarget.Id) == compare;
		}
		return false;
	}
}
