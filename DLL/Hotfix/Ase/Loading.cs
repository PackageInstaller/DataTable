using System;
using System.Threading.Tasks;
using GameFramework.Runtime;
using TMPro;
using UnityEngine;

namespace Ase;

public class Loading : IDisposable
{
	private static object _lock = new object();

	private static int refCount = 0;

	private static LoadingTipWindow window;

	private static string viewName;

	private bool ignoreAnimation;

	private bool disposed;

	public static async Task<Loading> Show(bool ignoreAnimation = false)
	{
		return await ShowLoading(ignoreAnimation);
	}

	public static async Task<Loading> ShowWithMessage(string message, bool ignoreAnimation = false)
	{
		return await ShowLoading(ignoreAnimation, message);
	}

	public static async Task<Loading> ShowDisableTouch(bool ignoreAnimation = false)
	{
		return await ShowLoadingDisableTouch(ignoreAnimation);
	}

	private static async Task<Loading> ShowLoadingDisableTouch(bool ignoreAnimation)
	{
		LoadingTipWindow loadingWindow = null;
		try
		{
			loadingWindow = await GameEntry.UI.OpenWindow<LoadingTipWindow>("Loading/LoadingDisableTouch", "POPUP");
			if (loadingWindow == null)
			{
				throw new NotFoundException("Not found the loading window named LoadingDisableTouch.");
			}
			return new Loading(ignoreAnimation, loadingWindow);
		}
		catch (Exception ex)
		{
			if (loadingWindow != null)
			{
				loadingWindow.Dismiss();
			}
			throw ex;
		}
	}

	private static async Task<Loading> ShowLoading(bool ignoreAnimation, string message = null)
	{
		LoadingTipWindow loadingWindow = null;
		try
		{
			loadingWindow = await GameEntry.UI.OpenWindow<LoadingTipWindow>("Loading/Loading", "POPUP");
			if (loadingWindow == null)
			{
				throw new NotFoundException("Not found the loading window named \"" + viewName + "\".");
			}
			if ((UnityEngine.Object)(object)loadingWindow.message != null)
			{
				((TMP_Text)loadingWindow.message).text = message;
			}
			return new Loading(ignoreAnimation, loadingWindow);
		}
		catch (Exception ex)
		{
			if (loadingWindow != null)
			{
				loadingWindow.Dismiss();
			}
			throw ex;
		}
	}

	protected Loading(bool ignoreAnimation, LoadingTipWindow loadingWindow)
	{
		if (refCount > 0)
		{
			loadingWindow.Dismiss(ignoreAnimation);
		}
		this.ignoreAnimation = ignoreAnimation;
		lock (_lock)
		{
			if (refCount <= 0)
			{
				window = loadingWindow;
				window.Show(this.ignoreAnimation);
			}
			refCount++;
		}
	}

	protected virtual void Dispose(bool disposing)
	{
		if (disposed)
		{
			return;
		}
		disposed = true;
		Executors.RunOnMainThread(delegate
		{
			lock (_lock)
			{
				refCount--;
				if (refCount <= 0)
				{
					window.Dismiss(ignoreAnimation);
					window = null;
				}
			}
		});
	}

	~Loading()
	{
		Dispose(disposing: false);
	}

	public void DisposeAll()
	{
		if (!disposed)
		{
			disposed = true;
			Executors.RunOnMainThread(delegate
			{
				lock (_lock)
				{
					window.Dismiss(ignoreAnimation);
					window = null;
				}
			});
		}
		GC.SuppressFinalize(this);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}
}
