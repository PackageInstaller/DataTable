using System;
using ACT.Drama;
using ACT.Model;
using Fundamental;
using Runtime.Model.Condition;

namespace ACT.NPC.Conditions;

[Serializable]
public class KeyPointPassCondition : NpcConditionUnit
{
	public int keyPointId;

	public override int ConditionId => 4;

	protected override bool CheckCondition()
	{
		return Singleton<ConversationManager>.instance.HaveKeyPoint(keyPointId);
	}

	public override void RegisterToConditionModel()
	{
		Model<ConditionModel>.Interface.RegisterKeyPointCondition(keyPointId, this);
	}

	public override void UnRegisterToConditionModel()
	{
		Model<ConditionModel>.Interface.UnRegisterKeyPointCondition(keyPointId, this);
	}
}
