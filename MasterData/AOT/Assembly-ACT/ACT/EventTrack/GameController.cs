namespace ACT.EventTrack;

public class GameController : TrackBaseEvt<GameController>
{
	public string controllerMode;

	public string brand;

	public int status;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("game_controller", out var value))
		{
			value["controller_mode"] = controllerMode;
			value["brand"] = brand;
			value["status"] = status;
			if (!string.IsNullOrWhiteSpace(brand) || !string.IsNullOrWhiteSpace(controllerMode))
			{
				Send("game_controller", value);
			}
		}
	}
}
