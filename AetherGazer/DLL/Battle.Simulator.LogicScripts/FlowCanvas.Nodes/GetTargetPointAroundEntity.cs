using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体周围固定一点(极坐标)", 0)]
[Category("Logic/Random")]
[Description("实体周围固定距离一点, 这一点会和实体在同一网格内, 结束角度要大于起始角度")]
public class GetTargetPointAroundEntity : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<Int> startAngleInput = AddValueInput<Int>("起始角度");
		ValueInput<Int> endAngleInput = AddValueInput<Int>("结束角度");
		ValueInput<int> distanceInput = AddValueInput<int>("距离");
		AddValueOutput("实体ID", () => entityIDInput.value);
		Int3 pos = Int3.zero;
		AddValueOutput("位置", () => pos);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			Int obj = 0;
			if (startAngleInput.value < endAngleInput.value)
			{
				obj = DRandom.Random((uint)(long)(endAngleInput.value - startAngleInput.value));
				obj += startAngleInput.value;
			}
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null)
			{
				obj = IntMath.AngleOfVector(entityWithEntityID.entityPositon.mForward) - obj;
				Int3 @int = IntMath.VectorOfAngle(obj);
				pos = entityWithEntityID.entityPositon.mPosition + @int.NormalizeTo(distanceInput.value);
				pos = CommonProcessor.GetPositionInGraphWithoutTangentMove(entityWithEntityID.entityPositon.mPosition, pos);
			}
			else
			{
				pos = Int3.zero;
			}
			output.Call(f);
		});
	}
}
