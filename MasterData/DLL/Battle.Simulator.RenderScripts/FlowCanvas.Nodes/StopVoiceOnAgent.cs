using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("停止语音(角色)(渲染)", 0)]
[Category("Render/声音")]
[Description("停止角色语音,包含了节点、Timeline的语音")]
public class StopVoiceOnAgent : FlowControlNodeOfRender
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
				}
			}
			output.Call(f);
		});
	}
}
