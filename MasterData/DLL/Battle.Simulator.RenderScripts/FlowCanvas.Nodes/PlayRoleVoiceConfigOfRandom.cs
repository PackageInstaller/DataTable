using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放配置语音(随机)(渲染)", 0)]
[Category("Render/战斗喊话")]
[Description("角色执行技能播放对应的语音+文本,使用表格【RoelVoice】,语音ID为【RoelVoice】表中配置的ID;\n值1会加上随机出来的值作为key;\n内部会对key进行检查以避免key对应语音不存在的情况")]
public class PlayRoleVoiceConfigOfRandom : FlowControlNode
{
	private long _id;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput faildOut = AddFlowOutput("播放失败", "faild");
		FlowOutput errorOut = AddFlowOutput("Error");
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "AgentID");
		ValueInput<int> value1Input = AddValueInput<int>("值1", "roleID");
		ValueInput<List<int>> randomListInput = AddValueInput<List<int>>("随机组", "list");
		AddFlowInput("In", delegate(Flow f)
		{
			_id = 0L;
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.GetValue());
			if (agent == null)
			{
				errorOut.Call(f);
			}
			else
			{
				ComponentTimeline componentTimeline = agent.ComponentTimeline;
				if (componentTimeline == null)
				{
					errorOut.Call(f);
				}
				else
				{
					List<int> value = randomListInput.value;
					int num = UnityEngine.Random.Range(0, value.Count);
					bool flag = false;
					int value2 = value1Input.value;
					int num2 = value2 + value[num];
					for (int i = 0; i < value.Count; i++)
					{
						if (ConfigHelper.GetInstance().TryGetConfig<RoleVoice>(num2, out var _))
						{
							flag = true;
							break;
						}
						num++;
						num %= value.Count;
						num2 = value2 + value[num];
					}
					RoleVoice roleVoice;
					if (!flag)
					{
						errorOut.Call(f);
					}
					else if (!componentTimeline.TryPlayRoleVoiceByConfig(num2, out roleVoice, 0))
					{
						faildOut.Call(f);
					}
					else
					{
						_id = num2;
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "AgentID", () => agentIDInput.GetValue());
		AddValueOutput("语音ID", "Length", () => _id);
	}
}
