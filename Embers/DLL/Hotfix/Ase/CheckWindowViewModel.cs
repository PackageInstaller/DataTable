using System;
using GameFramework.Runtime;

namespace Ase;

public class CheckWindowViewModel : ViewModelBase
{
	private string content;

	public Action OnConfirm;

	private Action actionCache;

	public string Content
	{
		get
		{
			return content;
		}
		set
		{
			Set(ref content, value, "Content");
		}
	}

	public void RegAction(Action action)
	{
		if (action != null)
		{
			OnConfirm = (Action)Delegate.Combine(OnConfirm, action);
			actionCache = action;
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (actionCache != null)
		{
			OnConfirm = (Action)Delegate.Remove(OnConfirm, actionCache);
		}
		base.Dispose(disposing);
	}
}
