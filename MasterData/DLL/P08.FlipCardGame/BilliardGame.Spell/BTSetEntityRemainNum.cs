using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTSetEntityRemainNum : BActionNode
{
	public int num;

	public int buffID;

	public override BTNodeStatus Run(BTEnv env)
	{
		BTEnv buff = (env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityPlayer).GetBuff(buffID);
		if (buff == null)
		{
			return BTNodeStatus.Failure;
		}
		buff.AddStruct("RemainNumber", num);
		return BTNodeStatus.Success;
	}
}
