using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTMakeSpecialEffectNode : BActionNode
{
	public string effectName;

	public float scale;

	public override BTNodeStatus Run(BTEnv env)
	{
		float num = scale;
		if (env.ContainKey("bubble_radius"))
		{
			float num2 = env.GetStruct<float>("bubble_radius");
			num += num2;
		}
		string key = "Caster";
		if (env.ContainKey("Caster"))
		{
			BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>(key);
			if (player is EntityPlayer)
			{
				EntityPlayer entityPlayer = player as EntityPlayer;
				if (entityPlayer.specialEffect != null && entityPlayer.specialEffect.gameObject.activeSelf)
				{
					entityPlayer.specialEffect.AddScale(scale);
				}
				else
				{
					BilliardGameEffect billiardGameEffect = BilliardGameLogicManager.Instance.MakeEffectGo(effectName, player.go, num);
					env.AddObject("effectFx", billiardGameEffect);
					entityPlayer.specialEffect = billiardGameEffect;
				}
			}
		}
		return BTNodeStatus.Success;
	}
}
