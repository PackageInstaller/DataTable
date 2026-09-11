namespace BilliardGame.Spell;

public class BTFreeSkillNode : BActionNode
{
	public override BTNodeStatus Run(BTEnv env)
	{
		env.AddStruct("free_Skill", value: true);
		return BTNodeStatus.Success;
	}
}
