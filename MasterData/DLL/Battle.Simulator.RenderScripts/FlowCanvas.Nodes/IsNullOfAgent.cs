using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Agent是否存在", 0)]
[Category("Render/Agent")]
[Description("判断Agent是否存在")]
public class IsNullOfAgent : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID", "agentIDInput");
		FlowOutput trueOut = AddFlowOutput("存在", "trueOut");
		FlowOutput falseOut = AddFlowOutput("不存在", "falseOut");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", delegate(Flow f)
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (agentManager == null)
			{
				error.Call(f);
			}
			else if (agentManager.GetAgent(agentIDInput.value) != null)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddValueOutput("AgentID", "agentIDOut", () => agentIDInput.GetValue());
	}
}
