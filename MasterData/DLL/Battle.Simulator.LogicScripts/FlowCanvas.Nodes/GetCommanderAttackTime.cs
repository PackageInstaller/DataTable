using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取指挥官攻击时间", 0)]
[Category("Logic/Config")]
[Description("获取指挥官攻击时间")]
public class GetCommanderAttackTime : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("毫秒数", delegate
		{
			int difficulty = CommonProcessor.GetWorldState().difficulty;
			return ConfigHelper.GetInstance().GetConfig<diffculty>(difficulty).D1;
		});
	}
}
