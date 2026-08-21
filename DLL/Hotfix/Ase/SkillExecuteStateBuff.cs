using Ase.ECS;
using UnityEngine;

namespace Ase;

public class SkillExecuteStateBuff : BuffOperationBase<BuffDataSkillExecuteState>
{
	protected override void OnExecute()
	{
		if (base.buff.BuffRuntimeData == null)
		{
			return;
		}
		BaseEntity targetByTeamType = BuffExtension.GetTargetByTeamType(base.buffFrom, base.buffOwner, dataBase.teamType);
		if (targetByTeamType != null)
		{
			if (base.buff.BuffRuntimeData is BuffBulletRuntimeData buffBulletRuntimeData)
			{
				targetByTeamType.GetComponent<SkillComponent>()?.ExecuteSkillTiming(dataBase.executeState, buffBulletRuntimeData.skillConfigId, dataBase.skillLabel, Vector3.zero, isCd: false, null);
			}
			else
			{
				targetByTeamType.GetComponent<SkillComponent>()?.ExecuteSkillTiming(dataBase.executeState, dataBase.skillId, dataBase.skillLabel, Vector3.zero, isCd: false, null);
			}
		}
	}
}
