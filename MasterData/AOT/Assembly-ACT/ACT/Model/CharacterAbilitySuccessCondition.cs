namespace ACT.Model;

public class CharacterAbilitySuccessCondition : IOperateNodeSuccessCondition
{
	private CharacterTutorialTargetMatcher _targetMatcher;

	private string _abilityName;

	public CharacterAbilitySuccessCondition(CharacterTutorialTargetMatcher targetMatcher, string abilityName)
	{
		_targetMatcher = targetMatcher;
		_abilityName = abilityName;
	}

	public bool CanHandle(CharacterTutorialEventData evt)
	{
		if (evt is CharacterAddAbilityEventData characterAddAbilityEventData && _targetMatcher.Matches(characterAddAbilityEventData.CharacterId))
		{
			return characterAddAbilityEventData.AbilityName == _abilityName;
		}
		return false;
	}

	public bool IsSuccess(CharacterTutorialEventData evt)
	{
		if (evt is CharacterAddAbilityEventData characterAddAbilityEventData && _targetMatcher.Matches(characterAddAbilityEventData.CharacterId))
		{
			return characterAddAbilityEventData.AbilityName == _abilityName;
		}
		return false;
	}

	public bool IsSuccessOnEnter()
	{
		return _targetMatcher.HasAbility(_abilityName);
	}
}
