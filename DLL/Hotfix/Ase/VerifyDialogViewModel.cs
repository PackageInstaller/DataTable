using System;
using GameFramework.Runtime;

namespace Ase;

public class VerifyDialogViewModel : ViewModelBase
{
	protected string title;

	protected string message;

	protected string inputFieldTipsText;

	protected string confirmButtonText;

	protected bool canceledOnTouchOutside;

	protected bool closed;

	protected int result;

	protected string verifyMessage;

	protected Action<int, string> click;

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

	public virtual string InputFieldTipsText
	{
		get
		{
			return inputFieldTipsText;
		}
		set
		{
			Set(ref inputFieldTipsText, value, "InputFieldTipsText");
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

	public virtual Action<int, string> Click
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

	public virtual string VerifyMessage => verifyMessage;

	public virtual void OnClick(int which, string str)
	{
		try
		{
			result = which;
			verifyMessage = str;
			Click?.Invoke(which, str);
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
