using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("整型转ButtonType", 0)]
[Category("Common/Control")]
[Description("判断指定按钮是否按住")]
public class IntToButtonType : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> intInput = AddValueInput<int>("整数");
		AddValueOutput("ButtonType", () => (ButtonType)intInput.value);
	}
}
