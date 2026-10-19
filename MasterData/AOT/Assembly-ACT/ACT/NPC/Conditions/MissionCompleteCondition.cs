using System;
using ACT.MissionSystem;
using ACT.Model;
using Fundamental;
using Runtime.Model.Condition;
using UnityEngine;

namespace ACT.NPC.Conditions;

[Serializable]
public class MissionCompleteCondition : NpcConditionUnit
{
	[Tooltip("如果为0，该条件默认通过")]
	public int missionID;

	public override int ConditionId => 3;

	protected override bool CheckCondition()
	{
		return Singleton<MissionManager>.instance.IsFinished(missionID);
	}

	public override void RegisterToConditionModel()
	{
		Model<ConditionModel>.Interface.RegisterMissionCondition(missionID, this);
	}

	public override void UnRegisterToConditionModel()
	{
		Model<ConditionModel>.Interface.UnRegisterMissionCondition(missionID, this);
	}
}
