namespace BilliardGame.Spell;

public class BTAddSpeedNode : BActionNode
{
	public float speed;

	public override BTNodeStatus Run(BTEnv env)
	{
		env.AddStruct("speed", speed);
		return BTNodeStatus.Success;
	}
}
