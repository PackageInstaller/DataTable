using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("正在播放TimelineID(渲染)", 0)]
[Category("Render/Timeline")]
[Description("得到指定的Agent正在播放的Timeline的ID")]
public class GetAgentPlayingTimelineID : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput flowOut = AddFlowOutput("Out");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<int> AgentIDVar = AddValueInput<int>("AgentID");
		int TimelineID = 0;
		AddFlowInput("In", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(AgentIDVar.GetValue());
			if (agent == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				ComponentTimeline componentTimeline = agent.ComponentTimeline;
				if (componentTimeline == null)
				{
					abnormalOut.Call(f);
				}
				else
				{
					TimelineID = componentTimeline.TimelinePlayer.TimelineInfo.ID;
					if (TimelineID == 0)
					{
						abnormalOut.Call(f);
					}
					else
					{
						flowOut.Call(f);
					}
				}
			}
		});
		AddValueOutput("TimelineID", "GetAgentPlayingTimelineID_TimelineID", () => TimelineID);
	}
}
