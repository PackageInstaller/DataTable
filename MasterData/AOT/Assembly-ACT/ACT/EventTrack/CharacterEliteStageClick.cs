namespace ACT.EventTrack;

public class CharacterEliteStageClick : TrackBaseEvt<CharacterEliteStageClick>
{
	public int characterId;

	public int characterLevel;

	public int eliteStage;

	public int eliteLevel;

	public int eliteStageId;

	public int status;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("character_elite_stage_click", out var value))
		{
			value["character_id"] = characterId;
			value["character_level"] = characterLevel;
			value["elite_stage"] = eliteStage;
			value["elite_level"] = eliteLevel;
			value["elite_stage_id"] = eliteStageId;
			value["status"] = status;
			Send("character_elite_stage_click", value);
		}
	}
}
