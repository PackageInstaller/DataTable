using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTBubbleNode : BActionNode
{
	public int buffID;

	public int atk;

	public float rad;

	public override BTNodeStatus Run(BTEnv env)
	{
		BTEnv buff = (env.GetPlayer<BilliardGameEntityBase>("Caster") as EntityPlayer).GetBuff(buffID);
		if (buff == null)
		{
			return BTNodeStatus.Failure;
		}
		if (buff.ContainKey("damage"))
		{
			int num = buff.GetStruct<int>("damage");
			buff.AddStruct("damage", num + atk);
		}
		else
		{
			buff.AddStruct("damage", atk);
		}
		if (buff.ContainKey("bubble_radius"))
		{
			float num2 = buff.GetStruct<float>("bubble_radius");
			buff.AddStruct("bubble_radius", num2 + rad);
		}
		else
		{
			buff.AddStruct("bubble_radius", rad);
		}
		return BTNodeStatus.Success;
	}
}
