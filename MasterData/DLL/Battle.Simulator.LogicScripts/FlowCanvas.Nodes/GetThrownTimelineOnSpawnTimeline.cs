using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取抛掷物创建事件", 0)]
[Category("Logic/抛掷物")]
[Description("从Timeline上获取抛掷物创建事件数据")]
public class GetThrownTimelineOnSpawnTimeline : FlowControlNode
{
	private PostSpwanThrownEventInfo spawnInfo;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		ValueInput<int> TimelineIDVar = AddValueInput<int>("TimelineID");
		ValueInput<int> eventIndexVar = AddValueInput<int>("孵化抛掷物事件索引");
		AddFlowInput("In", delegate(Flow f)
		{
			spawnInfo = null;
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(TimelineIDVar.value);
			if (config != null)
			{
				Debug.Log("====>>>> timelineInfo.ID:" + config.ID);
				spawnInfo = config.PostSpwanThrownEvents.get_Item(eventIndexVar.value);
			}
			output.Call(f);
		});
		AddValueOutput("抛掷物创建数据：", () => spawnInfo);
	}
}
