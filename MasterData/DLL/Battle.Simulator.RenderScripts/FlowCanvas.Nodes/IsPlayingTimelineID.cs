using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否在播放指定Timeline(渲染)", 0)]
[Category("Render/Timeline")]
[Description("判断指定的Agent是否在播放指定的Timeline")]
public class IsPlayingTimelineID : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("False");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<int> AgentIDVar = AddValueInput<int>("AgentID");
		ValueInput<int> TimelineIDVar = AddValueInput<int>("TimelineID");
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
				else if (componentTimeline.TimelinePlayer.TimelineInfo == null)
				{
					abnormalOut.Call(f);
				}
				else if (TimelineIDVar.GetValue() == componentTimeline.TimelinePlayer.TimelineInfo.ID)
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
	}
}
