using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("比较帧数", 0)]
[Category("Logic/Math")]
[Description("帧数与毫秒进行比较,相等则调用 True,否则调用 False")]
public class CompareFrameAndMillisecond : FlowControlNode
{
	private ValueInput<int> m_frameInput;

	private ValueInput<int> m_millisecondInput;

	private FlowOutput m_equal;

	private FlowOutput m_greater;

	private FlowOutput m_less;

	private FlowOutput m_true;

	private FlowOutput m_false;

	protected override void RegisterPorts()
	{
		m_frameInput = AddValueInput<int>("帧数", "frameCount");
		m_millisecondInput = AddValueInput<int>("毫秒", "millisecond");
		m_equal = AddFlowOutput("相等", "equal");
		m_greater = AddFlowOutput("帧数大", "greater");
		m_less = AddFlowOutput("毫秒大", "less");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			int value = m_frameInput.GetValue();
			int num = m_millisecondInput.GetValue() / CommonProcessor.GetConfigInterval();
			if (value > num)
			{
				m_greater.Call(f);
			}
			else if (value == num)
			{
				m_equal.Call(f);
			}
			else
			{
				m_less.Call(f);
			}
		});
	}
}
