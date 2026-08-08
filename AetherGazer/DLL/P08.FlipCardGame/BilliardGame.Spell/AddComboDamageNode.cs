namespace BilliardGame.Spell;

public class AddComboDamageNode : BActionNode
{
	public int comboCount;

	public int addAtk;

	public override BTNodeStatus Run(BTEnv env)
	{
		env.AddLinkedStruct("add_combo_damage", comboCount, addAtk);
		return BTNodeStatus.Success;
	}
}
