using System;
using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Model;
using Bamboo.ECS;
using Fundamental;
using Runtime.Model.Condition;

namespace ACT.NPC.Conditions;

[Serializable]
public class NpcReachedPatrolPointCondition : NpcConditionUnit
{
	public int npcID;

	public int patrolPointNumber = 1;

	public override int ConditionId => 8;

	protected override bool CheckCondition()
	{
		if (Singleton<RuntimeNpcManager>.instance.InstantiatedNpcDictionary.TryGetValue(npcID, out var value) && value.IsValid)
		{
			CompNpc compNpc = value.GetCompNpc();
			if (compNpc != null && compNpc.BehaviorState == NpcBehaviorState.ReachedDestination)
			{
				return compNpc.CurrentPatrolPointIndex == patrolPointNumber - 1;
			}
		}
		return false;
	}

	public override void RegisterToConditionModel()
	{
		Model<ConditionModel>.Interface.RegisterNpcEventCondition(npcID, this);
	}

	public override void UnRegisterToConditionModel()
	{
		Model<ConditionModel>.Interface.UnRegisterNpcEventCondition(npcID, this);
	}
}
