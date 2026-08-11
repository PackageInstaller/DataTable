using Ase.ECS;
using GameFramework;

namespace Ase;

public class BuffConditionStateAbnormal : BuffConditionState
{
	public static BuffConditionStateAbnormal Create(int stateId, EntityTeamType teamType, bool conditionVal)
	{
		BuffConditionStateAbnormal buffConditionStateAbnormal = ReferencePool.Acquire<BuffConditionStateAbnormal>();
		buffConditionStateAbnormal.stateId = stateId;
		buffConditionStateAbnormal.teamType = teamType;
		buffConditionStateAbnormal.conditionVal = conditionVal;
		return buffConditionStateAbnormal;
	}

	protected override bool ValidState(BaseEntity baseEntity, int stateId)
	{
		return baseEntity.GetComponent<AbnormalStateComponent>()?.CheckAbnormalState(stateId) ?? false;
	}
}
