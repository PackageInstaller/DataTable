using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class Toast
{
	private struct ToastCacheData
	{
		public TipType tipType;

		public string msg;

		public float dura;
	}

	private const string DEFAULT_VIEW_NAME = "Toast";

	private static string viewName;

	private static Dictionary<string, List<ToastView>> s_toastViewResDic;

	private static List<Toast> toastList;

	private const float dura = 3f;

	private const int maxCount = 3;

	private static bool isPlaying;

	private IUIViewGroup viewGroup;

	private readonly float duration;

	private string text;

	private string configData;

	private UILayout layout;

	private Action callback;

	private ToastView view;

	public static string ViewName
	{
		get
		{
			if (!string.IsNullOrEmpty(viewName))
			{
				return viewName;
			}
			return "Toast";
		}
		set
		{
			viewName = value;
		}
	}

	public float Duration => duration;

	public string Text => text;

	public ToastView View => view;

	public static async Task<Toast> Show(IUIViewGroup viewGroup, string text, float duration = 3f)
	{
		return await Show(ViewName, viewGroup, text, duration, null, null, string.Empty);
	}

	public static async Task<Toast> Show(IUIViewGroup viewGroup, string text, float duration, UILayout layout)
	{
		return await Show(ViewName, viewGroup, text, duration, layout, null, string.Empty);
	}

	public static async Task<Toast> Show(IUIViewGroup viewGroup, string text, float duration, UILayout layout, Action callback)
	{
		return await Show(ViewName, viewGroup, text, duration, layout, callback, string.Empty);
	}

	public static async Task<Toast> Show(string viewName, IUIViewGroup viewGroup, string text, float duration, UILayout layout, Action callback, string configData)
	{
		if (string.IsNullOrEmpty(viewName))
		{
			viewName = ViewName;
		}
		if (s_toastViewResDic == null)
		{
			s_toastViewResDic = new Dictionary<string, List<ToastView>>();
		}
		ToastView toastView = await GameEntry.UI.OpenUIView<ToastView>(viewName);
		if (toastView == null)
		{
			throw new NotFoundException("Not found the \"ToastView\".");
		}
		if (s_toastViewResDic.ContainsKey(viewName))
		{
			if (!s_toastViewResDic[viewName].Contains(toastView))
			{
				s_toastViewResDic[viewName].Add(toastView);
			}
		}
		else
		{
			List<ToastView> value = new List<ToastView> { toastView };
			s_toastViewResDic.TryAdd(viewName, value);
		}
		toastView.Visibility = false;
		Toast toast = new Toast(toastView, viewGroup, text, duration, layout, callback, configData);
		toast.Show();
		return toast;
	}

	public static async void ShowError(string message, string errorCode = null)
	{
	}

	public static async void ShowInfo(string message)
	{
		await AddShowInfo(TipType.INFO, message);
	}

	private static async Task AddShowInfo(TipType tipType, string msg)
	{
		if (toastList == null)
		{
			toastList = new List<Toast>();
		}
		float yDelta = 0f;
		Toast toast = await Show("Common/UIAlertTips", GameEntry.UI.GetUIGroup("POPUP"), tipType, msg, 3f);
		toastList.Add(toast);
		for (int num = toastList.Count - 3 - 1; num >= 0; num--)
		{
			toastList[num].Cancel();
			toastList.RemoveAt(num);
		}
		RectTransform component = toast.view.GetComponent<RectTransform>();
		for (int num2 = toastList.Count - 1; num2 >= 0; num2--)
		{
			if (toastList[num2].View != null)
			{
				RectTransform component2 = toastList[num2].View.GetComponent<RectTransform>();
				component2.anchoredPosition = new Vector2(component2.anchoredPosition.x, component.anchoredPosition.y + yDelta);
				yDelta += toastList[num2].view.height;
			}
		}
	}

	private static async Task<Toast> Show(string viewName, IUIViewGroup viewGroup, TipType tipType, string text, float duration = 1.5f, UILayout layout = null, Action callback = null, string configData = null)
	{
		switch (tipType)
		{
		case TipType.INFO:
			text = "<color=#FFE6CF>" + text + "</color>";
			break;
		case TipType.ERROR:
			text = "<color=#FFE6CF>" + text + "</color>";
			break;
		case TipType.SUCCESS:
			text = "<color=#FFE6CF>" + text + "</color>";
			break;
		}
		return await Show(viewName, viewGroup, text, duration, layout, callback, configData);
	}

	public static async void ShowQueue(string viewName, IUIViewGroup viewGroup, string[] text, float[] duration, string[] dataList, UILayout layout, Action callback)
	{
		int count = Mathf.Min(text.Length, duration.Length, dataList.Length);
		for (int i = 0; i < count; i++)
		{
			Toast toast = await Show(viewName, viewGroup, text[i], 0f, layout, callback, dataList[i]);
			await Task.Delay((int)(duration[i] * 1000f));
			toast.ForceCancel();
		}
	}

	protected Toast(ToastView view, IUIViewGroup viewGroup, string text, float duration)
		: this(view, viewGroup, text, duration, null, null, string.Empty)
	{
	}

	protected Toast(ToastView view, IUIViewGroup viewGroup, string text, float duration, UILayout layout, string configData)
		: this(view, viewGroup, text, duration, layout, null, configData)
	{
	}

	protected Toast(ToastView view, IUIViewGroup viewGroup, string text, float duration, UILayout layout, Action callback, string configData)
	{
		this.view = view;
		this.viewGroup = viewGroup;
		this.text = text;
		this.configData = configData;
		this.duration = duration;
		this.layout = layout;
		this.callback = callback;
	}

	public void Cancel()
	{
		if (view == null || view.Owner == null)
		{
			return;
		}
		if (!view.Visibility)
		{
			DestroyToast();
		}
		else if (view.ExitAnimation != null)
		{
			view.ExitAnimation.OnEnd(delegate
			{
				DoCallback();
				CloseToast();
			}).Play();
		}
		else
		{
			CloseToast();
			DoCallback();
		}
	}

	public void ForceCancel()
	{
		if (!(view == null) && !(view.Owner == null))
		{
			if (!view.Visibility)
			{
				DestroyToast();
				return;
			}
			view.StopAllCoroutines();
			CloseToast();
			DoCallback();
		}
	}

	public void Show()
	{
		if (!view.Visibility)
		{
			viewGroup.AddView(view, layout);
			view.Visibility = true;
			view.text.text = text;
			view.ConfigData = configData;
			if (view.EnterAnimation != null)
			{
				view.EnterAnimation.Play();
			}
			if (duration > 0f)
			{
				view.StartCoroutine(DelayDismiss(duration));
			}
		}
	}

	protected IEnumerator DelayDismiss(float duration)
	{
		yield return new WaitForSecondsRealtime(1f);
		Cancel();
	}

	protected void DoCallback()
	{
		try
		{
			if (callback != null)
			{
				callback();
			}
		}
		catch (Exception)
		{
		}
	}

	private void CloseToast()
	{
		view.Visibility = false;
		viewGroup.RemoveView(view);
		DestroyToast();
	}

	private void DestroyToast()
	{
		foreach (KeyValuePair<string, List<ToastView>> item in s_toastViewResDic)
		{
			if (item.Value.Contains(view))
			{
				item.Value.Remove(view);
			}
			if (item.Value.Count <= 0)
			{
				GameEntry.Resource.UnloadAsset(AssetUtility.GetUIFormAsset(item.Key));
			}
		}
		if (view.Owner != null)
		{
			UnityEngine.Object.Destroy(view.gameObject);
			UnityEngine.Object.Destroy(view);
		}
		view = null;
		viewGroup = null;
		text = null;
		configData = null;
		layout = null;
		callback = null;
	}

	private static void WriteErrorInfo2Local(string message, string errorCode)
	{
		string path = Application.persistentDataPath + "/ToastErrorLog.txt";
		StackTrace stackTrace = new StackTrace(fNeedFileInfo: true);
		string text = (string.IsNullOrEmpty(errorCode) ? string.Empty : ("\nErrorCode:" + errorCode));
		string s = $"\n[{DateTime.Now:yyyy.MM.dd HH:mm:ss}]\n{message}{text}\n{stackTrace.ToString()}";
		try
		{
			using FileStream fileStream = File.Open(path, FileMode.OpenOrCreate, FileAccess.Write);
			byte[] bytes = Encoding.UTF8.GetBytes(s);
			fileStream.Position = fileStream.Length;
			fileStream.Write(bytes, 0, bytes.Length);
		}
		catch (Exception)
		{
			throw;
		}
	}
}
