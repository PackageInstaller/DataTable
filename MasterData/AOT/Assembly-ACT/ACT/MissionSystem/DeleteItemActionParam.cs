using System;

namespace ACT.MissionSystem;

[Serializable]
public class DeleteItemActionParam
{
	public int itemId;

	public int itemCount;

	public bool showTip;
}
