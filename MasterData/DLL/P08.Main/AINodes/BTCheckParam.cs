using System.Collections.Generic;
using BilliardGame.Spell;

namespace AINodes;

public class BTCheckParam : BTCheckerNode
{
	public string field;

	public override bool CheckWillExecute(BTEnv env)
	{
		return env.ContainKey(field);
	}

	public override IEnumerable<string> RequiredParams()
	{
		return null;
	}
}
