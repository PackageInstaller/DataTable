using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class SubUIViewInputController : SubUIViewInputController<SubUIView>, ISubInputController, IInputController, IGameInputBindingHandle
{
}
public abstract class SubUIViewInputController<T> : ComponentInputController<T>, ISubInputController, IInputController, IGameInputBindingHandle where T : IBaseUIComponent
{
	private void RefreshPromptIcon()
	{
		if (View is IOperatePromptIconCollectionProvider operatePromptIconCollectionProvider)
		{
			operatePromptIconCollectionProvider.Refresh();
		}
	}

	protected override void RefreshPromptIcons()
	{
		RefreshPromptIcon();
	}

	protected override void OnEnable()
	{
		RefreshPromptIcon();
	}

	protected override void OnDisable()
	{
		RefreshPromptIcon();
	}

	public sealed override void Activate()
	{
		IsActive = true;
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("---DebugTest----RegisterInputEvents+By" + GetType().Name + "View" + View);
		}
		RegisterInputEvents();
		InitPromptCollection();
		OnActivate();
	}

	private void InitPromptCollection()
	{
		if (View is IOperatePromptIconCollectionProvider operatePromptIconCollectionProvider)
		{
			operatePromptIconCollectionProvider.InitCollection();
		}
	}

	protected virtual void OnActivate()
	{
	}

	protected virtual void RegisterInputEvents()
	{
		this.BindInputAction();
	}

	public sealed override void Deactivate()
	{
		IsActive = false;
		OnDeactivate();
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("---DebugTest----UnregisterInputEvents+By" + GetType().Name + "View" + View);
		}
		UnregisterInputEvents();
	}

	protected virtual void OnDeactivate()
	{
	}

	protected virtual void UnregisterInputEvents()
	{
		this.UnbindInputAction();
	}
}
