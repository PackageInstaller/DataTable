using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTStopBuff : BActionNode
{
	public override BTNodeStatus Run(BTEnv env)
	{
		env.AddStruct("WaitForDispose", value: true);
		if (env.ContainKey("effectFx"))
		{
			env.GetObject<BilliardGameEffect>("effectFx").Die();
		}
		return BTNodeStatus.Success;
	}
}
