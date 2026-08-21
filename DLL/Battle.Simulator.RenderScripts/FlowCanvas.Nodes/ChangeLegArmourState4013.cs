using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("改变4013腿部装甲状态(渲染)", 0)]
[Category("Render/Agent")]
[Description("改变4013腿部装甲状态")]
public class ChangeLegArmourState4013 : FlowControlNode
{
	private ValueInput<int> _agentIDInput;

	private ValueInput<string> _keyInput;

	private ValueInput<En_LegArmourState> _tragetStateInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_agentIDInput = AddValueInput<int>("实体ID", "agentID");
		_keyInput = AddValueInput<string>("部位", "key");
		_tragetStateInput = AddValueInput<En_LegArmourState>("状态", "targetState");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(_agentIDInput.GetValue());
			if (agent == null)
			{
				_Error.Call(f);
			}
			else
			{
				ComponentTimeline4013 component = agent.GetComponent<ComponentTimeline4013>();
				if (component == null)
				{
					_Error.Call(f);
				}
				else
				{
					component.ChangeLegArmourState(_keyInput.GetValue(), _tragetStateInput.GetValue());
					_Out.Call(f);
				}
			}
		});
	}
}
