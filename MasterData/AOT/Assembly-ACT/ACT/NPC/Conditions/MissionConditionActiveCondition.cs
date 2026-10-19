using System;
using ACT.MissionSystem;
using ACT.Model;
using Fundamental;
using Runtime.Model.Condition;

namespace ACT.NPC.Conditions;

[Serializable]
public class MissionConditionActiveCondition : NpcConditionUnit
{
	public int missionID;

	public int missionConditionId;

	public override int ConditionId => 10;

	protected override bool CheckCondition()
	{
		if (!Singleton<MissionManager>.HasInstance())
		{
			return false;
		}
		if (!Singleton<MissionManager>.instance.IsAccepting(missionID))
		{
			return false;
		}
		MissionFlow missionFlow = Singleton<MissionManager>.instance.GetMissionFlow(missionID);
		if (missionFlow == null)
		{
			return false;
		}
		return missionFlow.GetConditionById(missionConditionId)?.IsActive ?? false;
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
