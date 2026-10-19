using System;

namespace ACT.UI;

[Serializable]
public class MonoRaidViewData : UIViewData
{
	public int RaidEntranceId;

	public int RaidId;

	public Action OnClose;
}
