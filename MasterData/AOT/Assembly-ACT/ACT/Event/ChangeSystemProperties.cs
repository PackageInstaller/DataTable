using System.Collections.Generic;
using ACT.Game.Data;

namespace ACT.Event;

public class ChangeSystemProperties : BaseEventContent
{
	public Character traget;

	public int systemSource;

	public Dictionary<int, float> properties;

	public bool isRemove;

	public bool isReplace;

	public override void ReleaseEvt()
	{
		traget = null;
		systemSource = 0;
		isRemove = false;
		isReplace = false;
		properties = null;
	}
}
