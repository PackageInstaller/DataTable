namespace ACT.UI;

public interface ILifeCycleUIComponent
{
	bool IsOperating { get; }

	bool IsOpening { get; }

	bool IsClosing { get; }

	bool IsNormal { get; }

	bool IsHidden { get; }

	void Show();

	void PlayShowAnimation();

	void Hide();

	void PlayHideAnimation();

	void HideImmediately();

	protected void ShowStart();

	protected void ShowEnd();

	protected void HideStart();

	protected void HideEnd();
}
