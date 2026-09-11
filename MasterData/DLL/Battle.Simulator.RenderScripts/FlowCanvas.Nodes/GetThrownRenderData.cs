using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取抛掷物数据(渲染)(过时)", 0)]
[Category("Render/抛掷物")]
[Description("获取抛掷物数据(渲染)")]
public class GetThrownRenderData : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> thrownIDInput = AddValueInput<int>("抛掷物ID");
		AddValueOutput("抛掷物ID", () => thrownIDInput.value);
		AddFlowOutput("");
		AddFlowInput("", delegate
		{
		});
	}
}
