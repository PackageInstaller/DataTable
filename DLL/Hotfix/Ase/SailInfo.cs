using System.Collections.Generic;

namespace Ase;

public struct SailInfo
{
	public bool IsInit;

	public List<int> EventList;

	public List<SailEventInfo> OldDispatchInfoList;

	public List<SailEventInfo> TodayDispatchInfoList;

	public List<SailEventInfo> onlineList;

	public List<int> SailingHeroList;
}
