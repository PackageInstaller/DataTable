using System.Collections.Generic;
using Entitas;

[Sim]
public class EntityCD : IComponent, IComponentReset
{
	public HashSet<int> mAward;

	public HashSet<int> mIgnore;

	public List<AbilityCD> mAbilityCD;

	public Dictionary<int, AbilityMaxCDInfo> mAbilityMaxCD;

	public Dictionary<int, int> mAbilityMaxUse;

	public void Reset(Entity entity)
	{
		mAward.Clear();
		mIgnore.Clear();
		mAbilityCD.Clear();
		mAbilityMaxCD.Clear();
		mAbilityMaxUse.Clear();
	}
}
