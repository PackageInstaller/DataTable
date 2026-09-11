using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("回收傀儡绳(傀儡ID)", 0)]
[Category("Render/Asset")]
[Description("回收傀儡绳")]
public class RecyclePuppetRope2 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDVar = AddValueInput<int>("傀儡实体ID", "agentID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AgentManager agentManager = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager();
			if (agentManager == null)
			{
				error.Call(f);
			}
			else
			{
				NAgent agent = agentManager.GetAgent(agentIDVar.GetValue());
				if (agent == null)
				{
					error.Call(f);
				}
				else
				{
					Puppet component = agent.GetComponent<Puppet>();
					if (component == null)
					{
						error.Call(f);
					}
					else
					{
						component.RemoveRope();
						output.Call(f);
					}
				}
			}
		});
	}
}
