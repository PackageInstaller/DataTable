using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[新多维额外按钮]获取初始充能", 0)]
[Category("Logic/新多维")]
[Description("获取初始充能, 不能用在ai玩法里面")]
public class NewMatrixGetInitEnergy : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("", () => CommonProcessor.GetWorldState().mVHLResult);
	}
}
