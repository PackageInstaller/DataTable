using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取多倍挑战倍数", 0)]
[Category("Logic/Spawn")]
[Description("获取多倍挑战倍数")]
public class GetChallengeFactor : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("", () => CommonProcessor.GetWorldState().mChallengeFactor);
	}
}
