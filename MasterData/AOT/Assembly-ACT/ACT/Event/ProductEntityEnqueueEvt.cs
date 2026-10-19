using Bamboo.ECS;

namespace ACT.Event;

public class ProductEntityEnqueueEvt : BaseEventContent
{
	public Entity entityReference;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entityReference = default;
	}
}
