namespace ACT.Model;

public class PerfectDodgeSuccessCondition : IOperateNodeSuccessCondition
{
	private CharacterTutorialTargetMatcher _targetMatcher;

	public PerfectDodgeSuccessCondition(CharacterTutorialTargetMatcher targetMatcher)
	{
		_targetMatcher = targetMatcher;
	}

	public bool CanHandle(CharacterTutorialEventData evt)
	{
		if (evt is PerfectDodgeEventData perfectDodgeEventData)
		{
			return _targetMatcher.Matches(perfectDodgeEventData.CharacterId);
		}
		return false;
	}

	public bool IsSuccess(CharacterTutorialEventData evt)
	{
		if (evt is PerfectDodgeEventData perfectDodgeEventData)
		{
			return _targetMatcher.Matches(perfectDodgeEventData.CharacterId);
		}
		return false;
	}

	public bool IsSuccessOnEnter()
	{
		return false;
	}
}
