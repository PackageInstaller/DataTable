using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置表演AgentID(渲染)", 0)]
[Category("Render/Agent")]
[Description("设置用来表演的AgentID")]
[ExposeAsDefinition]
public class SetPerformAgentID : FlowControlNode
{
	private int _performAgentID;

	protected override void RegisterPorts()
	{
		ValueInput<int> agentIdInput = AddValueInput<int>("实体ID", "agentID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddValueOutput("表演实体ID", "performAgentID", () => _performAgentID);
		AddFlowInput("In", delegate(Flow f)
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			NAgent agent = agentManager.GetAgent(agentIdInput.value);
			if (agent == null || agent.AttachPointSetup == null)
			{
				_performAgentID = 0;
				if (agent != null)
				{
					agent.m_tempPerformAgentID = _performAgentID;
				}
				errorOut.Call(f);
			}
			else
			{
				AttachPointSetup attachPointSetup = agent.AttachPointSetup;
				if (attachPointSetup.m_roleID == 0)
				{
					_performAgentID = agent.AgentID;
					agent.m_tempPerformAgentID = _performAgentID;
					output.Call(f);
				}
				else
				{
					foreach (NAgent entity in agentManager.Entities)
					{
						if (entity.AgentConfigID == attachPointSetup.m_roleID)
						{
							_performAgentID = entity.AgentID;
							agent.m_tempPerformAgentID = _performAgentID;
							break;
						}
					}
					output.Call(f);
				}
			}
		});
	}
}
