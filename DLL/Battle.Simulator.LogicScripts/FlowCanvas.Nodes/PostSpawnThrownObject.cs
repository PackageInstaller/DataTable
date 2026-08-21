using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("创建抛掷物实体(过时)", 0)]
[Category("Logic/抛掷物")]
[Description("发送创建抛掷物实体事件")]
public class PostSpawnThrownObject : CallableActionNode<int, int, Int3, Int3, bool, int, int, int>
{
	public override void Invoke(int casterID, int thrownTimelineID, Int3 position, Int3 forward, bool useCommon, int producerID, int creatdRootTimelineID, int attributeIDInput)
	{
		if (forward == Int3.zero)
		{
			forward = Int3.forward;
		}
		int attributeID = 0;
		if (INeedSpawnThrown.TryGetAttributeID(base.parentNode.mSimContext, attributeIDInput, producerID, out attributeID))
		{
			ThrownProcessor.SpawnThrown(base.parentNode.mSimContext, casterID, 0, 0, position, forward, thrownTimelineID, useCommon, producerID, creatdRootTimelineID, attributeID, out var _);
		}
	}
}
