using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体等级", 0)]
[Category("Logic/Attribute")]
[Description("获取实体等级, 如果有问题的话, 返回0")]
public class GetEntityLevel : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("等级", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			return (entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard) ? entityWithEntityID.entityBlackboard.var.mFightLevel : 0;
		});
	}
}
