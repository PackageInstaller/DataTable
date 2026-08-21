namespace BilliardGame.Spell;

public class BTAddATKNode : BActionNode
{
	public enum ATKType
	{
		value,
		ratio
	}

	public int atk;

	public ATKType type;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (type == ATKType.value)
		{
			env.AddStruct("add_atk", atk);
		}
		else
		{
			env.AddStruct("add_atk_ratio", atk);
		}
		return BTNodeStatus.Success;
	}
}
