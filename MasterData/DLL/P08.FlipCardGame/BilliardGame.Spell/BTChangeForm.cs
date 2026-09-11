namespace BilliardGame.Spell;

public class BTChangeForm : BActionNode
{
	public int formID;

	public override BTNodeStatus Run(BTEnv env)
	{
		env.AddStruct("Form", formID, isPersistent: true);
		return BTNodeStatus.Success;
	}
}
