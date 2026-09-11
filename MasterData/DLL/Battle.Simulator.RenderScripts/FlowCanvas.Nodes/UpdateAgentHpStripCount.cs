using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("更新Agent血条数", 0)]
[Category("Render/Agent")]
[Description("更新Agent血条数，用于修改最大生命值之后血条不更新的问题")]
public class UpdateAgentHpStripCount : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		ValueInput<int> agentID = AddValueInput<int>("agentID", "AgentID");
		ValueInput<int> levelInput = AddValueInput<int>("等级", "level");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(agentID.value);
			if (agent == null)
			{
				errorOut.Call(f);
			}
			else
			{
				int value = levelInput.value;
				if (!ConfigHelper.GetInstance().TryGetConfig<monster_standard>(value, out var config))
				{
					errorOut.Call(f);
				}
				else
				{
					long maxHP = (agent.Blackboard as BBHumanoid).m_NextSimFrameData.MaxHP;
					long hP = (agent.Blackboard as BBHumanoid).m_NextSimFrameData.HP;
					ComponentHealth healthComponent = (agent as AgentHuman).HealthComponent;
					if (healthComponent == null)
					{
						errorOut.Call(f);
					}
					else
					{
						healthComponent.HpStripCount = (int)(maxHP + config.HpRatio - 1) / config.HpRatio;
						healthComponent.HealthChangeSlowly = hP;
						healthComponent.Health = hP;
						output.Call(f);
					}
				}
			}
		});
	}
}
