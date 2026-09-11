using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取timeline配置(abilityID)", 0)]
[Category("Logic/Config")]
[Description("根据abilityID获取timeline配置")]
public class GetTimelineConfig : CallableFunctionNode<Timeline, int>
{
	public override Timeline Invoke(int abilityID)
	{
		return ConfigHelper.GetInstance().GetConfig<Timeline>(abilityID);
	}
}
