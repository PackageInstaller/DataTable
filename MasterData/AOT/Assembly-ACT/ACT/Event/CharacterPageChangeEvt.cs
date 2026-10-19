using System.Threading;
using ACT.Game.Data;

namespace ACT.Event;

public class CharacterPageChangeEvt : BaseEventContent
{
	public int currentPageIndex;

	public Character character;

	public CancellationToken token;
}
