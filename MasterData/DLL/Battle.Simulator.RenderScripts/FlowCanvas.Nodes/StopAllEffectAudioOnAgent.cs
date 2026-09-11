using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("停止音效(角色)(渲染)", 0)]
[Category("Render/声音")]
[Description("同时停止由节点、Timeline播放的音效")]
public class StopAllEffectAudioOnAgent : FlowControlNodeOfRender
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
					componentTimeline.StopAudio();
					componentTimeline.StopTimelineEffectAudio();
				}
			}
			output.Call(f);
		});
	}
}
