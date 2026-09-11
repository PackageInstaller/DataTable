using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取Timeline数据", 0)]
[Category("Logic/Config")]
[Description("通过TimelineID得到Timeline的数据")]
public class GetTimelineInfoByTimelineID : CallableFunctionNode<Timeline, int>
{
	public override Timeline Invoke(int timelineID)
	{
		return ConfigHelper.GetInstance().GetConfig<Timeline>(timelineID);
	}
}
