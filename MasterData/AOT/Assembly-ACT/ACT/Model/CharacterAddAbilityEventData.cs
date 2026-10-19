namespace ACT.Model;

public class CharacterAddAbilityEventData : CharacterTutorialEventData
{
	private int _characterId;

	private string _abilityName;

	public int CharacterId => _characterId;

	public string AbilityName => _abilityName;

	public CharacterAddAbilityEventData(int characterId, string abilityName)
	{
		_characterId = characterId;
		_abilityName = abilityName;
	}
}
