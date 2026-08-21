#define ENABLE_INFO_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class AlertDialog : IDisposable
{
	public const int BUTTON_POSITIVE = -1;

	public const int BUTTON_NEGATIVE = -2;

	public const int BUTTON_NEUTRAL = -3;

	private const string DEFAULT_VIEW_NAME = "AlertDialog";

	private static List<AlertDialog> activeDialogs = new List<AlertDialog>();

	private static string viewName;

	private AlertDialogWindow window;

	private AlertDialogViewModel viewModel;

	private bool disposed;

	public static string ViewName
	{
		get
		{
			if (!string.IsNullOrEmpty(viewName))
			{
				return viewName;
			}
			return "AlertDialog";
		}
		set
		{
			viewName = value;
		}
	}

	public static IAsyncResult<int> Show(string title, string message)
	{
		return ShowDialog(title, message, null, null, null, "POPUP", canceledOnTouchOutside: true);
	}

	public static IAsyncResult<int> Show(string title, string message, string buttonText)
	{
		return ShowDialog(title, message, buttonText, null, null, "POPUP", canceledOnTouchOutside: false);
	}

	public static IAsyncResult<int> Show(string title, string message, string confirmButtonText, string cancelButtonText, bool autoPause = true)
	{
		return ShowDialog(title, message, confirmButtonText, cancelButtonText, null, "POPUP", canceledOnTouchOutside: false, autoPause);
	}

	public static IAsyncResult<int> ShowInGroup(string title, string message, string confirmButtonText, string cancelButtonText, string neutralButtonText, string uiGroupName, bool autoPause = true)
	{
		return ShowDialog(title, message, confirmButtonText, cancelButtonText, neutralButtonText, uiGroupName, canceledOnTouchOutside: false, autoPause);
	}

	public static IAsyncResult<int> Show(string title, string message, string confirmButtonText, string cancelButtonText, string neutralButtonText, bool canceledOnTop = true)
	{
		return ShowDialog(title, message, confirmButtonText, cancelButtonText, neutralButtonText, "POPUP", canceledOnTouchOutside: false, autoPause: true, canceledOnTop);
	}

	public static IAsyncResult<int> Show(string title, string message, string confirmButtonText, string cancelButtonText, string neutralButtonText, bool canceledOnTouchOutside, bool canceledOnTop)
	{
		return ShowDialog(title, message, confirmButtonText, cancelButtonText, neutralButtonText, "POPUP", canceledOnTouchOutside, canceledOnTop);
	}

	public static IAsyncResult<int> ShowDialog(string title, string message, string confirmButtonText, string cancelButtonText, string neutralButtonText, string uiGroupName, bool canceledOnTouchOutside, bool autoPause = true, bool canceledOnTop = true)
	{
		AsyncResult<int> result = new AsyncResult<int>();
		try
		{
			ShowMessage(message, title, confirmButtonText, neutralButtonText, cancelButtonText, uiGroupName, canceledOnTouchOutside, canceledOnTop, delegate(int which)
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

	public static Task<AlertDialog> ShowMessage(string message, string title, string confirmButtonText, string neutralButtonText, string cancelButtonText, string uiGroupName, bool canceledOnTouchOutside, bool canceledOnTop, Action<int> afterHideCallback)
	{
		AlertDialogViewModel alertDialogViewModel = new AlertDialogViewModel();
		alertDialogViewModel.Message = message;
		alertDialogViewModel.Title = title;
		alertDialogViewModel.ConfirmButtonText = confirmButtonText;
		alertDialogViewModel.NeutralButtonText = neutralButtonText;
		alertDialogViewModel.CancelButtonText = cancelButtonText;
		alertDialogViewModel.CanceledOnTouchOutside = canceledOnTouchOutside;
		alertDialogViewModel.CanceledOnTop = canceledOnTop;
		alertDialogViewModel.Click = afterHideCallback;
		return ShowMessage(ViewName, alertDialogViewModel, uiGroupName);
	}

	public static async Task<AlertDialog> ShowMessage(string windowName, AlertDialogViewModel viewModel, string uiGroupName)
	{
		AlertDialogWindow window = null;
		try
		{
			window = await GameEntry.UI.OpenResWindow<AlertDialogWindow>(windowName, uiGroupName);
			if (window == null)
			{
				Log.Error("Not found the dialog window named \"{0}\".", windowName);
				throw new NotFoundException("Not found the dialog window named \"" + windowName + "\".");
			}
			AlertDialog alertDialog = new AlertDialog(window, viewModel);
			activeDialogs.Add(alertDialog);
			alertDialog.Show();
			return alertDialog;
		}
		catch (Exception)
		{
			if (window != null)
			{
				window.Dismiss();
			}
			return null;
		}
	}

	public static void ClearActiveDialogs()
	{
		foreach (AlertDialog activeDialog in activeDialogs)
		{
			activeDialog.window.Dismiss(ignoreAnimation: true);
		}
		activeDialogs.Clear();
	}

	public AlertDialog(AlertDialogWindow window, AlertDialogViewModel viewModel)
	{
		this.window = window;
		this.viewModel = viewModel;
	}

	public void Show()
	{
		window.ViewModel = viewModel;
		window.Create();
	}

	protected virtual void Dispose(bool disposing)
	{
		activeDialogs.Remove(this);
		if (!disposed)
		{
			disposed = true;
		}
	}

	~AlertDialog()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}
}
