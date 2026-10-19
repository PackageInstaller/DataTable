using System;

namespace Lumin.LoungeSystem;

[Serializable]
public class InteractionRecord
{
	public int characterId;

	public LoungeDefine.InteractionType interactionType;

	public DateTime timestamp;

	public int favorValueGained;

	public string details;

	public InteractionRecord(int charId, LoungeDefine.InteractionType type, int favor)
	{
		characterId = charId;
		interactionType = type;
		timestamp = DateTime.Now;
		favorValueGained = favor;
	}
}
