using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置MagicaCloth", 0)]
[Category("Render/Anime")]
[Description("控制MagicaCloth开关")]
public class SetMagicaCloth : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID", "agentID");
		ValueInput<bool> isOpenInput = AddValueInput<bool>("开关状态", "isOpen");
		FlowOutput trueOut = AddFlowOutput("Out", "out");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "in", delegate(Flow f)
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(agentIDInput.value);
			if (agent == null)
			{
				errorOut.Call(f);
			}
			else
			{
				ToggleMagicaClothFolder component = agent.GetComponent<ToggleMagicaClothFolder>();
				if (component == null)
				{
					errorOut.Call(f);
				}
				else
				{
					if (isOpenInput.value)
					{
						component.OpenMagicaCloth();
					}
					else
					{
						component.CloseMagicaCloth();
					}
					trueOut.Call(f);
				}
			}
		});
	}
}
