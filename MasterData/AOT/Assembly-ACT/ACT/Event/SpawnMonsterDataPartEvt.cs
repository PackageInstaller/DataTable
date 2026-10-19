using Bamboo.ECS;

namespace ACT.Event;

public class SpawnMonsterDataPartEvt : BaseEventContent
{
	public Entity entityBehave;

	public override void ReleaseEvt()
	{
		entityBehave = default;
	}
}
