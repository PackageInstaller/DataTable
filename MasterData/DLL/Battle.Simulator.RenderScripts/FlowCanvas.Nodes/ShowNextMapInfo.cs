using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Lua函数<void>(int)", 0)]
[Category("Render/UI")]
[Description("Lua函数<void>(int), 一个int参数, 没有返回值")]
public class ShowNextMapInfo : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<string> functionNameInput = AddValueInput<string>("函数名");
		ValueInput<int> paramInput = AddValueInput<int>("参数");
		AddFlowInput("", delegate(Flow f)
		{
			LuaHelper.CallFunction(functionNameInput.value, paramInput.value);
			output.Call(f);
		});
	}
}
