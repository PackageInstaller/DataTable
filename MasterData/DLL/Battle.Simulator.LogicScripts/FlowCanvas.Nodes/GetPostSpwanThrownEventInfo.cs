using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取抛掷物的TimelineID", 0)]
[Category("Logic/抛掷物")]
[Description("通过TimelineID+抛掷物事件索引得到抛掷物使用的Timeline数据")]
public class GetPostSpwanThrownEventInfo : CallableFunctionNode<int, int, int, int>
{
	public override int Invoke(int timelineID, int spawnEventIndex, int thrownTimelineID)
	{
		if (thrownTimelineID != 0)
		{
			return thrownTimelineID;
		}
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(timelineID);
		if (config != null && config.PostSpwanThrownEvents.Count > spawnEventIndex)
		{
			return config.PostSpwanThrownEvents.get_Item(spawnEventIndex).ID;
		}
		return 0;
	}
}
