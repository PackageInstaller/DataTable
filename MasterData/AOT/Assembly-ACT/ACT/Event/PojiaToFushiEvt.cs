using Bamboo.ECS;

namespace ACT.Event;

public class PojiaToFushiEvt : BaseEventContent
{
	public Entity entity;

	public override void ReleaseEvt()
	{
		entity = default;
		base.ReleaseEvt();
	}
}
