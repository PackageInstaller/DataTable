namespace BilliardGame.Spell;

public class BTIgnoreEnemyCollisionNode : BActionNode
{
	public int penerateDamage;

	public override BTNodeStatus Run(BTEnv env)
	{
		env.AddStruct("ignore_enemy_collision", value: true);
		env.AddStruct("penerate_damage", penerateDamage);
		return BTNodeStatus.Success;
	}
}
