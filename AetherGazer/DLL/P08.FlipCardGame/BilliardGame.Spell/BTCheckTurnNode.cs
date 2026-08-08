namespace BilliardGame.Spell;

public class BTCheckTurnNode : BActionNode
{
	public int turn;

	public int firstTurn;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (!env.ContainKey($"checkTurn_{turn}_{firstTurn}"))
		{
			env.AddStruct($"checkTurn_{turn}_{firstTurn}", 0, isPersistent: true);
		}
		int num = env.GetStruct<int>($"checkTurn_{turn}_{firstTurn}") + 1;
		env.AddStruct($"checkTurn_{turn}_{firstTurn}", num);
		if (num >= firstTurn && (num - firstTurn) % (turn + 1) == 0)
		{
			return BTNodeStatus.Success;
		}
		return BTNodeStatus.Failure;
	}
}
