using System.Collections.Generic;
using ACT.Game.Data;

namespace ACT.Event;

public class CharacterNtfEvt : BaseEventContent
{
	public List<Character> characterChanges { get; set; }
}
