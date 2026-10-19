using ACT.Battle;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class BaseUIViewInputController : BaseUIViewInputController<BaseUIView>
{
}
public abstract class BaseUIViewInputController<T> : ComponentInputController<T> where T : BaseUIComponent, IBaseUIView
{
	private void RefreshPromptIcon()
	{
		IOperatePromptIconCollectionProvider view = View;
		if (view != null && !View.IsDestroyed)
		{
			view.Refresh();
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

	[GameInputBindingBool("UI/Esc")]
	protected virtual void OnEscPressed(bool value)
	{
		if (!(View == null))
		{
			_ = View.isEmpty;
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected virtual void OnBackPressed(bool value)
	{
		if (!(View == null) && !View.isEmpty && !value)
		{
			View.Close();
		}
	}

	protected void StopActionPropagation(string action)
	{
		Singleton<GameInputActionManager>.instance.StopActionPropagation(action);
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
		((IOperatePromptIconCollectionProvider)View)?.InitCollection();
	}

	protected virtual void OnActivate()
	{
	}

	protected void RegisterInputEvents()
	{
		this.BindInputAction();
	}

	public sealed override void Deactivate()
	{
		IsActive = false;
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("---DebugTest----UnregisterInputEvents+By" + GetType().Name + "View" + View);
		}
		UnregisterInputEvents();
		OnDeactivate();
	}

	protected virtual void OnDeactivate()
	{
	}

	protected virtual void UnregisterInputEvents()
	{
		this.UnbindInputAction();
	}

	public bool CanOpenNextView(bool checkOutside = true, SystemType checkSystemType = SystemType.None)
	{
		return (checkSystemType == SystemType.None || Singleton<SystemUnlockManager>.instance.IsSystemUnlock(checkSystemType)) & checkOutside;
	}
}
