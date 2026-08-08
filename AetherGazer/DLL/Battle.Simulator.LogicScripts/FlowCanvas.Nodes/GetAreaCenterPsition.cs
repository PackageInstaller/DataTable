using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取战斗区域中心位置", 0)]
[Category("Logic/Trigger")]
[Description("获取战斗区域中心位置")]
public class GetAreaCenterPsition : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("", () => CommonProcessor.GetWorldState().centerPosition);
	}
}
