using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取Agent的皮肤ID", 0)]
[Category("Render/UI")]
[Description("获取Agent的皮肤ID, 只能在表现层用")]
public class GetAgentSkinID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("agentID");
		AddValueOutput("结果", delegate
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				return 0;
			}
			NAgent agent = agentManager.GetAgent(agentIDInput.value);
			return (!(agent == null) && !(agent.Blackboard == null)) ? agent.AgentSkinID : 0;
		});
	}
}
