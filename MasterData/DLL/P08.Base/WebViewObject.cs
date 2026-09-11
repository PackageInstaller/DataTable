using System;
using UnityEngine;
using UnityEngine.Networking;

public class WebViewObject : MonoBehaviour
{
	private Action<string> onJS;

	private Action<string> onError;

	private Action<string> onHttpError;

	private Action<string> onStarted;

	private Action<string> onLoaded;

	private Action<string> onHooked;

	private bool visibility;

	private bool alertDialogEnabled = true;

	private bool scrollBounceEnabled = true;

	private int mMarginLeft;

	private int mMarginTop;

	private int mMarginRight;

	private int mMarginBottom;

	private IntPtr webView;

	public bool IsKeyboardVisible => false;

	public static bool IsWebViewAvailable()
	{
		return true;
	}

	public void Init(Action<string> cb = null, bool transparent = false, string ua = "", Action<string> err = null, Action<string> httpErr = null, Action<string> ld = null, bool enableWKWebView = false, Action<string> started = null, Action<string> hooked = null)
	{
		onJS = cb;
		onError = err;
		onHttpError = httpErr;
		onStarted = started;
		onLoaded = ld;
		onHooked = hooked;
		Debug.LogError("Webview is not supported on this platform.");
	}

	protected virtual void OnDestroy()
	{
	}

	public void SetCenterPositionWithScale(Vector2 center, Vector2 scale)
	{
	}

	public void SetMargins(int left, int top, int right, int bottom, bool relative = false)
	{
		mMarginLeft = left;
		mMarginTop = top;
		mMarginRight = right;
		mMarginBottom = bottom;
	}

	public void SetVisibility(bool v)
	{
		visibility = v;
	}

	public bool GetVisibility()
	{
		return visibility;
	}

	public void SetAlertDialogEnabled(bool e)
	{
		alertDialogEnabled = e;
	}

	public bool GetAlertDialogEnabled()
	{
		return alertDialogEnabled;
	}

	public void SetScrollBounceEnabled(bool e)
	{
		scrollBounceEnabled = e;
	}

	public bool GetScrollBounceEnabled()
	{
		return scrollBounceEnabled;
	}

	public bool SetURLPattern(string allowPattern, string denyPattern, string hookPattern)
	{
		return false;
	}

	public void LoadURL(string url)
	{
		string.IsNullOrEmpty(url);
	}

	public void LoadHTML(string html, string baseUrl)
	{
		if (!string.IsNullOrEmpty(html) && string.IsNullOrEmpty(baseUrl))
		{
			baseUrl = "";
		}
	}

	public void EvaluateJS(string js)
	{
	}

	public int Progress()
	{
		return 0;
	}

	public bool CanGoBack()
	{
		return false;
	}

	public bool CanGoForward()
	{
		return false;
	}

	public void GoBack()
	{
	}

	public void GoForward()
	{
	}

	public void CallOnError(string error)
	{
		if (onError != null)
		{
			onError(error);
		}
	}

	public void CallOnHttpError(string error)
	{
		if (onHttpError != null)
		{
			onHttpError(error);
		}
	}

	public void CallOnStarted(string url)
	{
		if (onStarted != null)
		{
			onStarted(url);
		}
	}

	public void CallOnLoaded(string url)
	{
		if (onLoaded != null)
		{
			onLoaded(url);
		}
	}

	public void CallFromJS(string message)
	{
		if (onJS != null)
		{
			message = UnityWebRequest.UnEscapeURL(message);
			onJS(message);
		}
	}

	public void CallOnHooked(string message)
	{
		if (onHooked != null)
		{
			message = UnityWebRequest.UnEscapeURL(message);
			onHooked(message);
		}
	}

	public void AddCustomHeader(string headerKey, string headerValue)
	{
	}

	public string GetCustomHeaderValue(string headerKey)
	{
		return null;
	}

	public void RemoveCustomHeader(string headerKey)
	{
	}

	public void ClearCustomHeader()
	{
	}

	public void ClearCookies()
	{
	}

	public void SaveCookies()
	{
	}

	public string GetCookies(string url)
	{
		return "";
	}
}
