using Bamboo.ECS;

namespace ACT.NPC.Actions;

public struct NpcInteractActionContext
{
	public Entity Npc;

	public Entity Other;

	public NpcInteractEntryConfig InteractEntryConfig;

	public int StackDepth;
}
