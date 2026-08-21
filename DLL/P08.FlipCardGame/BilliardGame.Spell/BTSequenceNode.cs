namespace BilliardGame.Spell;

public class BTSequenceNode : BParentNode
{
	public bool isIgnoreFailure;

	public override bool CanExecute(BTEnv env)
	{
		BTNodeContext context = env.GetContext(nodeIdx);
		if (isIgnoreFailure)
		{
			return context.curChildIndex < nextNodes.Count;
		}
		if (context.curChildIndex < nextNodes.Count)
		{
			return context.Status != BTNodeStatus.Failure;
		}
		return false;
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
