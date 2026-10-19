namespace ACT.EventTrack;

public class ClientErrorCode : TrackBaseEvt<ClientErrorCode>
{
	public string errorCode;

	public string systemModule;

	public int rank;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("client_error_code", out var value))
		{
			value["error_code"] = errorCode;
			value["system_module"] = systemModule;
			value["rank"] = rank;
			Send("client_error_code", value);
		}
	}
}
