namespace BilliardGame.Spell;

public class BTRepeatNode : BDecoratorNode
{
	public int count = 1;

	public bool repeatForever;

	public bool endOnFailure;

	public override bool CanExecute(BTEnv env)
	{
		BTNodeContext context = env.GetContext(nodeIdx);
		if (repeatForever || context.executionCount < count)
		{
			if (endOnFailure)
			{
				if (endOnFailure)
				{
					return context.Status != BTNodeStatus.Failure;
				}
				return false;
			}
			return true;
		}
		return false;
	}

	public override void OnChildExecuted(BTEnv env, BTNodeStatus childStatus)
	{
		BTNodeContext ctx = env.GetContext(nodeIdx);
		ctx.executionCount++;
		ctx.Status = childStatus;
		env.SetContext(nodeIdx, ref ctx);
	}

	public override void OnEnd(BTEnv env)
	{
		BTNodeContext ctx = env.GetContext(nodeIdx);
		ctx.Status = BTNodeStatus.Inactive;
		ctx.curChildIndex = 0;
		ctx.executionCount = 0;
		env.SetContext(nodeIdx, ref ctx);
	}
}
