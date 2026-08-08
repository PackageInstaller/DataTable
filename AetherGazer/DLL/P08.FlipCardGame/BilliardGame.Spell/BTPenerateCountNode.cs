using BilliardGame.Runtime;
using Unity.Mathematics;

namespace BilliardGame.Spell;

public class BTPenerateCountNode : BActionNode
{
	public enum PenerateType
	{
		atk,
		radius,
		bullet
	}

	public PenerateType type;

	public int penerateAtk;

	public float penerateRadius;

	public int penerateAddBulletNum;

	public int penerateMaxBulletNum;

	public int penerateMinNum;

	public int buffID;

	private int buffCount;

	private int addDamage;

	private float addRadius;

	private BTEnv targetBuff;

	public override BTNodeStatus Run(BTEnv env)
	{
		BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>("Caster");
		targetBuff = player.GetBuff(buffID);
		int num = buffCount;
		int num2 = (env.ContainKey("penerate_num") ? env.GetStruct<int>("penerate_num") : 0) / penerateMinNum;
		if (targetBuff != null && num2 > num)
		{
			buffCount = num2;
			if (type == PenerateType.atk)
			{
				addDamage += penerateAtk;
				if (targetBuff.ContainKey("damage"))
				{
					int num3 = targetBuff.GetStruct<int>("damage");
					targetBuff.AddStruct("damage", num3 + penerateAtk);
				}
				else
				{
					targetBuff.AddStruct("damage", addDamage);
				}
			}
			else if (type == PenerateType.radius)
			{
				addRadius += penerateRadius;
				if (targetBuff.ContainKey("bubble_radius"))
				{
					float num4 = targetBuff.GetStruct<float>("bubble_radius");
					targetBuff.AddStruct("bubble_radius", num4 + penerateRadius);
				}
				else
				{
					targetBuff.AddStruct("bubble_radius", penerateRadius);
				}
			}
			else if (type == PenerateType.bullet)
			{
				if (targetBuff.ContainKey("penerate_add_bullet"))
				{
					int num5 = targetBuff.GetStruct<int>("penerate_add_bullet");
					if (num5 < penerateMaxBulletNum)
					{
						int value = math.min(num5 + penerateAddBulletNum * buffCount, penerateMaxBulletNum);
						targetBuff.AddStruct("penerate_add_bullet", value);
					}
				}
				else
				{
					targetBuff.AddStruct("penerate_add_bullet", penerateAddBulletNum);
				}
			}
		}
		if (env.ContainKey("penerate_num"))
		{
			env.AddStruct("penerate_num", env.GetStruct<int>("penerate_num") + 1);
		}
		else
		{
			env.AddStruct("penerate_num", 1);
		}
		return BTNodeStatus.Success;
	}

	public override void OnBehaviorRestart(BTEnv env)
	{
		env.Remove("penerate_num", out var value);
		if (targetBuff != null && targetBuff.isRunning)
		{
			if (targetBuff.ContainKey("damage"))
			{
				int num = targetBuff.GetStruct<int>("damage");
				targetBuff.AddStruct("damage", num - addDamage);
				addDamage = 0;
			}
			if (targetBuff.ContainKey("bubble_radius"))
			{
				float num2 = targetBuff.GetStruct<float>("bubble_radius");
				targetBuff.AddStruct("bubble_radius", num2 - addRadius);
				addRadius = 0f;
			}
			if (targetBuff.ContainKey("penerate_add_bullet"))
			{
				targetBuff.Remove("penerate_add_bullet", out value);
			}
		}
	}
}
