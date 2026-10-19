using ACT.Core;
using Bamboo.ECS;

namespace ACT.Battle;

internal sealed class PropertyDefenseStateSource : IDefenseStateSource
{
	public void Collect(Entity target, ref DefenseStateSnapshot snapshot)
	{
		if (target.TryGetCompAbility(out CompAbility component))
		{
			Property property = component.GetProperty(100u);
			if (property != null && property.value > 0f)
			{
				snapshot.Flags |= DefenseStateFlags.TrueInvincible;
			}
		}
	}
}
