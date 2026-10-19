using System;

namespace ACT.MissionSystem;

[Serializable]
public class AddItemActionParam
{
	public int itemId;

	public int itemCount;

	public bool showTip;
}
