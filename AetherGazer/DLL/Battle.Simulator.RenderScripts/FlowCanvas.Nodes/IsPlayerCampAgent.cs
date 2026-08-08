using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否为玩家方Agent", 0)]
[Category("Render/Agent")]
[Description("判断传入的agentID是否为玩家方Agent")]
public class IsPlayerCampAgent : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID");
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("False");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
			if (agent != null && RoleCampProcessor.IsPlayer(agent.Camp))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
