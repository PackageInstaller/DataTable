namespace ACT.EventTrack;

public class LoadingError : TrackBaseEvt<LoadingError>
{
	public int type;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("loading_error", out var value))
		{
			value["type"] = type;
			Send("loading_error", value);
		}
	}
}
