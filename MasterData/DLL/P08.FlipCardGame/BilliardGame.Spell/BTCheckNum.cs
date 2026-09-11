namespace BilliardGame.Spell;

public class BTCheckNum : BActionNode
{
	public override BTNodeStatus Run(BTEnv env)
	{
		if (!env.ContainKey("RemainNumber"))
		{
			return BTNodeStatus.Success;
		}
		if (env.GetStruct<int>("RemainNumber") > 0)
		{
			return BTNodeStatus.Success;
		}
		return BTNodeStatus.Failure;
	}
}
