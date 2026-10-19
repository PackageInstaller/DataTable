namespace ACT.UI;

public interface IBattleMainComponent
{
	void Initialize(MonoBattleMainBaseView view);

	void UnInitialize();

	void OpenComponent();

	void CloseComponent();

	void PushStack();

	void PopStack();
}
