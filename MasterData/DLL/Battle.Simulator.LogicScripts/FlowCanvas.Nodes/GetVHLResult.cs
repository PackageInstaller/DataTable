using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[VHL]读取VHL全局变量(逻辑)", 0)]
[Category("Logic/Config")]
[Description("读取AI玩法的跨关卡全局变量。仅AI玩法可用。")]
[Color("ffffff")]
public class GetVHLResult : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("VHLResult", () => CommonProcessor.GetWorldState().mVHLResult);
	}
}
