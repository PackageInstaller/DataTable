using System;
using System.Collections.Generic;
using ACT.Battle;

namespace ACT.UI;

public abstract class ComponentInputController<T> : IInputController<T>, IInputController, IGameInputBindingHandle where T : IBaseUIComponent
{
	HashSet<string> IGameInputBindingHandle.ActionWhiteList { get; set; }

	public bool IsDisposed => View.IsDestroyed;

	public bool IsEnabled { get; private set; }

	public virtual bool BlockElderHandle => false;

	public IBaseUIController ParentUIController { get; private set; }

	IBaseUIController IInputController.GetUIController => View.GetUIController();

	public T View { get; private set; }

	int IGameInputBindingHandle.Priority => GetPriority();

	HashSet<string> IGameInputBindingHandle.ActionDisableList { get; } = new HashSet<string>();

	public bool IsActive { get; set; }

	void IGameInputBindingHandle.RefreshPromptIcons()
	{
		RefreshPromptIcons();
	}

	protected abstract void RefreshPromptIcons();

	void IGameInputBindingHandle.Enable()
	{
		if (!IsEnabled)
		{
			IsEnabled = true;
			OnEnable();
		}
	}

	protected abstract void OnEnable();

	void IGameInputBindingHandle.Disable()
	{
		if (IsEnabled)
		{
			IsEnabled = false;
			OnDisable();
		}
	}

	protected abstract void OnDisable();

	void IInputController.InitView(IBaseUIComponent view)
	{
		if (view is T view2)
		{
			((IInputController<T>)this).Init(view2);
			return;
		}
		throw new ArgumentException($"Invalid view type. Expected {typeof(T)}, got {view.GetType()}");
	}

	public void SetParentUIController(IBaseUIController parent)
	{
		ParentUIController = parent;
	}

	void IInputController<T>.Init(T view)
	{
		View = view;
		OnInitView(view);
	}

	protected virtual void OnInitView(T view)
	{
	}

	protected virtual int GetPriority()
	{
		return 0;
	}

	public virtual void Activate()
	{
		IsActive = true;
	}

	public virtual void Deactivate()
	{
		IsActive = false;
	}

	public virtual void OnInputDeviceChange(DeviceInputMode type)
	{
	}
}
