using ACT.Battle.Configs;
using ACT.MultiPlayer;
using Bamboo.ECS;

namespace ACT.Battle;

public static class HitLightEffect
{
	public static void Play(Entity attackee, in CmdHit hit)
	{
		if (hit.adjust2AttackTypeTag.HasFlag(Adjust2AttackTypeTag.DotAttack))
		{
			return;
		}
		float duration = (attackee.IsBattleBehaveNotCharacter() ? GameLoader.meta.getHitTime : GameLoader.meta.roleGetHitTime);
		MonoEntity mono = attackee.GetMono();
		if (hit.bodyIndex > 0 && mono.bodyParts[hit.bodyIndex - 1].priority > 0)
		{
			byte priority = mono.bodyParts[hit.bodyIndex - 1].priority;
			BodyPartPriorityHitEffect[] priorityHitEffect = mono.priorityHitEffect;
			for (int i = 0; i < priorityHitEffect.Length; i++)
			{
				BodyPartPriorityHitEffect bodyPartPriorityHitEffect = priorityHitEffect[i];
				if (priority == bodyPartPriorityHitEffect.priority)
				{
					mono.aniControl.ForwardPlay(bodyPartPriorityHitEffect.partType, duration, attackee, null, reset: true);
					if (!string.IsNullOrEmpty(bodyPartPriorityHitEffect.trigger))
					{
						mono.entity.SetTrigger(bodyPartPriorityHitEffect.trigger);
					}
				}
			}
		}
		else
		{
			mono.aniControl.ForwardPlay(hit.isPostureHit ? AniPartControl.PartType.LightHit : AniPartControl.PartType.GetHit, duration, attackee, null, reset: true);
		}
	}
}
