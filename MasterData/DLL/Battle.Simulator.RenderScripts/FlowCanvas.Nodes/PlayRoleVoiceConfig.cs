using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放配置语音(渲染)", 0)]
[Category("Render/战斗喊话")]
[Description("角色执行技能播放对应的语音+文本,使用表格【RoelVoice】,语音ID为【RoelVoice】表中配置的ID")]
public class PlayRoleVoiceConfig : FlowControlNode
{
	private FlowOutput _Out;

	private FlowOutput _Error;

	private ValueInput<int> _AgentIDInput;

	private ValueInput<int> _RoleVoiceIDInput;

	private long _Length;

	protected override void RegisterPorts()
	{
		_Out = AddFlowOutput("Out");
		_Error = AddFlowOutput("Error");
		_AgentIDInput = AddValueInput<int>("实体ID", "AgentID");
		_RoleVoiceIDInput = AddValueInput<int>("语音ID", "VoiceID");
		AddFlowInput("In", delegate(Flow f)
		{
			_Length = 0L;
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
					int num = _RoleVoiceIDInput.value;
					if (num >= 105400001 && num <= 105400026)
					{
						int num2 = ((UnityEngine.Random.Range(0, 100) < 50) ? 1054 : 6148);
						num = num % 100 + num2 * 100000;
					}
					if (!componentTimeline.TryPlayRoleVoiceByConfig(num, out var _, 0))
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
		AddValueOutput("废弃", "Length", () => _Length);
	}
}
