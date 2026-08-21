using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("计算距离(实体与抛掷物)(逻辑)", 0)]
[Category("Logic/Math")]
[Description("计算指定实体与指定抛掷物之间的距离，单位mm\n抛掷物或实体不存在时，返回-1")]
public class Magnitude2dEntityThrown : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> vInEntity = AddValueInput<int>("实体Id");
		ValueInput<int> vInThrown = AddValueInput<int>("抛掷物Id");
		AddValueOutput("距离", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(vInEntity.value);
			ThrownState thrownState;
			return (entityWithEntityID != null && ThrownProcessor.TryGetThrown(base.mSimContext, vInThrown.value, out thrownState) && entityWithEntityID.hasEntityPositon) ? (entityWithEntityID.entityPositon.mPosition - thrownState.mPosition).magnitude2D : (-1);
		});
	}
}
