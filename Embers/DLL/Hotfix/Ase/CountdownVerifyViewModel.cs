using System;
using Cysharp.Threading.Tasks;

namespace Ase;

public class CountdownVerifyViewModel : OptionBase
{
	private string title;

	private string sender;

	private string action;

	private string target;

	private string confirmText;

	private string confirmEngText;

	private string cancelText;

	private string cancelEngText;

	private int _waitTime;

	private Timer countdownTimer;

	protected int result;

	protected Action<int> click;

	public string Title
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

	public string Sender
	{
		get
		{
			return sender;
		}
		set
		{
			Set(ref sender, value, "Sender");
		}
	}

	public string Action
	{
		get
		{
			return action;
		}
		set
		{
			Set(ref action, value, "Action");
		}
	}

	public string Target
	{
		get
		{
			return target;
		}
		set
		{
			Set(ref target, value, "Target");
		}
	}

	public string ConfirmText
	{
		get
		{
			return confirmText;
		}
		set
		{
			Set(ref confirmText, value, "ConfirmText");
		}
	}

	public string ConfirmEngText
	{
		get
		{
			return confirmEngText;
		}
		set
		{
			Set(ref confirmEngText, value, "ConfirmEngText");
		}
	}

	public string CancelText
	{
		get
		{
			return cancelText;
		}
		set
		{
			Set(ref cancelText, value, "CancelText");
		}
	}

	public string CancelEngText
	{
		get
		{
			return cancelEngText;
		}
		set
		{
			Set(ref cancelEngText, value, "CancelEngText");
		}
	}

	public int WaitTime
	{
		get
		{
			return _waitTime;
		}
		set
		{
			Set(ref _waitTime, value, "WaitTime");
		}
	}

	public int Result => result;

	public Action<int> Click
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

	public CountdownVerifyViewModel()
	{
	}

	public CountdownVerifyViewModel(int countdown)
	{
		WaitTime = countdown;
		countdownTimer = Timer.Register(1f, CountDown, null, isLooped: true, useRealTime: true);
	}

	public void OnCancelClick()
	{
		OnClick(-2);
	}

	public void OnConfirmClick()
	{
		OnClick(-1);
	}

	private void CountDown()
	{
		WaitTime--;
		if (WaitTime <= 0)
		{
			WaitTime = 0;
			UniTask.Delay(500);
			OnCancelClick();
		}
	}

	public void OnClick(int which)
	{
		try
		{
			result = which;
			Click?.Invoke(result);
		}
		catch (Exception)
		{
		}
		finally
		{
			Close();
		}
	}

	public override void Close()
	{
		if (countdownTimer != null)
		{
			countdownTimer.Cancel();
			countdownTimer = null;
		}
		base.Close();
	}
}
