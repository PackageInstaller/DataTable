using System.Collections.Generic;

namespace Ase;

public class SailEventInfo
{
	public long Uid;

	public int EventId;

	public long StartTime;

	public List<int> heroIds;

	public bool IsFinish;

	public bool IsRewarded;
}
