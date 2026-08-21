using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取AI玩法(Pure)", 0)]
[Category("Logic/AI")]
[Description("使用的黑板变量，变量名为【角色ID+00088】\n该节点用于获取输入的实体的【AI玩法】值")]
public class GetAIPlayMethodPure : PureFunctionNode<long, int>
{
	public override long Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			int varName = entityWithEntityID.entityConfig.mId * 100000 + 88;
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, varName, out var baseValue, out var _, out var _);
			return baseValue;
		}
		return 0L;
	}
}
