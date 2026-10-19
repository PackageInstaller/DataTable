namespace ACT.UI;

public class SubUIView : SubUIView<SubUIViewInputController>
{
}
public abstract class SubUIView<T> : BaseUIComponent<T>, ISubUIView<T>, ISubUIView, IBaseUIComponent where T : class, ISubInputController, new()
{
	public bool IsFocused { get; private set; }

	public IInputController InputController => GetInputBindingController();

	protected virtual void OnEnable()
	{
		((IOperatePromptIconCollectionProvider)this).InitCollection();
	}

	protected virtual void OnDisable()
	{
		((IOperatePromptIconCollectionProvider)this).UnInitCollection();
	}

	public void FocusIn()
	{
		IsFocused = true;
		ParentUIView.ActivateSubView(this);
		OnFocusIn();
	}

	public sealed override IInputController GetInputBindingController()
	{
		return CreateInputBindingController();
	}

	protected virtual void OnFocusIn()
	{
	}

	void ISubUIView.ActivateInputController()
	{
		GetInputBindingController().Activate();
	}

	public void FocusOut()
	{
		IsFocused = false;
		ParentUIView.DeactivateSubViewInput(this);
		OnFocusOut();
	}

	protected virtual void OnFocusOut()
	{
	}

	void ISubUIView.DeactivateInputController()
	{
		GetController()?.Deactivate();
	}
}
