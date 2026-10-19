using System;
using ACT.Drama;
using Bamboo.ECS;
using Fundamental;

namespace ACT.NPC.BehaviorTree.Variables.BehaviorTreeAction;

[Serializable]
[BehaviorActionTitle("发送 KeyPoint")]
public class ActionSendKeyPoint : BehaviorActionBase
{
	public int keyPointIndex;

	public override void Execute(Entity owner)
	{
		Singleton<ConversationManager>.instance.SetKeyPoint(keyPointIndex);
		Singleton<ConversationManager>.instance.SendKeyPoints();
	}
}
