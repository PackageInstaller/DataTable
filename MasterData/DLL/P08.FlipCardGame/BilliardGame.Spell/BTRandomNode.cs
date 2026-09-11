using UnityEngine;

namespace BilliardGame.Spell;

public class BTRandomNode : BParentNode
{
	public override bool CanExecute(BTEnv env)
	{
		BTNodeContext context = env.GetContext(nodeIdx);
		if (context.randomNodeExecuted <= 0)
		{
			return context.Status != BTNodeStatus.Failure;
		}
		return false;
	}

	public override int CurrentChildIndex(BTEnv env)
	{
		int curChildIndex = Random.Range(0, nextNodes.Count);
		BTNodeContext ctx = env.GetContext(nodeIdx);
		ctx.curChildIndex = curChildIndex;
		env.SetContext(nodeIdx, ref ctx);
		return env.GetContext(nodeIdx).curChildIndex;
	}

	public override void OnChildExecuted(BTEnv env, BTNodeStatus childStatus)
	{
		BTNodeContext ctx = env.GetContext(nodeIdx);
		ctx.randomNodeExecuted++;
		ctx.Status = childStatus;
		env.SetContext(nodeIdx, ref ctx);
	}

	public override void OnEnd(BTEnv env)
	{
		BTNodeContext ctx = env.GetContext(nodeIdx);
		ctx.Status = BTNodeStatus.Inactive;
		ctx.curChildIndex = 0;
		ctx.randomNodeExecuted = 0;
		env.SetContext(nodeIdx, ref ctx);
	}
}
