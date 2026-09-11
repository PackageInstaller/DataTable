namespace BilliardGame.Spell;

public class BTCheckForm : BActionNode
{
	public int formID;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (!env.ContainKey("Form"))
		{
			return BTNodeStatus.Failure;
		}
		if (env.GetStruct<int>("Form") == formID)
		{
			return BTNodeStatus.Success;
		}
		return BTNodeStatus.Failure;
	}
}
