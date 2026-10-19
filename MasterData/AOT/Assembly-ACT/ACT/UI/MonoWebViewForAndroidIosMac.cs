using System;
using System.Collections.Generic;
using ACT.Event;
using ACT.Utility;
using Fundamental;
using Jing.ULiteWebView;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoWebViewForAndroidIosMac : BaseUIView
{
	[Flags]
	public enum AllowedOrientations
	{
		None = 0,
		Portrait = 1,
		PortraitUpsideDown = 2,
		LandscapeLeft = 4,
		LandscapeRight = 8
	}

	public RectTransform webView;

	[SerializeField]
	private ActButton _closeBtn;

	[SerializeField]
	private ActButton _reloadBtn;

	[SerializeField]
	private ActButton _backBtn;

	[SerializeField]
	private ActButton _forwardBtn;

	private const string _feedBack = "http://zhuziplay.com/";

	private Stack<string> _stackForward = new Stack<string>();

	private Stack<string> _stackBack = new Stack<string>();

	private bool _currentStack;

	private string _currentUrl = string.Empty;

	private bool _isPortrait;

	private AllowedOrientations _allowedOrientations;

	private Vector3[] _corners = new Vector3[4];

	private bool _initialized;

	private bool _isShow;

	private bool _portraitReady;

	protected override void Init()
	{
		base.Init();
		_closeBtn.SetBtnClick(Close);
		_reloadBtn.SetBtnClick(OnClickReloadButton);
		_forwardBtn.SetBtnClick(OnClickForwardButton);
		_backBtn.SetBtnClick(OnClickBackButton);
		_allowedOrientations = AllowedOrientations.None;
		WebViewData webViewData = uiViewData as WebViewData;
		_currentUrl = (string.IsNullOrEmpty(webViewData.Url) ? "http://zhuziplay.com/" : webViewData.Url);
		_isPortrait = webViewData.IsPortrait;
		ULiteWebView.Ins.onLoadingUrl += AddToURLList;
		if (_isPortrait)
		{
			if (Screen.autorotateToLandscapeLeft)
			{
				_allowedOrientations |= AllowedOrientations.LandscapeLeft;
			}
			if (Screen.autorotateToLandscapeRight)
			{
				_allowedOrientations |= AllowedOrientations.LandscapeRight;
			}
			if (Screen.autorotateToPortrait)
			{
				_allowedOrientations |= AllowedOrientations.Portrait;
			}
			if (Screen.autorotateToPortraitUpsideDown)
			{
				_allowedOrientations |= AllowedOrientations.PortraitUpsideDown;
			}
			Screen.orientation = ScreenOrientation.Portrait;
			RevertResolution();
			SetAllowedOrientations(AllowedOrientations.Portrait | AllowedOrientations.LandscapeLeft | AllowedOrientations.LandscapeRight);
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TopLayerUI_Open, OnTopLayerUIOpen);
		_initialized = true;
		_isShow = false;
	}

	private void OnTopLayerUIOpen(BaseEventContent obj)
	{
		Close();
	}

	protected override void UnInit()
	{
		base.UnInit();
		_closeBtn.OnClick.RemoveListener(Close);
		_reloadBtn.OnClick.RemoveListener(OnClickReloadButton);
		_forwardBtn.OnClick.RemoveListener(OnClickForwardButton);
		_backBtn.OnClick.RemoveListener(OnClickBackButton);
		if (_isPortrait)
		{
			SetAllowedOrientations(_allowedOrientations);
			Screen.orientation = ScreenOrientation.LandscapeLeft;
			Screen.orientation = ScreenOrientation.AutoRotation;
			RevertResolution();
		}
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TopLayerUI_Open, OnTopLayerUIOpen);
		ULiteWebView.Ins.onLoadingUrl -= AddToURLList;
		ULiteWebView.Ins.Close();
		_stackForward.Clear();
		_stackBack.Clear();
		_currentStack = false;
		_currentUrl = string.Empty;
		_isPortrait = false;
		_initialized = false;
		_isShow = false;
		_portraitReady = false;
	}

	private void Update()
	{
		if (_portraitReady && !_isShow)
		{
			_isShow = true;
			OpenWebView();
		}
		if (_isPortrait && Screen.orientation == ScreenOrientation.Portrait && _initialized && !_portraitReady)
		{
			_portraitReady = true;
			OpenWebView();
		}
	}

	protected override void OpenEffectCallback()
	{
		_initialized = true;
	}

	public void OpenWebView()
	{
		ULiteWebView.Ins.Close();
		var (top, bottom, left, right) = GetRectScreenPoint(webView, _corners);
		ULiteWebView.Ins.Show(top, bottom, left, right);
		ULiteWebView.Ins.LoadUrl(_currentUrl);
	}

	private (int, int, int, int) GetRectScreenPoint(RectTransform rect, Vector3[] corners)
	{
		Canvas rootCanvas = Singleton<NewUIManager>.instance.RootCanvas;
		rect.GetWorldCorners(corners);
		corners[0] = GameUtility.uiCamera.WorldToScreenPoint(corners[0]);
		float y = corners[0].y;
		float x = corners[0].x;
		corners[2] = GameUtility.uiCamera.WorldToScreenPoint(corners[2]);
		float num = (float)Screen.height - corners[2].y;
		float num2 = (float)Screen.width - corners[2].x;
		float num3 = num / rootCanvas.scaleFactor;
		y /= rootCanvas.scaleFactor;
		x /= rootCanvas.scaleFactor;
		num2 /= rootCanvas.scaleFactor;
		return ((int)num3, (int)y, (int)x, (int)num2);
	}

	protected override void CloseEffectCallback()
	{
		ULiteWebView.Ins.Close();
	}

	private void AddToURLList(string url)
	{
		if (_currentStack)
		{
			_currentStack = false;
		}
		else
		{
			_stackBack.Push(url);
		}
		_currentUrl = url;
	}

	public void OnClickForwardButton()
	{
		if (_stackForward.Count == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("前进栈中没有东西");
			}
		}
		else
		{
			_currentStack = true;
			_currentUrl = _stackForward.Pop();
			_stackBack.Push(_currentUrl);
			ULiteWebView.Ins.LoadUrl(_currentUrl);
		}
	}

	public void OnClickBackButton()
	{
		if (_stackBack.Count == 0)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("后退栈中没有东西");
			}
		}
		else
		{
			_currentStack = true;
			_currentUrl = _stackBack.Pop();
			_stackForward.Push(_currentUrl);
			ULiteWebView.Ins.LoadUrl(_currentUrl);
		}
	}

	public void OnClickReloadButton()
	{
		ULiteWebView.Ins.LoadUrl(_currentUrl);
	}

	private void SetAllowedOrientations(AllowedOrientations orientations)
	{
		Screen.autorotateToPortrait = (orientations & AllowedOrientations.Portrait) != 0;
		Screen.autorotateToPortraitUpsideDown = (orientations & AllowedOrientations.PortraitUpsideDown) != 0;
		Screen.autorotateToLandscapeLeft = (orientations & AllowedOrientations.LandscapeLeft) != 0;
		Screen.autorotateToLandscapeRight = (orientations & AllowedOrientations.LandscapeRight) != 0;
	}

	private void RevertResolution()
	{
		CanvasScaler component = Singleton<NewUIManager>.instance.RootCanvas.GetComponent<CanvasScaler>();
		component.referenceResolution = new Vector2(component.referenceResolution.y, component.referenceResolution.x);
	}

	private void OnDisable()
	{
		_isShow = false;
	}
}
