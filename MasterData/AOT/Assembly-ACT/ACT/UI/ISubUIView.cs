namespace ACT.UI;

public interface ISubUIView<T> : ISubUIView, IBaseUIComponent where T : ISubInputController
{
	T GetController();
}
public interface ISubUIView : IBaseUIComponent
{
	IInputController InputController { get; }

	void ActivateInputController();

	void DeactivateInputController();

	void FocusOut();

	void FocusIn();
}
