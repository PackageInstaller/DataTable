#define ENABLE_INFO_AND_ABOVE_LOG
using System;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class CountdownVerifyDialog : IDisposable
{
	private const string DEFAULT_VIEW_NAME = "Common/CountdownVerifyWindow";

	private static string viewName;

	private bool disposed;

	public static string ViewName
	{
		get
		{
			if (!string.IsNullOrEmpty(viewName))
			{
				return viewName;
			}
			return "Common/CountdownVerifyWindow";
		}
		set
		{
			viewName = value;
		}
	}

	public static IAsyncResult<int> Show(string title, string sender, string action, string target, int countdown)
	{
		return ShowDialog(title, sender, action, target, countdown, "确认", "Confirm", "取消", "Cancel", "LOADING");
	}

	public static IAsyncResult<int> Show(string title, string sender, string action, string target, int countdown, string confirmText, string confirmEngText, string cancelText, string cancelEngText)
	{
		return ShowDialog(title, sender, action, target, countdown, confirmText, confirmEngText, cancelText, cancelEngText, "LOADING");
	}

	private static IAsyncResult<int> ShowDialog(string title, string sender, string action, string target, int countdown, string confirmText, string confirmEngText, string cancelText, string cancelEngText, string uiGroupName)
	{
		AsyncResult<int> result = new AsyncResult<int>();
		try
		{
			ShowMessage(title, sender, action, target, countdown, confirmText, confirmEngText, cancelText, cancelEngText, uiGroupName, delegate(int which)
			{
				result.SetResult(which);
			});
		}
		catch (Exception exception)
		{
			result.SetException(exception);
		}
		return result;
	}

	private static void ShowMessage(string title, string sender, string action, string target, int countdown, string confirmText, string confirmEngText, string cancelText, string cancelEngText, string uiGroupName, Action<int> afterHideCallback)
	{
		CountdownVerifyViewModel viewModel = new CountdownVerifyViewModel(countdown)
		{
			Title = title,
			Sender = sender,
			Action = action,
			Target = target,
			ConfirmText = confirmText,
			ConfirmEngText = confirmEngText,
			CancelText = cancelText,
			CancelEngText = cancelEngText,
			Click = afterHideCallback
		};
		ShowMessage(ViewName, viewModel, uiGroupName);
	}

	private static async Task ShowMessage(string windowName, CountdownVerifyViewModel viewModel, string uiGroupName)
	{
		CountdownVerifyWindow window = null;
		try
		{
			window = await GameEntry.UI.OpenWindow<CountdownVerifyWindow>(windowName, uiGroupName, viewModel);
			if (window == null)
			{
				Log.Error("Not found the dialog window named \"{0}\".", windowName);
				throw new NotFoundException("Not found the dialog window named \"" + windowName + "\".");
			}
		}
		catch (Exception)
		{
			if (window != null)
			{
				window.Dismiss();
			}
		}
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!disposed)
		{
			disposed = true;
		}
	}

	~CountdownVerifyDialog()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}
}
