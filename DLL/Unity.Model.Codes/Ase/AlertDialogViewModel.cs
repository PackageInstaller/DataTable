using System;
using GameFramework.Runtime;

namespace Ase;

public class AlertDialogViewModel : ViewModelBase
{
	protected string title;

	protected string message;

	protected string confirmButtonText;

	protected string neutralButtonText;

	protected string cancelButtonText;

	protected bool canceledOnTouchOutside;

	protected bool canceledOnTop;

	protected bool closed;

	protected int result;

	protected Action<int> click;

	public virtual string Title
	{
		get
		{
			return title;
		}
		set
		{
			Set(ref title, value, "Title");
		}
	}

	public virtual string Message
	{
		get
		{
			return message;
		}
		set
		{
			Set(ref message, value, "Message");
		}
	}

	public virtual string ConfirmButtonText
	{
		get
		{
			return confirmButtonText;
		}
		set
		{
			Set(ref confirmButtonText, value, "ConfirmButtonText");
		}
	}

	public virtual string NeutralButtonText
	{
		get
		{
			return neutralButtonText;
		}
		set
		{
			Set(ref neutralButtonText, value, "NeutralButtonText");
		}
	}

	public virtual string CancelButtonText
	{
		get
		{
			return cancelButtonText;
		}
		set
		{
			Set(ref cancelButtonText, value, "CancelButtonText");
		}
	}

	public virtual bool CanceledOnTouchOutside
	{
		get
		{
			return canceledOnTouchOutside;
		}
		set
		{
			Set<bool>(ref canceledOnTouchOutside, value, "CanceledOnTouchOutside");
		}
	}

	public virtual bool CanceledOnTop
	{
		get
		{
			return canceledOnTop;
		}
		set
		{
			Set<bool>(ref canceledOnTop, value, "CanceledOnTop");
		}
	}

	public virtual Action<int> Click
	{
		get
		{
			return click;
		}
		set
		{
			Set(ref click, value, "Click");
		}
	}

	public virtual bool Closed
	{
		get
		{
			return closed;
		}
		protected set
		{
			Set<bool>(ref closed, value, "Closed");
		}
	}

	public virtual int Result => result;

	public virtual void OnClick(int which)
	{
		try
		{
			result = which;
			Click?.Invoke(which);
		}
		catch (Exception)
		{
		}
		finally
		{
			Closed = true;
		}
	}
}
