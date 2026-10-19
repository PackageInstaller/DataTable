using Bamboo.ECS;

namespace ACT.Battle;

internal sealed class EntityTagDefenseStateSource : IDefenseStateSource
{
	public void Collect(Entity target, ref DefenseStateSnapshot snapshot)
	{
		if (target.InTag(EntityTag.IgnoreAttack))
		{
			snapshot.Flags |= DefenseStateFlags.TrueInvincible;
		}
	}
}
