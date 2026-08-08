using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("返回主场景(团雪)(渲染)", 0)]
[Category("Render/Offine")]
[Description("")]
public class GoToMain : FlowControlNode
{
	protected override void RegisterPorts()
	{
		AddFlowInput("In", "input", delegate
		{
			LuaHelper.CallFunction("PushSnowBallGoToMain");
		});
	}
}
