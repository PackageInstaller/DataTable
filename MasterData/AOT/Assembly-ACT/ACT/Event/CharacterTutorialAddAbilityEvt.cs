using Bamboo.ECS;

namespace ACT.Event;

public class CharacterTutorialAddAbilityEvt : BaseEventContent
{
	public Entity entity;

	public int characterId;

	public string abilityName;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		entity = default;
		characterId = 0;
		abilityName = string.Empty;
	}
}
