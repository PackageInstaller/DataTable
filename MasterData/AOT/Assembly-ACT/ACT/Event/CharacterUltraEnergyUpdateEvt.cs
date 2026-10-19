using Bamboo.ECS;

namespace ACT.Event;

public class CharacterUltraEnergyUpdateEvt : BaseEventContent
{
	public Entity entity;

	public int characterId;

	public float ultraEnergyVal;

	public float ultraEnergyPercent;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entity = default;
		characterId = 0;
		ultraEnergyVal = 0f;
		ultraEnergyPercent = 0f;
	}
}
