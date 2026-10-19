using ACT.Model;

namespace ACT.Event;

public class RogueComposeCardEvent : BaseEventContent
{
	public RogueCard baseCard1;

	public RogueCard baseCard2;

	public RogueCard composeCard;
}
