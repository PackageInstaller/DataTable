using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("停止音效与语音(角色)(渲染)", 0)]
[Category("Render/声音")]
[Description("停止实体身上全部的音效与语音,其中Timeline、节点播放的音效与语音")]
public class StopAllAudio : FlowControlNodeOfRender
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
					componentTimeline.StopAudio(isVoice: true);
					componentTimeline.StopAudio();
					componentTimeline.StopTimelineEffectAudio();
				}
			}
			output.Call(f);
		});
	}
}
