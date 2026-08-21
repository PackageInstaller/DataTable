using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("String为空", 0)]
[Category("Common/Control")]
[Description("设置世界时间缩放(0 - 100)")]
public class StringIsNullOrEmpty : FlowControlNode
{
	private ValueInput<string> m_stringInput;

	private FlowOutput m_true;

	private FlowOutput m_false;

	protected override void RegisterPorts()
	{
		m_stringInput = AddValueInput<string>("字符串", "stringInput");
		m_true = AddFlowOutput("为空", "NullOrEmpty");
		m_false = AddFlowOutput("不为空", "false");
		AddValueOutput("字符串", "stringInput", () => m_stringInput.GetValue());
		AddFlowInput("In", "intput", delegate(Flow f)
		{
			if (string.IsNullOrEmpty(m_stringInput.GetValue()))
			{
				m_true.Call(f);
			}
			else
			{
				m_false.Call(f);
			}
		});
	}
}
