using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("调用lua函数", 0)]
[Category("Render/UI")]
[Description("调用lua函数")]
public class CallLuaFunction : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<string> functionNameInput = AddValueInput<string>("函数名");
		AddFlowInput("", delegate(Flow f)
		{
			LuaHelper.CallFunction(functionNameInput.value);
			output.Call(f);
		});
	}
}
