namespace ACT.EventTrack;

public class CharacterSkinClickEvent : TrackBaseEvt<CharacterSkinClickEvent>
{
	public int playerLevel;

	public int vipPoint;

	public int characterId;

	public int characterLevel;

	public int characterFavorabilityLevel;

	public int skinId;

	public int status;

	public int cosmeticId;

	public int cosmeticType;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("character_skin_click", out var value))
		{
			value["status"] = status;
			value["cosmetic_id"] = ((cosmeticId != 0) ? cosmeticId : skinId);
			value["cosmetic_type"] = cosmeticType;
			Send("character_skin_click", value);
		}
	}
}
