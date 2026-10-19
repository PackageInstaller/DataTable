using Bamboo.ECS;

namespace ACT.Event;

public class BattleCharacterDieEvt : BaseEventContent
{
	public Entity targetEb;

	public int characterId;
}
