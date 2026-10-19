using Bamboo.Collections;

namespace ACT.Event;

public class KeyPointChange : BaseEventContent
{
	public BSet<int> keys;
}
