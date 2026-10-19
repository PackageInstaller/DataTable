using System;
using ACT.MissionSystem;
using ACT.Model;
using Fundamental;
using Runtime.Model.Condition;

namespace ACT.NPC.Conditions;

[Serializable]
public class MissionReceiveCondition : NpcConditionUnit
{
	public int missionID;

	public override int ConditionId => 2;

	protected override bool CheckCondition()
	{
		return Singleton<MissionManager>.instance.IsAccepted(missionID);
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
