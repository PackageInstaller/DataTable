using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("加载控制器布局(渲染)", 0)]
[Category("Render/Agent")]
[Description("将传入的json转换为布局并重新加载")]
public class LoadLayoutFromJson : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> jsonInput = AddValueInput<string>("布局Json", "jsonStr").SetDefaultAndSerializedValue(string.Empty);
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("", delegate(Flow f)
		{
			GamepadManager.Instance.LoadLayoutFromJson(jsonInput.value);
			output.Call(f);
		});
	}
}
