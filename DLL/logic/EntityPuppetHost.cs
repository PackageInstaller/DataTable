using System.Collections.Generic;
using Entitas;

[Sim]
public class EntityPuppetHost : IComponent, IComponentReset
{
	public List<int> mPuppets;

	public void Reset(Entity entity)
	{
		mPuppets.Clear();
	}
}
