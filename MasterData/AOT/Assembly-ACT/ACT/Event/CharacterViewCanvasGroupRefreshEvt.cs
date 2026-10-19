namespace ACT.Event;

public class CharacterViewCanvasGroupRefreshEvt : BaseEventContent
{
	public float alphaValue;

	public override void ReleaseEvt()
	{
		alphaValue = 0f;
	}
}
