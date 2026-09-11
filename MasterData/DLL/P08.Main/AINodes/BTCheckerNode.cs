using System.Collections.Generic;
using BilliardGame.Spell;

namespace AINodes;

public abstract class BTCheckerNode : BDecoratorNode
{
	public bool revert;

	public bool successAnyway;

	public abstract IEnumerable<string> RequiredParams();

	public abstract bool CheckWillExecute(BTEnv env);

	public sealed override bool CanExecute(BTEnv env)
	{
		if (env.GetContext(nodeIdx).curChildIndex >= 1)
		{
			return false;
		}
		IEnumerable<string> names = RequiredParams();
		if (!BNode.CheckRequiredParamsFromEnv(env, names))
		{
			return false;
		}
		return revert ^ CheckWillExecute(env);
	}

	public override BTNodeStatus OverrideStatus(BTNodeStatus status)
	{
		if (successAnyway && status == BTNodeStatus.Failure)
		{
			return BTNodeStatus.Success;
		}
		return base.OverrideStatus(status);
	}

	public override void OnChildExecuted(BTEnv env, BTNodeStatus childStatus)
	{
		BTNodeContext ctx = env.GetContext(parentIdx);
		ctx.curChildIndex++;
		ctx.Status = childStatus;
		env.SetContext(nodeIdx, ref ctx);
	}

	public sealed override void OnEnd(BTEnv env)
	{
		BTNodeContext ctx = env.GetContext(nodeIdx);
		ctx.Status = BTNodeStatus.Inactive;
		ctx.curChildIndex = 0;
		env.SetContext(nodeIdx, ref ctx);
	}
}
