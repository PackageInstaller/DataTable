using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("停止音效或语音(角色)(渲染)(过时)", 0)]
[Category("Render/声音")]
[Description("替代节点【停止节点音效(角色)】【停止Timeline音效(角色)】【停止音效(角色)】【停止语音(角色)】【停止音效与语音(角色)】;\n停止默认角色声源(criware)，适用于播放角色声效等,该节点关闭的特效音只能是由节点播放的,如果要关闭Timeline播放的特效音,请使用【停止Timeline特效音】")]
public class AudioPlayerAgentStop : FlowControlNode
{
	private ValueInput<bool> m_isVoice;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		ValueInput<int> agentID = AddValueInput<int>("agentID");
		m_isVoice = AddValueInput<bool>("语音", "isVoice");
		AddFlowInput("In", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentID.GetValue());
			if (agent != null)
			{
				ComponentTimeline componentTimeline = agent.ComponentTimeline;
				if (componentTimeline != null)
				{
					componentTimeline.StopAudio(m_isVoice.GetValue());
				}
			}
			output.Call(f);
		});
	}
}
