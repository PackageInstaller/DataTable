using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("控制隐藏部件组(看备注)(渲染)", 0)]
[Category("Render/Agent")]
[Description("指定某个组进行隐藏，组由 tpose 上的 Render 控制器，计数控制，必须加减必须对应")]
public class HideAgentRender : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "AgentID");
		AddValueOutput("实体ID", "AgentID", () => agentIDInput.value);
		ValueInput<int> indexInput = AddValueInput<int>("隐藏组索引", "index");
		ValueInput<bool> showInput = AddValueInput<bool>("显示", "show");
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
			if (agent != null)
			{
				ComponentTimeline component = agent.GetComponent<ComponentTimeline>();
				if (component != null)
				{
					component.SetRenderActive(indexInput.value, showInput.value);
				}
			}
			f.Call(output);
		});
	}
}
