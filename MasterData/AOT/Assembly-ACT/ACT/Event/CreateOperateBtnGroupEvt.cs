using Bamboo.ECS;

namespace ACT.Event;

public class CreateOperateBtnGroupEvt : BaseEventContent
{
	public Entity characterEntity;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		characterEntity = default;
	}
}
