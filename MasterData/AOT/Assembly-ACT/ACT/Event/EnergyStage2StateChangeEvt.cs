using System;
using ACT.UI;
using Bamboo.ECS;

namespace ACT.Event;

[Obsolete]
public class EnergyStage2StateChangeEvt : BaseEventContent
{
	public EntityId entityId;

	public int state;

	public CustomUICompType customUICompType;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityId = default;
		customUICompType = CustomUICompType.None;
	}
}
