using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取Agent当前血量比例", 0)]
[Category("Render/Agent")]
[Description("获取Agent当前血量比例")]
public class GetAgentHPPercentPure : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("agentID");
		ValueInput<int> percentInput = AddValueInput<int>("比例").SetDefaultAndSerializedValue(100);
		AddValueOutput("结果", delegate
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				return 0;
			}
			NAgent agent = agentManager.GetAgent(agentIDInput.value);
			if (agent == null || agent.Blackboard == null)
			{
				return 0;
			}
			BBHumanoid bBHumanoid = agent.Blackboard as BBHumanoid;
			if (bBHumanoid == null)
			{
				return 0;
			}
			int value = percentInput.value;
			long hP = bBHumanoid.HP;
			long maxHP = bBHumanoid.MaxHP;
			return (int)((maxHP != 0L) ? (hP * value / maxHP) : 0);
		});
	}
}
