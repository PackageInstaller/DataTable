using System;

namespace ACT.Event;

[Obsolete("废弃别用这个了，现在数据都存下来了，G.localPlayer直接拿")]
public class ExpChangesEvt : BaseEventContent
{
	public int beforeLevel;

	public int addExp;

	public int currentLevel;

	public long currentExp;

	public long beforeExp;
}
