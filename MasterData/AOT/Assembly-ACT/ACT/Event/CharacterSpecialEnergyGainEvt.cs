using Bamboo.ECS;

namespace ACT.Event;

public class CharacterSpecialEnergyGainEvt : BaseEventContent
{
	public Entity entity;

	public int characterId;

	public float gainedValue;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entity = default;
		characterId = 0;
		gainedValue = 0f;
	}
}
