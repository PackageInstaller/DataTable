using ACT.Battle;

namespace Bamboo.ECS;

public static class Entity_Extension_AssistNpc
{
	public static void SetNpcId(this Entity entity, int npcId)
	{
		if (entity.TryGetCompAssistNpc(out CompAssistNpc component))
		{
			component.npcId = npcId;
		}
	}
}
