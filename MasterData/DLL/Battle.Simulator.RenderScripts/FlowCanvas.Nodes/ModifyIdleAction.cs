using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改Idle动作", 0)]
[Category("Render/Agent")]
[Description("修改Idle动作, 填0的话, 就不替换. 或者可以填原本的值, 如果你知道的话")]
public class ModifyIdleAction : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("AgentID");
		ValueInput<int> idleIDInput = AddValueInput<int>("IdleID");
		ValueInput<int> relaxIDInput = AddValueInput<int>("RelaxID");
		ValueInput<int> battleIdleIDInput = AddValueInput<int>("BattleIdleID");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				errorOut.Call(f);
			}
			else
			{
				AgentManager agentManager = battleScene.GetAgentManager();
				if (agentManager == null)
				{
					errorOut.Call(f);
				}
				else
				{
					NAgent agent = agentManager.GetAgent(entityIDInput.value);
					if (agent == null)
					{
						errorOut.Call(f);
					}
					else
					{
						BBHumanoid bBHumanoid = agent.Blackboard as BBHumanoid;
						if (bBHumanoid == null)
						{
							errorOut.Call(f);
						}
						else
						{
							int value = idleIDInput.value;
							if (value != 0)
							{
								bBHumanoid.IdleID = value;
							}
							int value2 = relaxIDInput.value;
							if (value2 != 0)
							{
								bBHumanoid.RelaxID = value2;
							}
							int value3 = battleIdleIDInput.value;
							if (value3 != 0)
							{
								bBHumanoid.BattleIdleID = value3;
							}
							output.Call(f);
						}
					}
				}
			}
		});
	}
}
