namespace ACT.Event;

public class CharacterStateChangeEvt : BaseEventContent
{
	public int characterId;

	public string characterState;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		characterId = 0;
		characterState = string.Empty;
	}
}
