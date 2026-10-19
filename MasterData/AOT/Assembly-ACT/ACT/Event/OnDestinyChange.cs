using System.Collections.Generic;
using ACT.Config;
using ACT.Game.Data;

namespace ACT.Event;

public class OnDestinyChange : BaseEventContent
{
	public Character character;

	public int destinySkillId;

	public List<Properties> properties;

	public bool isRemove;

	public override void ReleaseEvt()
	{
		character = null;
		destinySkillId = 0;
		isRemove = false;
		properties = null;
	}
}
