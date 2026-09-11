using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("重置部件隐藏(慎用)(看备注)(渲染)", 0)]
[Category("Render/Agent")]
[Description("重置部件隐藏状态,将会直接重置掉所有计数,慎用该节点")]
public class ResetRenderActive : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "AgentID");
		AddValueOutput("实体ID", "AgentID", () => agentIDInput.value);
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
			if (agent != null)
			{
				ComponentTimeline component = agent.GetComponent<ComponentTimeline>();
				if (component != null)
				{
					component.ResetRenderActive();
				}
			}
			f.Call(output);
		});
	}
}
