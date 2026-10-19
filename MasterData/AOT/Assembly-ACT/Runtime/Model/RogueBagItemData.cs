using ACT.Game.Data;

namespace Runtime.Model;

public class RogueBagItemData
{
	public RogueItem RogueItem;

	public int RogueItemType;

	public int CharacterId;

	public RogueBagItemData(int _itemId, int _rogueItemType, int _pos, int _characterId = 0)
	{
		RogueItem = new RogueItem
		{
			ItemId = _itemId,
			Position = _pos
		};
		RogueItemType = _rogueItemType;
		CharacterId = _characterId;
	}
}
