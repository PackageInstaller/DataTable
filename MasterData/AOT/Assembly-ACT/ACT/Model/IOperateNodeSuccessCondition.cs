namespace ACT.Model;

public interface IOperateNodeSuccessCondition
{
	bool CanHandle(CharacterTutorialEventData evt);

	bool IsSuccess(CharacterTutorialEventData evt);

	bool IsSuccessOnEnter();
}
