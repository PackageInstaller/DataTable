using Bamboo.ECS;

namespace ACT.Event;

public class BattleCharacterChangeEvt : BaseEventContent
{
	public Entity lastEb;

	public Entity newEb;

	public int index;

	public bool switchSkill;
}
