using ACT.Battle;

namespace ACT.UI;

public interface IOperatePromptIconCollection
{
	void Register(OperateBtnPrompt prompt);

	void UnRegister(OperateBtnPrompt prompt);

	IGameInputBindingHandle GetInputBindingHandle();
}
