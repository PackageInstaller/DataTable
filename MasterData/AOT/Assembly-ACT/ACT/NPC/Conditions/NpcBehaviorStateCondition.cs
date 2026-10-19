using System;
using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Model;
using Bamboo.ECS;
using Fundamental;
using Runtime.Model.Condition;

namespace ACT.NPC.Conditions;

[Serializable]
public class NpcBehaviorStateCondition : NpcConditionUnit
{
	public int npcID;

	public NpcBehaviorState behaviorState;

	public override int ConditionId => 7;

	protected override bool CheckCondition()
	{
		if (Singleton<RuntimeNpcManager>.instance.InstantiatedNpcDictionary.TryGetValue(npcID, out var value) && value.IsValid)
		{
			CompNpc compNpc = value.GetCompNpc();
			if (compNpc != null)
			{
				return compNpc.BehaviorState == behaviorState;
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
