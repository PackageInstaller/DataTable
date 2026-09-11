using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取每帧的时长（毫秒）", 0)]
[Category("Logic/Config")]
[Description("获取每帧的时长")]
public class GetDeltaTimeBetweenFrame : PureFunctionNode<int>
{
	public override int Invoke()
	{
		return CommonProcessor.GetLogicConstTick();
	}
}
