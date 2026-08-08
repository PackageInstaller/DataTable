using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("点周围固定一点", 0)]
[Category("Logic/Random")]
[Description("取得点周围固定一点,角度:按照Transform的y轴,传入负值向左转,传入正值向右转")]
public class GetTargetPositionFormPosition : FlowNode
{
	private Int3 m_targetPosInGraph;

	private ValueInput<Int3> m_centerPosInput;

	private ValueInput<Int3> m_forwardInput;

	private ValueInput<int> m_angleInput;

	private ValueInput<int> m_lengthInput;

	private FlowOutput m_output;

	protected override void RegisterPorts()
	{
		m_centerPosInput = AddValueInput<Int3>("中心", "centerPos");
		m_forwardInput = AddValueInput<Int3>("Forward", "forward");
		m_angleInput = AddValueInput<int>("夹角(毫度)", "angle");
		m_lengthInput = AddValueInput<int>("长度(毫米)", "length");
		m_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			Int3 @int = IntMath.VectorOfAngle(IntMath.AngleOfVector(m_forwardInput.GetValue()) - m_angleInput.GetValue());
			Int3 value = m_centerPosInput.GetValue();
			Int3 end = value + @int.NormalizeTo(m_lengthInput.GetValue());
			m_targetPosInGraph = CommonProcessor.GetPositionInGraphWithoutTangentMove(value, end);
			m_output.Call(f);
		});
		AddValueOutput("图内位置", "positionInGraph", () => m_targetPosInGraph);
	}
}
