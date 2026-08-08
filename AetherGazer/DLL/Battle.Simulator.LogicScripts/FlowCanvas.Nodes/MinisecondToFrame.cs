using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("毫秒转帧数", 0)]
[Category("Logic/Math")]
[Description("毫秒转帧数")]
public class MinisecondToFrame : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> minisecondValueInput = AddValueInput<int>("毫秒");
		AddValueOutput("帧数(向下取整)", () => minisecondValueInput.GetValue() / CommonProcessor.GetConfigInterval());
	}
}
