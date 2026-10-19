namespace ACT.UI;

public interface IOperatePromptIconCollectionProvider
{
	IOperatePromptIconCollection GetPromptCollection();

	void RegisterPrompt(OperateBtnPrompt prompt);

	void CancelPromptRegistration(OperateBtnPrompt prompt);

	void InitCollection();

	void UnInitCollection();

	void Refresh();
}
