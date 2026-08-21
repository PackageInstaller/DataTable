using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class OptionBase : ViewOptionBase
{
	protected OptionBase parent;

	protected string viewName;

	protected bool isCloseView;

	protected readonly InteractionRequest<bool> visibleRequest;

	protected readonly InteractionRequest dismissRequest;

	protected readonly InteractionRequest<OpenViewArg> openWindowRequest;

	protected readonly InteractionRequest<ShowViewArg> showViewRequest;

	private bool isVisible;

	private List<ViewModelBase> childs = new List<ViewModelBase>();

	public bool IsCloseView => isCloseView;

	public bool IsVisible
	{
		get
		{
			return isVisible;
		}
		set
		{
			Set(ref isVisible, value, "IsVisible");
			OnVisibleChange();
		}
	}

	public OptionBase Parent => parent;

	public IInteractionRequest VisibleRequest => visibleRequest;

	public IInteractionRequest DismissRequest => dismissRequest;

	public InteractionRequest<OpenViewArg> OpenWindowRequest => openWindowRequest;

	public InteractionRequest<ShowViewArg> ShowViewRequest => showViewRequest;

	public OptionBase()
	{
		visibleRequest = new InteractionRequest<bool>();
		dismissRequest = new InteractionRequest();
		openWindowRequest = new InteractionRequest<OpenViewArg>();
		showViewRequest = new InteractionRequest<ShowViewArg>();
	}

	public override void ItemOnClick(object obj)
	{
		OpenViewArg arg = obj as OpenViewArg;
		if (arg != null)
		{
			openWindowRequest.Raise(arg, delegate
			{
				arg.CallBack?.Invoke();
			});
		}
		else if (obj is ViewBackArg arg2)
		{
			RefreshWhenBack(arg2);
		}
	}

	public T AddChild<T>(T childVm) where T : ViewModelBase
	{
		if (childs == null)
		{
			childs = new List<ViewModelBase>();
		}
		childs.Add(childVm);
		return childVm;
	}

	public void RemoveChild<T>(T childVm) where T : ViewModelBase
	{
		if (childs != null)
		{
			childs.Remove(childVm);
		}
	}

	public virtual bool CheckOpen(OptionBase optionBase, JumpWindowParams jumpParams)
	{
		return true;
	}

	public virtual void RefreshWhenBack(ViewBackArg arg)
	{
	}

	public virtual void SetParent(OptionBase parent)
	{
		this.parent = parent;
	}

	public virtual void RemoveParent()
	{
		parent = null;
	}

	public virtual void OnVisibleChange()
	{
		visibleRequest.Raise(isVisible);
	}

	public void Open()
	{
		if (!isCloseView)
		{
			OnOpen();
		}
	}

	public virtual void OnOpen()
	{
	}

	public virtual void Close()
	{
		parent?.ItemOnClick(new ViewBackArg(this));
		dismissRequest.Raise();
		isCloseView = true;
		Dispose();
	}

	public new virtual void Dispose()
	{
		parent = null;
		if (childs != null)
		{
			for (int num = childs.Count - 1; num >= 0; num--)
			{
				childs[num]?.Dispose();
				childs[num] = null;
			}
			childs = null;
		}
		base.Dispose();
	}

	public void SetViewName(string viewName)
	{
		this.viewName = viewName;
	}
}
