using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("播放角色声音和文本(Criware)", 0)]
[Category("Render/战斗喊话")]
[Description("角色在战斗中的喊话,语音ID为【RoelVoice】表中配置的ID")]
public class AudioPlayerWithRoleBattleTalk : FlowControlNode
{
	private CriAtomSource sound;

	protected override void RegisterPorts()
	{
		FlowOutput flowOut = AddFlowOutput("Out");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<int> AgentIDVar = AddValueInput<int>("AgentID", "AgentIDVar");
		ValueInput<int> SoundIDVar = AddValueInput<int>("语音ID", "SoundIDVar");
		AddValueInput<bool>("显示文本", "ShowTextVar").SetDefaultAndSerializedValue(v: true);
		long length = 0L;
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
				RoleVoice roleVoice;
				if (componentTimeline == null)
				{
					abnormalOut.Call(f);
				}
				else if (!componentTimeline.TryPlayRoleVoiceByConfig(SoundIDVar.GetValue(), out roleVoice, 0))
				{
					abnormalOut.Call(f);
				}
				else
				{
					flowOut.Call(f);
				}
			}
		});
		AddValueOutput("AgentID", "AgentID", () => AgentIDVar.GetValue());
		AddValueOutput("语音时长(-1为循环)", "Length", () => length);
	}
}
