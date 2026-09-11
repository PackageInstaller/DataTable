using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("停止Timeline音效(角色)(渲染)", 0)]
[Category("Render/声音")]
[Description("停止由Timeline播放的音效,该节点不会停止Timeline播放的音效")]
public class StopTimelineEffectAudio : FlowControlNodeOfRender
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		ValueInput<int> agentID = AddValueInput<int>("实体ID", "agentID");
		AddFlowInput("In", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentID.GetValue());
			if (agent != null)
			{
				ComponentTimeline componentTimeline = agent.ComponentTimeline;
				if (componentTimeline != null)
				{
					componentTimeline.StopTimelineEffectAudio();
				}
			}
			output.Call(f);
		});
	}
}
