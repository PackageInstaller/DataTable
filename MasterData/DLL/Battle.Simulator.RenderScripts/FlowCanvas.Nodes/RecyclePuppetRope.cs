using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("回收傀儡绳(操纵者ID)", 0)]
[Category("Render/Asset")]
[Description("回收傀儡绳")]
public class RecyclePuppetRope : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDVar = AddValueInput<int>("操作者实体ID", "agentID");
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
					ComponentPendant component = agent.GetComponent<ComponentPendant>();
					if (component == null)
					{
						error.Call(f);
					}
					else
					{
						List<IPendant>.Enumerator enumerator = component.GetPendants().GetEnumerator();
						while (enumerator.MoveNext())
						{
							IPendant current = enumerator.Current;
							if (current is Puppet)
							{
								Puppet puppet = current as Puppet;
								if (puppet != null)
								{
									puppet.RemoveRope();
								}
							}
						}
						output.Call(f);
					}
				}
			}
		});
	}
}
