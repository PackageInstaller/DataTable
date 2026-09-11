namespace BilliardGame.Spell;

public class BTSubRemainNum : BActionNode
{
	public int num = 1;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (!env.ContainKey("RemainNumber"))
		{
			return BTNodeStatus.Failure;
		}
		int num = env.GetStruct<int>("RemainNumber");
		env.AddStruct("RemainNumber", num - this.num);
		return BTNodeStatus.Success;
	}
}
