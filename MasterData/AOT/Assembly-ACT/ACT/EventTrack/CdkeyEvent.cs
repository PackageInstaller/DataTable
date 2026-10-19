namespace ACT.EventTrack;

public class CdkeyEvent : TrackBaseEvt<CdkeyEvent>
{
	public string cdkey;

	public int result;

	public int type;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("cdkey_event", out var value))
		{
			value["cdkey"] = cdkey ?? "-";
			value["result"] = result;
			value["type"] = type;
			Send("cdkey_event", value);
		}
	}
}
