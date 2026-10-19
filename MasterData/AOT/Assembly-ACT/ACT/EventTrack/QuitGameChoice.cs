namespace ACT.EventTrack;

public class QuitGameChoice : TrackBaseEvt<QuitGameChoice>
{
	public int type;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("quit_game_choice", out var value))
		{
			value["type"] = type;
			Send("quit_game_choice", value);
		}
	}
}
