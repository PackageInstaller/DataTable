using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体最大血量的千分比", 0)]
[Category("Logic/Attribute")]
[Description("获取实体最大血量的千分比,10的话就是0.010")]
public class GetEntityMaxHPPermillage : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIdInput = AddValueInput<int>("实体ID");
		ValueInput<Int> percentInput = AddValueInput<Int>("千分比");
		AddValueOutput("结果值", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIdInput.value);
			return (int)((entityWithEntityID != null && entityWithEntityID.hasEntityBlackboard) ? (entityWithEntityID.entityBlackboard.var.mMaxHP * percentInput.value.i / 1000) : 0);
		});
	}
}
