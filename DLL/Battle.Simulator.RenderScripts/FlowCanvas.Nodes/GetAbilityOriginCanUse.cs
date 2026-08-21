using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能按钮能否释放", 0)]
[Category("Render/UI")]
[Description("用于判定按钮对应的技能是否可以释放")]
public class GetAbilityOriginCanUse : PureFunctionNode<bool, int, ButtonType>
{
	public override bool Invoke(int agentID, ButtonType buttonType)
	{
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null)
		{
			AgentManager agentManager = battleScene.GetAgentManager();
			if (agentManager != null)
			{
				NAgent agent = agentManager.GetAgent(agentID);
				if (agent != null)
				{
					BBHumanoid bBHumanoid = agent.Blackboard as BBHumanoid;
					if (bBHumanoid != null)
					{
						if (buttonType >= ButtonType.SKILL1 && buttonType < ButtonType.LOCK)
						{
							return ((bBHumanoid.m_NextSimFrameData.mAbilityOriginalCanUse >> (int)buttonType) & 1) == 1;
						}
					}
				}
			}
		}
		return false;
	}
}
