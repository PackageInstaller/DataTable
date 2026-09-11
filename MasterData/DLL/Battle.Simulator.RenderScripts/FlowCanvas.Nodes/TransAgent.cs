using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改游戏角色对象", 0)]
[Category("Render/Agent")]
[Description("修改游戏角色对象, 不会改agentID")]
public class TransAgent : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("error");
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID");
		ValueInput<int> newIDInput = AddValueInput<int>("新的角色ID");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				errorOut.Call(f);
			}
			else
			{
				int value = agentIDInput.value;
				int value2 = newIDInput.value;
				NAgent agent = agentManager.GetAgent(value);
				if (agent == null)
				{
					errorOut.Call(f);
				}
				else if (agentManager.ChangeAgent(agent, value2))
				{
					output.Call(f);
				}
				else
				{
					errorOut.Call(f);
				}
			}
		});
	}
}
