using Bamboo.ECS;

namespace ACT.Event;

public class CharacterMotionEnterLadder : BaseEventContent
{
	public Entity entity;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entity = default;
	}
}
