using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class UIWindowHelper : UIHelperBase
{
	private Dictionary<string, string> viewConfig = new Dictionary<string, string>();

	private static List<WindowCreateData> loadCache = new List<WindowCreateData>();

	private static List<WindowCreateData> dataQueue = new List<WindowCreateData>();

	private static List<WindowCreateData> setAlphaQueue = new List<WindowCreateData>();

	private static Dictionary<string, RectTransform> uiControls = new Dictionary<string, RectTransform>();

	public static Dictionary<string, RectTransform> UIControls => uiControls;

	public List<WindowCreateData> DataQueue => dataQueue;

	public override async UniTask OnWindowLoad(string uiFormAssetName, string uiGroupName, IWindow window, object userData)
	{
		await UniTask.CompletedTask;
		if (uiGroupName != null && uiGroupName.Equals("DEFAULT"))
		{
			AddLoadWindow(uiFormAssetName, userData, window);
		}
	}

	public override UniTask OnWindowShow(IWindow window)
	{
		if (AddWindow(window))
		{
			ShowWindow(window);
		}
		return base.OnWindowShow(window);
	}

	public static void OnWindowEnable(IWindow window)
	{
		for (int i = 0; i < setAlphaQueue.Count; i++)
		{
			setAlphaQueue[i].SetViewAlpha(isShow: false);
		}
		setAlphaQueue.Clear();
	}

	public override UniTask OnWindowHide(IWindow window)
	{
		return base.OnWindowHide(window);
	}

	public override UniTask OnWindowDismiss(IWindow window)
	{
		RemoveWindow(window);
		return base.OnWindowDismiss(window);
	}

	private void AddLoadWindow(string path, object userData, IWindow window)
	{
		WindowCreateData windowCreateData = new WindowCreateData(path, userData, window);
		if (windowCreateData.ViewModel != null)
		{
			loadCache.Add(windowCreateData);
		}
	}

	private WindowCreateData GetLoadCreateData(IWindow window)
	{
		for (int i = 0; i < loadCache.Count; i++)
		{
			if (loadCache[i].View == window)
			{
				WindowCreateData result = loadCache[i];
				loadCache.RemoveAt(i);
				return result;
			}
		}
		return null;
	}

	private bool AddWindow(IWindow window)
	{
		WindowCreateData loadCreateData = GetLoadCreateData(window);
		if (loadCreateData != null && loadCreateData.ViewModel != null)
		{
			dataQueue.Add(loadCreateData);
			CheckOldWindowValid();
			CheckRepeatWindow(window);
			return true;
		}
		return false;
	}

	private void ShowWindow(IWindow w)
	{
		lock (dataQueue)
		{
			if (dataQueue.Count == 1 || dataQueue.Count == 0)
			{
				return;
			}
			UGuiWindow window = w as UGuiWindow;
			if ((object)window == null || window.WindowAlphaType != WindowAlphaType.Normal)
			{
				return;
			}
			for (int num = dataQueue.Count - 1; num > 0; num--)
			{
				if (dataQueue[num].View == w)
				{
					setAlphaQueue.Add(dataQueue[num - 1]);
					window.ExitAnimation?.OnStart(delegate
					{
						OnExitAnimationStart(window);
					});
					break;
				}
			}
		}
	}

	private void RemoveWindow(IWindow w)
	{
		lock (dataQueue)
		{
			bool flag = false;
			for (int num = dataQueue.Count - 1; num >= 0; num--)
			{
				if (dataQueue[num].View == w)
				{
					dataQueue[num].Clear();
					dataQueue.RemoveAt(num);
					flag = true;
					break;
				}
			}
			if ((dataQueue.Count > 0) & flag)
			{
				dataQueue[dataQueue.Count - 1].SetViewAlpha(isShow: true);
			}
		}
	}

	public static void OnExitAnimationStart(IWindow w)
	{
		lock (dataQueue)
		{
			for (int num = dataQueue.Count - 1; num >= 0; num--)
			{
				if (dataQueue[num].View == w)
				{
					if (dataQueue.Count > 1)
					{
						dataQueue[dataQueue.Count - 2].SetViewAlpha(isShow: true);
					}
					break;
				}
			}
		}
	}

	public static void RemoveLastWindow()
	{
		lock (dataQueue)
		{
			if (dataQueue.Count > 1)
			{
				dataQueue[dataQueue.Count - 1].Clear();
				dataQueue.RemoveAt(dataQueue.Count - 1);
			}
			if (dataQueue.Count > 0)
			{
				dataQueue[dataQueue.Count - 1].SetViewAlpha(isShow: true);
			}
		}
	}

	public static void ReleaseWindowKeepMainView()
	{
		lock (dataQueue)
		{
			for (int num = dataQueue.Count - 1; num > 0; num--)
			{
				dataQueue[num].Clear();
				dataQueue.RemoveAt(num);
			}
			dataQueue[0].SetViewAlpha(isShow: true);
		}
	}

	public static void ReleaseWindowKeepBattleView()
	{
		lock (dataQueue)
		{
			for (int num = dataQueue.Count - 1; num > 3; num--)
			{
				dataQueue[num].Clear();
				dataQueue.RemoveAt(num);
			}
			for (int i = 0; i < dataQueue.Count; i++)
			{
				dataQueue[i].SetViewAlpha(isShow: true);
			}
		}
	}

	public void CheckOldWindowValid()
	{
		if (dataQueue.Count <= 3)
		{
			return;
		}
		lock (dataQueue)
		{
			bool flag = false;
			for (int num = dataQueue.Count - 1; num > 0; num--)
			{
				if (!flag && dataQueue[num].OuterModule == OuterModule.Culture)
				{
					bool flag2 = false;
					for (int i = num + 1; i < dataQueue.Count; i++)
					{
						if (dataQueue[i].OuterModule != OuterModule.None)
						{
							flag2 = true;
							break;
						}
					}
					if (!flag2)
					{
						break;
					}
					flag = true;
				}
				else if (flag && (dataQueue[num].OuterModule == OuterModule.Copy || dataQueue[num].OuterModule == OuterModule.Level))
				{
					for (int num2 = dataQueue.Count - 2; num2 > 0; num2--)
					{
						dataQueue[num2].Clear();
						dataQueue.RemoveAt(num2);
					}
					return;
				}
			}
			OuterModule outerModule = OuterModule.None;
			int num3 = 0;
			for (int num4 = dataQueue.Count - 1; num4 > 0; num4--)
			{
				if (num3 == 0 && dataQueue[num4].OuterModule != OuterModule.None)
				{
					outerModule = dataQueue[num4].OuterModule;
					num3 = 1;
				}
				if (num3 == 1 && dataQueue[num4].OuterModule != outerModule && dataQueue[num4].OuterModule != OuterModule.None)
				{
					outerModule = dataQueue[num4].OuterModule;
					num3 = 2;
				}
				else if (num3 == 3 || (num3 == 2 && dataQueue[num4].OuterModule != outerModule && dataQueue[num4].OuterModule != OuterModule.None))
				{
					num3 = 3;
					dataQueue[num4].Clear();
					dataQueue.RemoveAt(num4);
				}
			}
		}
	}

	private void CheckRepeatWindow(IWindow window)
	{
		lock (dataQueue)
		{
			bool flag = true;
			for (int num = dataQueue.Count - 1; num >= 0; num--)
			{
				if (flag && window.GetType() == dataQueue[num].Type)
				{
					flag = false;
				}
				else if (!flag && window.GetType() == dataQueue[num].Type)
				{
					dataQueue[num].Clear();
					dataQueue.RemoveAt(num);
					break;
				}
			}
		}
	}

	public static async Task<bool> LoadCacheView()
	{
		List<WindowCreateData> list = new List<WindowCreateData>();
		for (int i = 0; i < dataQueue.Count; i++)
		{
			list.Add(dataQueue[i]);
		}
		for (int j = 0; j < list.Count; j++)
		{
			await GameEntry.UI.OpenUIWindow<Window>(list[j].ViewPath, "DEFAULT", list[j].ViewModel);
		}
		return dataQueue.Count > 0;
	}

	public static object GetTopVM()
	{
		for (int num = dataQueue.Count - 1; num >= 0; num--)
		{
			if (dataQueue[num].ViewModel != null)
			{
				return dataQueue[num].ViewModel;
			}
		}
		return null;
	}

	public static object GetBottomVM()
	{
		for (int i = 0; i < dataQueue.Count; i++)
		{
			if (dataQueue[i].ViewModel != null)
			{
				return dataQueue[i].ViewModel;
			}
		}
		return null;
	}

	public static List<object> GetCachedVm()
	{
		List<object> list = new List<object>();
		for (int i = 0; i < dataQueue.Count; i++)
		{
			list.Add(dataQueue[i].ViewModel);
		}
		return list;
	}

	public static void WindowReleaseKeepBottom()
	{
		lock (dataQueue)
		{
			for (int num = dataQueue.Count - 1; num > 0; num--)
			{
				dataQueue[num].Clear();
				dataQueue.RemoveAt(num);
			}
		}
	}

	public static void WindowReleaseAll()
	{
		lock (dataQueue)
		{
			for (int num = dataQueue.Count - 1; num >= 0; num--)
			{
				dataQueue[num].Clear();
				dataQueue.RemoveAt(num);
			}
		}
	}

	public static void WindowRelease(ProcessType processType = ProcessType.None)
	{
		lock (dataQueue)
		{
			OuterModule outerModule = OuterModule.None;
			for (int num = dataQueue.Count - 1; num >= 0; num--)
			{
				if (outerModule == OuterModule.None && dataQueue[num].OuterModule != OuterModule.None)
				{
					outerModule = dataQueue[num].OuterModule;
				}
				if (dataQueue[num].ProcessType == processType)
				{
					dataQueue[num].Clear();
					dataQueue.RemoveAt(num);
				}
				else if (outerModule != OuterModule.None && dataQueue[num].OuterModule != outerModule && dataQueue[num].OuterModule != OuterModule.None)
				{
					dataQueue[num].Clear();
					dataQueue.RemoveAt(num);
				}
				else
				{
					dataQueue[num].ClearView();
				}
			}
		}
	}

	public static void AddGuidanceKey(string uiName, List<UIContrl> uiContrls)
	{
		foreach (UIContrl uiContrl in uiContrls)
		{
			string key = uiName + "-" + uiContrl.uiKey;
			if (uiControls.ContainsKey(key))
			{
				uiControls[key] = uiContrl.uiObject;
			}
			else
			{
				uiControls.Add(key, uiContrl.uiObject);
			}
		}
	}

	public static void RemoveGuidanceKey(string uiName, List<UIContrl> uiContrls)
	{
		foreach (UIContrl uiContrl in uiContrls)
		{
			string key = uiName + "-" + uiContrl.uiKey;
			if (uiControls.ContainsKey(key))
			{
				uiControls.Remove(key);
			}
		}
	}

	public static void DebugShowAllWindow()
	{
		for (int i = 0; i < dataQueue.Count; i++)
		{
		}
	}
}
