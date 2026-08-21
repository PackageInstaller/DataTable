using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("开关蹲姿状态组件", 0)]
[Category("Render/Agent")]
[Description("开关蹲姿状态组件")]
public class SetComponentCrawlState : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID");
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("激活", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				errorOut.Call(f);
			}
			else
			{
				NAgent agent = agentManager.GetAgent(agentIDInput.value);
				if (agent == null)
				{
					errorOut.Call(f);
				}
				else
				{
					ComponentCrawlState componentCrawlState = (agent as AgentHuman).ComponentCrawlState;
					if (componentCrawlState == null)
					{
						errorOut.Call(f);
					}
					else
					{
						componentCrawlState.isCrawl = true;
						output.Call(f);
					}
				}
			}
		});
		AddFlowInput("关闭", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				errorOut.Call(f);
			}
			else
			{
				NAgent agent = agentManager.GetAgent(agentIDInput.value);
				if (agent == null)
				{
					errorOut.Call(f);
				}
				else
				{
					ComponentCrawlState componentCrawlState = (agent as AgentHuman).ComponentCrawlState;
					if (componentCrawlState == null)
					{
						errorOut.Call(f);
					}
					else
					{
						componentCrawlState.isCrawl = false;
						output.Call(f);
					}
				}
			}
		});
	}
}
