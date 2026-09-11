using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Lua函数<int>()", 0)]
[Category("Render/UI")]
[Description("Lua函数<int>(), 没有参数, 一个int返回值")]
public class MatrixBattleStage : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<string> functionNameInput = AddValueInput<string>("函数名");
		int res = 0;
		AddValueOutput("返回值", () => res);
		AddFlowInput("", delegate(Flow f)
		{
			object[] array = LuaHelper.CallFunction(functionNameInput.value);
			if (array != null && array.Length != 0)
			{
				res = (int)(double)array[0];
			}
			output.Call(f);
		});
	}
}
