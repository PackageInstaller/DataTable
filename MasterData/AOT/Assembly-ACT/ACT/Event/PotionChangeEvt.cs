using ACT.Game.Data;
using Google.Protobuf.Collections;

namespace ACT.Event;

public class PotionChangeEvt : BaseEventContent
{
	public MapField<int, PotionItem> potionItems;

	public int sceneIndex;
}
