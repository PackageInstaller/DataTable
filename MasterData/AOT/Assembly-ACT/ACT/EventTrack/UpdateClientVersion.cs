namespace ACT.EventTrack;

public class UpdateClientVersion : TrackBaseEvt<UpdateClientVersion>
{
	public string targetVersion;

	public int type;

	public int result;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (EventConfigs.EventDictionary.TryGetValue("update_client_version", out var value))
		{
			value["result"] = result;
			value["type"] = type;
			value["target_version"] = targetVersion;
			Send("update_client_version", value);
		}
	}
}
