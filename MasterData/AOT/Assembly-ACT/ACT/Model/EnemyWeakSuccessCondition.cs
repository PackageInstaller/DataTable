namespace ACT.Model;

public class EnemyWeakSuccessCondition : IOperateNodeSuccessCondition
{
	public bool CanHandle(CharacterTutorialEventData evt)
	{
		return evt is EnemyWeakEventData;
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
