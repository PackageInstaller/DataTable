namespace BilliardGame.Spell;

public class BTStartNode : BParentNode
{
	public override bool CanExecute(BTEnv env)
	{
		return env.GetContext(nodeIdx).curChildIndex == 0;
	}

	public override int CurrentChildIndex(BTEnv env)
	{
		return env.GetContext(nodeIdx).curChildIndex;
	}

	public override void OnChildExecuted(BTEnv env, BTNodeStatus childStatus)
	{
		BTNodeContext ctx = env.GetContext(nodeIdx);
		ctx.curChildIndex++;
		ctx.Status = childStatus;
		env.SetContext(nodeIdx, ref ctx);
	}

	public override void OnEnd(BTEnv env)
	{
		BTNodeContext ctx = env.GetContext(nodeIdx);
		ctx.Status = BTNodeStatus.Inactive;
		ctx.curChildIndex = 0;
		env.SetContext(nodeIdx, ref ctx);
	}
}
