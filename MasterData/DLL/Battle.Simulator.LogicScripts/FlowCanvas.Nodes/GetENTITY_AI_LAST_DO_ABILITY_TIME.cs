using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取上一次执行技能的时间(毫秒)(自动生成)", 0)]
[Category("Logic/Attribute/AutoGen")]
[Description("获取上一次执行技能的时间(毫秒)")]
public class GetENTITY_AI_LAST_DO_ABILITY_TIME : PureFunctionNode<long, int>
{
	public override long Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		EntityVarName varName = EntityVarName.ENTITY_AI_LAST_DO_ABILITY_TIME;
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard)
		{
			AttributeProcessor.GetAttributeWithIntName(entityWithEntityID.entityBlackboard.var.mAttributeID, (int)varName, out var baseValue, out var _, out var _);
			return baseValue;
		}
		return 0L;
	}
}
