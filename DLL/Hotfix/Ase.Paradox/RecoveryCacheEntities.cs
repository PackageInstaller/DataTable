using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("回收所有缓存实体", 0)]
[Description("回收所有在缓存列表中的实体，并清空缓存列表。")]
[Category("✫ DragonLost/Entity")]
public class RecoveryCacheEntities : ActionTaskBase
{
	[Name("缓存列表", 0)]
	[Description("要回收的实体的ID列表。")]
	public BBParameter<List<int>> cacheEntities;

	protected override void OnExecute()
	{
		base.OnExecute();
		EntitySystem system = ownerEntity.GetSystem<EntitySystem>();
		if (cacheEntities.value == null)
		{
			OnActionFinish();
			return;
		}
		foreach (int item in cacheEntities.value)
		{
			BaseEntity entity = system.GetEntity(item);
			if (entity != null && entity.IsSurvival)
			{
				entity.DoEntityDead();
			}
		}
		cacheEntities.value.Clear();
		OnActionFinish();
	}
}
