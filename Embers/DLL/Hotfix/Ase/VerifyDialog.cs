#define ENABLE_INFO_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class VerifyDialog : IDisposable
{
	private const string DEFAULT_VIEW_NAME = "Common/VerifyDialog";

	private static string viewName;

	private VerifyDialogWindow window;

	private VerifyDialogViewModel viewModel;

	private bool disposed;

	public static string ViewName
	{
		get
		{
			if (!string.IsNullOrEmpty(viewName))
			{
				return viewName;
			}
			return "Common/VerifyDialog";
		}
		set
		{
			viewName = value;
		}
	}

	public static IAsyncResult<KeyValuePair<int, string>> Show(string title, string message)
	{
		return ShowDialog(title, message, null, null, "LOADING", canceledOnTouchOutside: true);
	}

	public static IAsyncResult<KeyValuePair<int, string>> Show(string title, string message, string inputFieldTipsText)
	{
		return ShowDialog(title, message, inputFieldTipsText, null, "LOADING", canceledOnTouchOutside: true);
	}

	public static IAsyncResult<KeyValuePair<int, string>> Show(string title, string message, string inputFieldTipsText, string buttonText)
	{
		return ShowDialog(title, message, inputFieldTipsText, buttonText, "LOADING", canceledOnTouchOutside: false);
	}

	public static IAsyncResult<KeyValuePair<int, string>> ShowInGroup(string title, string message, string inputFieldTipsText, string confirmButtonText, string uiGroupName, bool autoPause = true)
	{
		return ShowDialog(title, message, inputFieldTipsText, confirmButtonText, uiGroupName, canceledOnTouchOutside: false, autoPause);
	}

	public static IAsyncResult<KeyValuePair<int, string>> ShowDialog(string title, string message, string inputFieldTipsText, string confirmButtonText, string uiGroupName, bool canceledOnTouchOutside, bool autoPause = true)
	{
		AsyncResult<KeyValuePair<int, string>> result = new AsyncResult<KeyValuePair<int, string>>();
		try
		{
			ShowMessage(message, title, inputFieldTipsText, confirmButtonText, uiGroupName, canceledOnTouchOutside, delegate(int which, string str)
			{
				result.SetResult(new KeyValuePair<int, string>(which, str));
			});
		}
		catch (Exception exception)
		{
			result.SetException(exception);
		}
		return result;
	}

	public static Task<VerifyDialog> ShowMessage(string message, string title, string inputFieldTipsText, string confirmButtonText, string uiGroupName, bool canceledOnTouchOutside, Action<int, string> afterHideCallback)
	{
		VerifyDialogViewModel verifyDialogViewModel = new VerifyDialogViewModel();
		verifyDialogViewModel.Message = message;
		verifyDialogViewModel.Title = title;
		verifyDialogViewModel.InputFieldTipsText = inputFieldTipsText;
		verifyDialogViewModel.ConfirmButtonText = confirmButtonText;
		verifyDialogViewModel.CanceledOnTouchOutside = canceledOnTouchOutside;
		verifyDialogViewModel.Click = afterHideCallback;
		return ShowMessage(ViewName, verifyDialogViewModel, uiGroupName);
	}

	public static async Task<VerifyDialog> ShowMessage(string windowName, VerifyDialogViewModel viewModel, string uiGroupName)
	{
		VerifyDialogWindow window = null;
		try
		{
			window = await GameEntry.UI.OpenWindow<VerifyDialogWindow>(windowName, uiGroupName);
			if (window == null)
			{
				Log.Error("Not found the dialog window named \"{0}\".", windowName);
				throw new NotFoundException("Not found the dialog window named \"" + windowName + "\".");
			}
			if (uiGroupName.Equals("POPUP"))
			{
				window.GetComponent<Canvas>().sortingOrder = 6;
			}
			VerifyDialog verifyDialog = new VerifyDialog(window, viewModel);
			verifyDialog.Show();
			return verifyDialog;
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

	public VerifyDialog(VerifyDialogWindow window, VerifyDialogViewModel viewModel)
	{
		this.window = window;
		this.viewModel = viewModel;
	}

	public void Show()
	{
		window.ViewModel = viewModel;
		window.Create();
		window.Show();
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!disposed)
		{
			disposed = true;
		}
	}

	~VerifyDialog()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}
}
