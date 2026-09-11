using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("计算距离(实体)(逻辑)", 0)]
[Category("Logic/Math")]
[Description("计算两个实体之间的距离，单位mm\n任一实体不存在时，返回-1")]
public class Magnitude2dEntity : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> vInA = AddValueInput<int>("实体A");
		ValueInput<int> vInB = AddValueInput<int>("实体B");
		AddValueOutput("距离", delegate
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(vInA.value);
			if (entityWithEntityID != null)
			{
				SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(vInB.value);
				if (entityWithEntityID2 != null && entityWithEntityID.hasEntityPositon && entityWithEntityID2.hasEntityPositon)
				{
					return (entityWithEntityID.entityPositon.mPosition - entityWithEntityID2.entityPositon.mPosition).magnitude2D;
				}
			}
			return -1;
		});
	}
}
