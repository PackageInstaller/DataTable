namespace BilliardGame.Spell;

public class BTSelectIntNode : BActionNode
{
	public string key;

	public int value;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (!env.ContainKey(key))
		{
			return BTNodeStatus.Failure;
		}
		if (value == env.GetStruct<int>(key))
		{
			return BTNodeStatus.Success;
		}
		return BTNodeStatus.Failure;
	}
}
