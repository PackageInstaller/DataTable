using System;

namespace ACT.Event;

public class OnceCollectionChangeEvt : BaseEventContent
{
	public int id;

	public int newCount;

	[Obsolete]
	public int rawCount;
}
