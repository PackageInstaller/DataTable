using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("传递实体ID", 0)]
[Category("Common/Control")]
[Description("传递实体ID")]
public class TempNode : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> i = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => i.value);
	}
}
