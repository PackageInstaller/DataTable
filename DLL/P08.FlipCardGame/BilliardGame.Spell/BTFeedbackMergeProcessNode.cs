using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTFeedbackMergeProcessNode : BActionNode
{
	public float feedbackRatio;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (env.GetPlayer<BilliardGameEntityBase>("Caster") is EntityPlayer)
		{
			LuaHelper.CallFunction("OnFeedbackMergeProcess", feedbackRatio);
		}
		return BTNodeStatus.Success;
	}
}
