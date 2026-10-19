namespace ACT.EventTrack;

public class GuideTutorialEvent : TrackBaseEvt<GuideTutorialEvent>
{
	public int tutorialId;

	public int type;

	public int op;

	public bool isRednote;

	public override void OnDispatch()
	{
		base.OnDispatch();
		if (tutorialId != 0 && EventConfigs.EventDictionary.TryGetValue("guidetutorial_event", out var value))
		{
			value["tutorial_id"] = tutorialId;
			value["type"] = type;
			value["op"] = op;
			value["is_rednote"] = isRednote;
			Send("guidetutorial_event", value);
		}
	}
}
