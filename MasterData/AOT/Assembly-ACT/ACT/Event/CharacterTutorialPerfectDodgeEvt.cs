namespace ACT.Event;

public class CharacterTutorialPerfectDodgeEvt : BaseEventContent
{
	public int characterId;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		characterId = 0;
	}
}
