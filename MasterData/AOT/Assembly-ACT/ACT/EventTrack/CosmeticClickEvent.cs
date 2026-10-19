namespace ACT.EventTrack;

public class CosmeticClickEvent : TrackBaseEvt<CosmeticClickEvent>
{
	public int cosmeticId;

	public int quality;

	public int status;

	public int cosmeticType;

	public int characterId;

	public bool isGlobal;

	public override void OnDispatch()
	{
		if (EventConfigs.EventDictionary.TryGetValue("cosmetic_click", out var value))
		{
			value["cosmetic_id"] = cosmeticId;
			value["quality"] = quality;
			value["status"] = status;
			value["cosmetic_type"] = cosmeticType;
			value["character_id"] = characterId;
			value["is_global"] = isGlobal;
			Send("cosmetic_click", value);
		}
	}
}
