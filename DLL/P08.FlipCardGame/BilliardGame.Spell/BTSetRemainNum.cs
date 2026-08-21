namespace BilliardGame.Spell;

public class BTSetRemainNum : BActionNode
{
	public int num;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (env.ContainKey("RemainNumber"))
		{
			return BTNodeStatus.Success;
		}
		env.AddStruct("RemainNumber", num);
		return BTNodeStatus.Success;
	}
}
