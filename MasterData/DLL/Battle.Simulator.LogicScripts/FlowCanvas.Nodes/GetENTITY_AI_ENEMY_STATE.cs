using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取小怪AI状态(0:未发现目标;1:观察;2:待攻击;3:攻击)(自动生成)", 0)]
[Category("Logic/Attribute/AutoGen")]
[Description("获取小怪AI状态(0:未发现目标;1:观察;2:待攻击;3:攻击)")]
public class GetENTITY_AI_ENEMY_STATE : PureFunctionNode<long, int>
{
	public override long Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		EntityVarName varName = EntityVarName.ENTITY_AI_ENEMY_STATE;
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, (int)varName, out var baseValue, out var _, out var _);
			return baseValue;
		}
		return 0L;
	}
}
