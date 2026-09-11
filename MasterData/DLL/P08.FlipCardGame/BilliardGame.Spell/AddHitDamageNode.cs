namespace BilliardGame.Spell;

public class AddHitDamageNode : BActionNode
{
	public int addAtk;

	public override BTNodeStatus Run(BTEnv env)
	{
		env.AddStruct("add_hit_damage", addAtk);
		return BTNodeStatus.Success;
	}
}
