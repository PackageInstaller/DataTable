using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("帧数转毫秒", 0)]
[Category("Logic/Math")]
[Description("帧数转毫秒")]
public class FrameToMillisecond : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> frameValueInput = AddValueInput<int>("帧数");
		AddValueOutput("毫秒", () => frameValueInput.value * CommonProcessor.GetConfigInterval());
	}
}
