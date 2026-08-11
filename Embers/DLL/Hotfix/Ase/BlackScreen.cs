using System;
using System.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BlackScreen : IDisposable
{
	private static object _lock = new object();

	private static int refCount = 0;

	private static BlackScreenWindow window;

	private static string viewName;

	private bool ignoreAnimation;

	private static GameObject uiGameObject;

	private bool disposed;

	public static async Task<BlackScreen> Show(bool ignoreAnimation = false)
	{
		return await ShowBlackScreen("DEFAULT", ignoreAnimation);
	}

	public static async Task<BlackScreen> Show(string uiGroupName, bool ignoreAnimation = false)
	{
		return await ShowBlackScreen(uiGroupName, ignoreAnimation);
	}

	private static async Task<BlackScreen> ShowBlackScreen(string uiGroupName, bool ignoreAnimation)
	{
		BlackScreenWindow screenWindow = null;
		try
		{
			if (uiGameObject == null)
			{
				uiGameObject = await GameEntry.Resource.LoadAssetAsync<GameObject>(AssetUtility.GetUIFormAsset("Loading/BlackScreenWindow"));
			}
			if (refCount <= 0)
			{
				screenWindow = await GameEntry.UI.LoadWindow<BlackScreenWindow>(AssetUtility.GetUIFormAsset("Loading/BlackScreenWindow"), uiGroupName, null);
				if (screenWindow == null)
				{
					throw new NotFoundException("Not found the loading window named \"" + viewName + "\".");
				}
			}
			return new BlackScreen(ignoreAnimation, screenWindow);
		}
		catch (Exception ex)
		{
			if (screenWindow != null)
			{
				screenWindow.Dismiss();
			}
			throw ex;
		}
	}

	protected BlackScreen(bool ignoreAnimation, BlackScreenWindow loadingWindow)
	{
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
					if (!window.Dismissed)
					{
						window.Dismiss(ignoreAnimation);
					}
					window = null;
				}
			}
		});
	}

	~BlackScreen()
	{
		Dispose(disposing: false);
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}
}
