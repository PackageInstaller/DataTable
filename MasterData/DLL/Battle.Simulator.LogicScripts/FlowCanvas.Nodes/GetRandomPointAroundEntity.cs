using ParadoxNotion.Design;
using Pathfinding;

namespace FlowCanvas.Nodes;

[Name("实体周围随机一点", 0)]
[Category("Logic/Random")]
[Description("实体周围随机一点, 这一点会和实体在同一网格内, 范围必须大于0, 如果实体为空, 会报错")]
public class GetRandomPointAroundEntity : FlowNode
{
	private NNConstraint constraint = new NNConstraint();

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> rangeInput = AddValueInput<int>("范围");
		AddValueOutput("位置", delegate
		{
			Int3 randomPoint = CommonProcessor.GetRandomPoint((uint)rangeInput.value);
			randomPoint = new Int3(randomPoint.x - rangeInput.value / 2, 0, randomPoint.z - rangeInput.value / 2);
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null)
			{
				randomPoint += entityWithEntityID.entityPositon.mPosition;
				randomPoint = CommonProcessor.GetPositionInGraphWithoutTangentMove(entityWithEntityID.entityPositon.mPosition, randomPoint);
			}
			return randomPoint;
		});
	}
}
