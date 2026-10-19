using Bamboo.ECS;

namespace ACT.Event;

public class SpawnCharacterBattlePartEvt : BaseEventContent
{
	public Entity entityBehave;

	public override void ReleaseEvt()
	{
		entityBehave = default;
	}
}
