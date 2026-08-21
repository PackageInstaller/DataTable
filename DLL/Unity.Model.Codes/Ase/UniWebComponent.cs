#define ENABLE_ERROR_LOG
using System;
using System.Runtime.CompilerServices;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class UniWebComponent : GameFrameworkComponent
{
	[Serializable]
	[CompilerGenerated]
	private sealed class _003C_003Ec
	{
		public static readonly _003C_003Ec _003C_003E9 = new _003C_003Ec();

		public static PageFinishedDelegate _003C_003E9__8_0;

		internal void _003CInitUniWebView_003Eb__8_0(UniWebView view, int code, string s)
		{
		}
	}

	private UniWebView m_UniWebview;

	public const string ServiceUrl = "https://kiifstudio.com/service.html";

	private const string InValidPlatform = "无法跳转至网址";

	public bool IsUniWebViewOpen => (UnityEngine.Object)(object)m_UniWebview != null;

	public override void Init()
	{
		base.Init();
	}

	public string OpenWebView(string url, Rect frame, bool useToolBar, Action<UniWebViewMessage> onMessage, Action<int, string, UniWebViewNativeResultPayload> onError)
	{
		if (!CheckDevicePlatform())
		{
			return "无法跳转至网址";
		}
		if (InitUniWebView(onMessage, onError))
		{
			m_UniWebview.Frame = frame;
			((Component)(object)m_UniWebview).gameObject.SetActive(value: true);
			m_UniWebview.Load(url, false, (string)null);
			m_UniWebview.Show(false, (UniWebViewTransitionEdge)0, 0.4f, (Action)null);
			if (useToolBar)
			{
				ShowToolBar();
			}
		}
		return string.Empty;
	}

	public string OpenWebView(string url, RectTransform reference, bool useToolBar, Action<UniWebViewMessage> onMessage, Action<int, string, UniWebViewNativeResultPayload> onError)
	{
		if (!CheckDevicePlatform())
		{
			return "无法跳转至网址";
		}
		if (reference == null)
		{
			return "reference为空";
		}
		if (InitUniWebView(onMessage, onError))
		{
			m_UniWebview.ReferenceRectTransform = reference;
			((Component)(object)m_UniWebview).gameObject.SetActive(value: true);
			m_UniWebview.SetUserAgent("KIIF_CLIENT_" + ResourcesExtension.GetPlatformPath(Application.platform) + "_" + GameEntry.BuiltinData.VersionInfo);
			m_UniWebview.Load(url, false, (string)null);
			m_UniWebview.Show(false, (UniWebViewTransitionEdge)0, 0.4f, (Action)null);
			if (useToolBar)
			{
				ShowToolBar();
			}
		}
		return string.Empty;
	}

	private bool InitUniWebView(Action<UniWebViewMessage> onMessage, Action<int, string, UniWebViewNativeResultPayload> onError)
	{
		//IL_0088: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Expected O, but got Unknown
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a9: Expected O, but got Unknown
		//IL_00b6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c0: Expected O, but got Unknown
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0070: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Expected O, but got Unknown
		if ((UnityEngine.Object)(object)m_UniWebview != null)
		{
			UnityEngine.Object.Destroy((UnityEngine.Object)(object)m_UniWebview);
			m_UniWebview = null;
		}
		TryCreateUniWebView();
		if ((UnityEngine.Object)(object)m_UniWebview == null)
		{
			return false;
		}
		UniWebView uniWebview = m_UniWebview;
		object obj = _003C_003Ec._003C_003E9__8_0;
		if (obj == null)
		{
			PageFinishedDelegate val = delegate
			{
			};
			_003C_003Ec._003C_003E9__8_0 = val;
			obj = (object)val;
		}
		uniWebview.OnPageFinished += (PageFinishedDelegate)obj;
		m_UniWebview.OnLoadingErrorReceived += (LoadingErrorReceivedDelegate)delegate(UniWebView view, int code, string message, UniWebViewNativeResultPayload payload)
		{
			Log.Error("WebView Load Error: {0}, {1}", code, message);
			if (onError != null)
			{
				onError(code, message, payload);
			}
		};
		m_UniWebview.OnMessageReceived += (MessageReceivedDelegate)delegate(UniWebView view, UniWebViewMessage message)
		{
			//IL_000e: Unknown result type (might be due to invalid IL or missing references)
			if (onMessage != null)
			{
				onMessage(message);
			}
			if (((UniWebViewMessage)(ref message)).Path.Equals("close"))
			{
				UnityEngine.Object.Destroy((UnityEngine.Object)(object)m_UniWebview);
				m_UniWebview = null;
			}
		};
		m_UniWebview.OnShouldClose += (ShouldCloseDelegate)delegate
		{
			UnityEngine.Object.Destroy((UnityEngine.Object)(object)m_UniWebview);
			m_UniWebview = null;
			return true;
		};
		return true;
	}

	private void ShowToolBar()
	{
		m_UniWebview.EmbeddedToolbar.SetBackgroundColor(Color.black);
		m_UniWebview.EmbeddedToolbar.SetButtonTextColor(Color.white);
		m_UniWebview.EmbeddedToolbar.SetTitleTextColor(Color.white);
		m_UniWebview.EmbeddedToolbar.SetDoneButtonText("✕");
		m_UniWebview.EmbeddedToolbar.Show();
	}

	private bool CheckDevicePlatform()
	{
		return true;
	}

	public void CloseWebView()
	{
		UnityEngine.Object.Destroy((UnityEngine.Object)(object)m_UniWebview);
		m_UniWebview = null;
	}

	public override void Shutdown()
	{
		if ((bool)(UnityEngine.Object)(object)m_UniWebview)
		{
			UnityEngine.Object.Destroy((UnityEngine.Object)(object)m_UniWebview);
			m_UniWebview = null;
		}
	}

	private void TryCreateUniWebView()
	{
		if ((UnityEngine.Object)(object)m_UniWebview == null)
		{
			m_UniWebview = base.gameObject.AddComponent<UniWebView>();
		}
	}
}
