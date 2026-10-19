using System;
using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle;

public interface IEntities
{
	EntityFactory factory { get; }

	event Action<Entity> OnEntityCreate;

	event Action<Entity> OnEntityBeforeDestroy;

	void ForEachEntities(Action<Entity> callback);

	void GetAllEntities(List<Entity> output);

	IEnumerable<Entity> GetAllEntities();

	Entity GetEntity(EntityId id);
}
