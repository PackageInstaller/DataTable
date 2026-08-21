using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取难度", 0)]
[Category("Logic/Config")]
[Description("获取当前关卡的难度id，见difficulty表")]
public class GetDiffcultyLevel : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("", () => CommonProcessor.GetWorldState().difficulty);
	}
}
