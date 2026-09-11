using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断Agent距离(渲染)", 0)]
[Category("Render/PosAndRot")]
[Description("判断Agent距离")]
public class AgentDistance : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityID1Input = AddValueInput<int>("AgentID1");
		ValueInput<int> entityID2Input = AddValueInput<int>("AgentID2");
		ValueInput<float> distanceInput = AddValueInput<float>("距离");
		FlowOutput outGreatThan = AddFlowOutput("大于");
		FlowOutput outLessThan = AddFlowOutput("小于");
		FlowOutput outEqual = AddFlowOutput("等于(几乎不会相等)");
		FlowOutput outError = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				outError.Call(f);
			}
			else
			{
				AgentManager agentManager = battleScene.GetAgentManager();
				if (agentManager == null)
				{
					outError.Call(f);
				}
				else
				{
					NAgent agent = agentManager.GetAgent(entityID1Input.value);
					NAgent agent2 = agentManager.GetAgent(entityID2Input.value);
					if (agent == null || agent2 == null)
					{
						outError.Call(f);
					}
					else if (agent.transform == null || agent2.transform == null)
					{
						outError.Call(f);
					}
					else
					{
						float value = distanceInput.value;
						value *= value;
						float sqrMagnitude = (agent.transform.position - agent2.transform.position).sqrMagnitude;
						if (sqrMagnitude > value)
						{
							outGreatThan.Call(f);
						}
						else if (sqrMagnitude < value)
						{
							outLessThan.Call(f);
						}
						else
						{
							outEqual.Call(f);
						}
					}
				}
			}
		});
	}
}
