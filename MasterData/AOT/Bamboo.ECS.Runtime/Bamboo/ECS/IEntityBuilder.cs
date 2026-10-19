using System;
using System.Collections.Generic;

namespace Bamboo.ECS;

internal interface IEntityBuilder
{
	Entity BuildEntity(List<ComponentTypeId> componentTypeIds, Dictionary<Type, object> componentInstances, EntityId? specifiedId = null);
}
