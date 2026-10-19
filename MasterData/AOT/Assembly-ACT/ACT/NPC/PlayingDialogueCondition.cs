using System;
using ACT.Drama;
using ACT.Model;
using Fundamental;
using Runtime.Model.Condition;

namespace ACT.NPC;

[Serializable]
public class PlayingDialogueCondition : NpcConditionUnit
{
	public int avgId;

	public override int ConditionId => 5;

	protected override bool CheckCondition()
	{
		if (Singleton<ConversationManager>.instance.PlayingDialogue is AVGDialogueFromId { IsRunning: not false })
		{
			return true;
		}
		if (Singleton<ConversationManager>.instance.PlayingDialogue is AVGDialogueFromInstance { IsRunning: not false })
		{
			return true;
		}
		return false;
	}

	public override void RegisterToConditionModel()
	{
		Model<ConditionModel>.Interface.RegisterAVGCondition(avgId, this);
	}

	public override void UnRegisterToConditionModel()
	{
		Model<ConditionModel>.Interface.UnRegisterAVGCondition(avgId, this);
	}
}
