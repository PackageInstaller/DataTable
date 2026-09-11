using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Lua函数<void>(int, int, int, int)", 0)]
[Category("Render/UI")]
[Description("Lua函数<void>(int, int), 两个int参数, 没有返回值")]
public class LuaFunctionVoidIntIntIntInt : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<string> functionNameInput = AddValueInput<string>("函数名");
		ValueInput<int> paramInput = AddValueInput<int>("参数1");
		ValueInput<int> param2Input = AddValueInput<int>("参数2");
		ValueInput<int> param3Input = AddValueInput<int>("参数3");
		ValueInput<int> param4Input = AddValueInput<int>("参数4");
		AddFlowInput("", delegate(Flow f)
		{
			LuaHelper.CallFunction(functionNameInput.value, paramInput.value, param2Input.value, param3Input.value, param4Input.value);
			output.Call(f);
		});
	}
}
