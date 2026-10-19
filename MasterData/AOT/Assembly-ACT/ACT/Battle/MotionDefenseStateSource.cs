using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

internal sealed class MotionDefenseStateSource : IDefenseStateSource
{
	public void Collect(Entity target, ref DefenseStateSnapshot snapshot)
	{
		if (target.TryGetCompMotion(out CompMotion component))
		{
			if (component.InTag(MotionTag_backUp.Invincibility))
			{
				snapshot.Flags |= DefenseStateFlags.Invincible;
			}
			if (component.InTag(MotionTag_backUp.TrueInvincible))
			{
				snapshot.Flags |= DefenseStateFlags.TrueInvincible;
			}
			if (component.InTag(MotionTag_backUp.BlockThrow))
			{
				snapshot.Flags |= DefenseStateFlags.BlockThrow;
			}
		}
	}
}
