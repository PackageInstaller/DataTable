namespace ACT.Model;

public class SwitchCharacterSuccessCondition : IOperateNodeSuccessCondition
{
	private CharacterTutorialTargetMatcher _targetMatcher;

	private bool _includeSwitchSkill;

	public SwitchCharacterSuccessCondition(CharacterTutorialTargetMatcher targetMatcher, bool includeSwitchSkill)
	{
		_targetMatcher = targetMatcher;
		_includeSwitchSkill = includeSwitchSkill;
	}

	public bool CanHandle(CharacterTutorialEventData evt)
	{
		if (evt is SwitchCharacterEventData switchCharacterEventData)
		{
			if (!_includeSwitchSkill)
			{
				return !switchCharacterEventData.SwitchSkill;
			}
			return true;
		}
		return false;
	}

	public bool IsSuccess(CharacterTutorialEventData evt)
	{
		if (evt is SwitchCharacterEventData switchCharacterEventData && (_includeSwitchSkill || !switchCharacterEventData.SwitchSkill))
		{
			return _targetMatcher.Matches(switchCharacterEventData.CharacterId);
		}
		return false;
	}

	public bool IsSuccessOnEnter()
	{
		return false;
	}
}
