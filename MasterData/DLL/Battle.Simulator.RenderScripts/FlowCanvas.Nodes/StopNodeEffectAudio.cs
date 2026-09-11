using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("停止节点音效(角色)(渲染)", 0)]
[Category("Render/声音")]
[Description("停止由节点播放的音效,该节点不会停止Timeline播放的音效")]
public class StopNodeEffectAudio : FlowControlNodeOfRender
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentID = AddValueInput<int>("实体ID", "agentID");
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentID.GetValue());
			if (agent != null)
			{
				ComponentTimeline componentTimeline = agent.ComponentTimeline;
				if (componentTimeline != null)
				{
					componentTimeline.StopAudio();
				}
			}
			output.Call(f);
		});
	}
}
