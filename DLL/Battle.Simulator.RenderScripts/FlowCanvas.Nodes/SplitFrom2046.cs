using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("4015脱离2046(渲染)", 0)]
[Category("Render/Agent")]
[Description("把4015从2046上脱离")]
public class SplitFrom2046 : FlowControlNode
{
	private ValueInput<int> _Agent4015IDInput;

	private ValueInput<int> _Agent2046IDInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_Agent4015IDInput = AddValueInput<int>("4015实体ID", "4015AgentID");
		_Agent2046IDInput = AddValueInput<int>("2046实体ID", "2046AgnetID");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			NAgent agent = agentManager.GetAgent(_Agent4015IDInput.GetValue());
			NAgent agent2 = agentManager.GetAgent(_Agent2046IDInput.GetValue());
			if (agent == null || agent2 == null)
			{
				_Error.Call(f);
			}
			else
			{
				ComponentTimeline4015 component = agent.GetComponent<ComponentTimeline4015>();
				if (component == null)
				{
					_Error.Call(f);
				}
				else
				{
					component.transform.SetParent(null);
					component.SplitFrom2046();
					_Out.Call(f);
				}
			}
		});
	}
}
