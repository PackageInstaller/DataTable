using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("播放配置语音(实体ID+语音后三位)(渲染)", 0)]
[Category("Render/战斗喊话")]
[Description("角色执行技能播放对应的语音+文本,使用表格【RoelVoice】,语音编号为【RoelVoice】表中配置的对应角色语音的后三位ID")]
public class PlayRoleVoiceConfigByEntityID : FlowControlNode
{
	private FlowOutput _Out;

	private FlowOutput _Error;

	private ValueInput<int> _AgentIDInput;

	private ValueInput<int> _RoleVoiceIDInput;

	protected override void RegisterPorts()
	{
		_Out = AddFlowOutput("Out");
		_Error = AddFlowOutput("Error");
		_AgentIDInput = AddValueInput<int>("实体ID", "AgentID");
		_RoleVoiceIDInput = AddValueInput<int>("语音编号(后三位)", "VoiceID");
		AddFlowInput("In", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(_AgentIDInput.GetValue());
			if (agent == null)
			{
				_Error.Call(f);
			}
			else
			{
				ComponentTimeline componentTimeline = agent.ComponentTimeline;
				if (componentTimeline == null)
				{
					_Error.Call(f);
				}
				else
				{
					int id = agent.AgentConfigID * 100000 + _RoleVoiceIDInput.value;
					if (!componentTimeline.TryPlayRoleVoiceByConfig(id, out var _, 0))
					{
						_Error.Call(f);
					}
					else
					{
						_Out.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "AgentID", () => _AgentIDInput.GetValue());
	}
}
