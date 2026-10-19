namespace ACT.Model;

public class PerfectDodgeEventData : CharacterTutorialEventData
{
	private int _characterId;

	public int CharacterId => _characterId;

	public PerfectDodgeEventData(int characterId)
	{
		_characterId = characterId;
	}
}
