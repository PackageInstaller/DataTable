namespace ACT.Model;

public class SwitchCharacterEventData : CharacterTutorialEventData
{
	private int _characterId;

	private bool _switchSkill;

	public int CharacterId => _characterId;

	public bool SwitchSkill => _switchSkill;

	public SwitchCharacterEventData(int characterId, bool switchSkill)
	{
		_characterId = characterId;
		_switchSkill = switchSkill;
	}
}
