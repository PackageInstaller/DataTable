namespace ACT.Event;

public class BattleMainCanvasLayerEvt : BaseEventContent
{
	public int Layer;

	public override void OnGet()
	{
		Layer = 0;
	}
}
