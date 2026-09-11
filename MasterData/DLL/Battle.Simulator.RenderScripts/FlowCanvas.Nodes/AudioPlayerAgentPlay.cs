using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("播放音效或语音(角色)(渲染)", 0)]
[Category("Render/声音")]
[Description("播放默认角色声源(criware),适用于播放角色声效等")]
public class AudioPlayerAgentPlay : FlowControlNode
{
	private ValueInput<bool> m_isVoice;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		ValueInput<int> agentID = AddValueInput<int>("agentID");
		ValueInput<string> sheetName = AddValueInput<string>("CueSheet", "sheetName").SetDefaultAndSerializedValue("");
		ValueInput<string> cueName = AddValueInput<string>("CueName", "cueName").SetDefaultAndSerializedValue("");
		ValueInput<string> cueAwb = AddValueInput<string>("Cue Awb", "cueAwb").SetDefaultAndSerializedValue("");
		m_isVoice = AddValueInput<bool>("语音", "isVoice");
		long length = 0L;
		AddFlowInput("In", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentID.GetValue());
			if (agent != null)
			{
				ComponentTimeline componentTimeline = agent.ComponentTimeline;
				if (componentTimeline != null)
				{
					componentTimeline.PlayAudio(sheetName.GetValue(), cueName.GetValue(), !string.IsNullOrEmpty(cueAwb.GetValue()), m_isVoice.GetValue());
				}
			}
			output.Call(f);
		});
		AddValueOutput("AgentID", "AudioPlayerAgentPlay_Out_AgentID", () => agentID.GetValue());
		AddValueOutput("语音时长(-1为循环)", "AudioPlayerAgentPlay_Out_Length", () => length);
	}
}
