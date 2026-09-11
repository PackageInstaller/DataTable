namespace BilliardGame.Spell;

public class AddAoeDamageNode : BActionNode
{
	public int addAoeDamage;

	public float addAoeDamageRatio = 1f;

	public override BTNodeStatus Run(BTEnv env)
	{
		env.AddStruct("add_aoe_damage", addAoeDamage);
		env.AddStruct("add_aoe_damage_ratio", addAoeDamageRatio - 1f);
		return BTNodeStatus.Success;
	}
}
