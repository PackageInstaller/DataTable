namespace ACT.Model;

public class EnemyDieSuccessCondition : IOperateNodeSuccessCondition
{
	public bool CanHandle(CharacterTutorialEventData evt)
	{
		return evt is EnemyDieEventData;
	}

	public bool IsSuccess(CharacterTutorialEventData evt)
	{
		return true;
	}

	public bool IsSuccessOnEnter()
	{
		return false;
	}
}
