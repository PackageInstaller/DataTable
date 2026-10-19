using ACT.MultiPlayer;
using Bamboo.ECS;

namespace ACT.Battle;

public static class HitAnimatorParameters
{
	public static void Apply(Entity attackee, in CmdHit hit)
	{
		switch (hit.hitReactionType)
		{
		case HitReactionType.None:
		case HitReactionType.Hit:
			break;
		case HitReactionType.Light:
			attackee.SetTrigger("HitLight");
			break;
		case HitReactionType.Full:
			ApplyFull(attackee, in hit);
			break;
		}
	}

	private static void ApplyFull(Entity attackee, in CmdHit hit)
	{
		attackee.SetBool("HitBack", hit.hitBack);
		if (hit.needLockRotationChangeDirTrigger)
		{
			attackee.SetTrigger("ChangeDir");
		}
		attackee.SetTrigger("Hit");
		if (hit.groundprotection)
		{
			attackee.SetTrigger("HitGroundProtection");
		}
		attackee.SetInt("HitLevel", hit.hitLevel);
		attackee.SetInt("ExpressiveAngle", hit.expressiveAngle);
		attackee.SetFloat("HitAngle", hit.angle);
		attackee.SetFloat("HitSpeed", hit.length);
		attackee.SetFloat("HitSpeedX", hit.hitSpeedX);
		attackee.SetFloat("HitSpeedY", hit.hitSpeedY);
	}
}
