using ACT.Battle;
using BehaviorDesigner.Runtime;

namespace Bamboo.ECS;

public static class Entity_Extension_BehaviorDesigner
{
	public static Entity ToEntity(this Behavior behavior)
	{
		return (behavior as ActBehaviorTree)?.Entity ?? default(Entity);
	}
}
