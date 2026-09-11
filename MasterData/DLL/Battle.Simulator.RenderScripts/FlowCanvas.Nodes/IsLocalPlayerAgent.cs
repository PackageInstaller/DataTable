using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否为本地玩家agent", 0)]
[Category("Render/Agent")]
[Description("判断传入的agentID是否为本地玩家agent")]
public class IsLocalPlayerAgent : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID");
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("False");
		AddFlowInput("In", delegate(Flow f)
		{
			if ((NScene.GetCurrentScene() as BattleScene).GetAgentManager().mPlayerAgentID == agentIDInput.value)
			{
				f.Call(trueOut);
			}
			else
			{
				f.Call(falseOut);
			}
		});
	}
}
