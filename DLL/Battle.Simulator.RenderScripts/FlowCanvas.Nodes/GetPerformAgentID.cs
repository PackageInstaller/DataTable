using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到表演AgentID(渲染)", 0)]
[Category("Render/Agent")]
[Description("得到用来表演的AgentID")]
[ExposeAsDefinition]
public class GetPerformAgentID : FlowControlNode
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
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIdInput.value);
			if (agent == null || agent.AttachPointSetup == null)
			{
				_performAgentID = 0;
				errorOut.Call(f);
			}
			else
			{
				_performAgentID = agent.m_tempPerformAgentID;
				output.Call(f);
			}
		});
	}
}
