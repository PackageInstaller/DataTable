using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到世界时间(逻辑)", 0)]
[Category("Logic")]
[Description("得到世界时间")]
public class GetWorldTime : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("帧数", "frame", () => (int)base.mSimContext.simStatus.mServerFrame);
		AddValueOutput("毫秒", "milliSecond", () => (int)base.mSimContext.simStatus.mSimTime);
	}
}
