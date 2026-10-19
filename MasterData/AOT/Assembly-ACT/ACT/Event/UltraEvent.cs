using Bamboo.ECS;

namespace ACT.Event;

public class UltraEvent : BaseEventContent
{
	public Entity entity;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entity = default;
	}
}
