namespace ACT.Event;

public class CharacterTutorialRemoveAbilityEvt : BaseEventContent
{
	public int characterId;

	public string abilityName;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		characterId = 0;
		abilityName = string.Empty;
	}
}
