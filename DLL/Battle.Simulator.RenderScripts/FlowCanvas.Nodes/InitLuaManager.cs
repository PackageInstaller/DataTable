using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Category("Render/UI")]
[Description("InitLuaManager, 初始化lua")]
public class InitLuaManager : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			LuaHelper.CallFunction("manager.uiInit");
			output.Call(f);
		});
	}
}
