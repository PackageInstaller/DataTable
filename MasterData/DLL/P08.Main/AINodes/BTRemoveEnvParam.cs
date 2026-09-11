using BilliardGame.Spell;

namespace AINodes;

public class BTRemoveEnvParam : BActionNode
{
	public string field;

	public bool failIfParamNotExist;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (!env.Remove(field, out var _) && failIfParamNotExist)
		{
			return BTNodeStatus.Failure;
		}
		return BTNodeStatus.Success;
	}
}
