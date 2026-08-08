using UnityEngine;

namespace BilliardGame.Spell;

public class BTLoggerNode : BActionNode
{
	public int debugLog;

	public override BTNodeStatus Run(BTEnv env)
	{
		Debug.Log("调试信息: " + debugLog);
		return BTNodeStatus.Success;
	}
}
