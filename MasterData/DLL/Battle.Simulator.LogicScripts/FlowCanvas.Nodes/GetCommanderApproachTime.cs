using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取指挥官追击时间", 0)]
[Category("Logic/Config")]
[Description("获取指挥官追击时间")]
public class GetCommanderApproachTime : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("毫秒数", delegate
		{
			int difficulty = CommonProcessor.GetWorldState().difficulty;
			return ConfigHelper.GetInstance().GetConfig<diffculty>(difficulty).D2;
		});
	}
}
