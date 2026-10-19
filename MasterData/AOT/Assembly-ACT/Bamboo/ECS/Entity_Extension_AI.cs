using ACT.Battle;

namespace Bamboo.ECS;

public static class Entity_Extension_AI
{
	public static ActBehaviorTree GetBTree(this Entity entity)
	{
		return entity.GetCompAI().ActBehaviorTree;
	}
}
