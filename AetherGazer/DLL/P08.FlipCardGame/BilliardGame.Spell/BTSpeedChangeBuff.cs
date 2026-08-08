namespace BilliardGame.Spell;

public class BTSpeedChangeBuff : BActionNode
{
	public int speedChange;

	public int buffId;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (buffId != 0)
		{
			env.AddLinkedStruct("speed_change_buff", speedChange, buffId);
		}
		return BTNodeStatus.Success;
	}
}
