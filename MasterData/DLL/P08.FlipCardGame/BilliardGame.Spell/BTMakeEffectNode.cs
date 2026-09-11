using BilliardGame.Runtime;

namespace BilliardGame.Spell;

public class BTMakeEffectNode : BActionNode
{
	public EffectPos effectPos;

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
		if ((effectPos == EffectPos.Other || effectPos == EffectPos.OtherPersistent) && env.ContainKey("TargetEntity"))
		{
			key = "TargetEntity";
		}
		BilliardGameEntityBase player = env.GetPlayer<BilliardGameEntityBase>(key);
		if (effectPos == EffectPos.Self || effectPos == EffectPos.Other)
		{
			BilliardGameLogicManager.Instance.MakeEffectWorld(effectName, player.position, num);
		}
		else if (effectPos == EffectPos.SelfPersistent || effectPos == EffectPos.OtherPersistent)
		{
			if (env.ContainKey("effectFx"))
			{
				env.GetObject<BilliardGameEffect>("effectFx").Die();
			}
			BilliardGameEffect value = BilliardGameLogicManager.Instance.MakeEffectGo(effectName, player.go, num);
			env.AddObject("effectFx", value);
		}
		else if (effectPos == EffectPos.Collision)
		{
			BilliardGameLogicManager.Instance.MakeEffectWorld(effectName, player.position, num);
		}
		else
		{
			BilliardGameLogicManager.Instance.MakeEffectWorld(effectName, player.position, num);
		}
		return BTNodeStatus.Success;
	}
}
