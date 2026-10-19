using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle;

internal sealed class AbilityDefenseStateSource : IDefenseStateSource
{
	public void Collect(Entity target, ref DefenseStateSnapshot snapshot)
	{
		if (!target.TryGetCompAbility(out CompAbility component))
		{
			return;
		}
		foreach (KeyValuePair<int, int> item in component.abilityTagCounter)
		{
			if (item.Value > 0)
			{
				snapshot.AddDynamicTagId(item.Key);
			}
		}
	}
}
