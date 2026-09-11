using System.Collections.Generic;
using BilliardGame.Spell;
using T0World;

namespace AINodes;

public class BTCheckAgentParam : BTCheckerNode
{
	public AgentCheckType checkType;

	private T0CharacterBlackborad agentBlackborad;

	public override bool CheckWillExecute(BTEnv env)
	{
		if (agentBlackborad == null)
		{
			agentBlackborad = T0WorldScene.Scene.agentManager.CharacteraAgent.CharacterBoard;
		}
		bool result = false;
		if (checkType == AgentCheckType.ExecuteFollow)
		{
			result = agentBlackborad.executeFollow;
			agentBlackborad.executeFollow = false;
		}
		return result;
	}

	public override IEnumerable<string> RequiredParams()
	{
		return null;
	}
}
