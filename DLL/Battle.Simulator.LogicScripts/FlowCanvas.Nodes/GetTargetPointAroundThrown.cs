using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物周围固定一点", 0)]
[Category("Logic/Random")]
[Description("抛掷物周围固定距离一点, 这一点会和实体在同一网格内")]
public class GetTargetPointAroundThrown : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("抛掷物ID");
		ValueInput<Int> startAngleInput = AddValueInput<Int>("起始角度");
		ValueInput<Int> endAngleInput = AddValueInput<Int>("结束角度");
		ValueInput<int> distanceInput = AddValueInput<int>("距离");
		AddValueOutput("抛掷物ID", () => entityIDInput.value);
		Int3 pos = Int3.zero;
		AddValueOutput("位置", () => pos);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			Int obj = 0;
			if (startAngleInput.value < endAngleInput.value)
			{
				obj = DRandom.Random((uint)(long)(endAngleInput.value - startAngleInput.value));
				obj -= startAngleInput.value;
			}
			ThrownState thrownState = null;
			ThrownProcessor.TryGetThrown(base.mSimContext, entityIDInput.GetValue(), out thrownState);
			obj = IntMath.AngleOfVector(thrownState.mForward) - obj;
			Int3 @int = IntMath.VectorOfAngle(obj);
			pos = thrownState.mPosition + @int.NormalizeTo(distanceInput.value);
			pos = CommonProcessor.GetPositionInGraphWithoutTangentMove(thrownState.mPosition, pos);
			output.Call(f);
		});
	}
}
