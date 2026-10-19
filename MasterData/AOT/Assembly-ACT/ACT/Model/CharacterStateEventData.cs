namespace ACT.Model;

public class CharacterStateEventData : CharacterTutorialEventData
{
	private int _characterId;

	public string _characterStateName;

	public int CharacterId => _characterId;

	public string CharacterStateName => _characterStateName;

	public CharacterStateEventData(int characterId, string characterStateName)
	{
		_characterId = characterId;
		_characterStateName = characterStateName;
	}
}
