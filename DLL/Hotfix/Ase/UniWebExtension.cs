using System;
using UnityEngine;

namespace Ase;

public static class UniWebExtension
{
	public static string OpenWebViewWithUid(this UniWebComponent uniWebComponent, string url, RectTransform reference, bool useToolBar, Action<UniWebViewMessage> onMessage, Action<int, string, UniWebViewNativeResultPayload> onError)
	{
		ServiceSystem instance = Singleton<ServiceSystem>.Instance;
		if (instance == null || instance.GetService<IRoleService>()?.Uid != 0)
		{
			url = InjectParamsToUrl(url, "uid", Singleton<ServiceSystem>.Instance?.GetService<IRoleService>()?.Uid.ToString());
		}
		return uniWebComponent.OpenWebView(url, reference, useToolBar, onMessage, onError);
	}

	public static string OpenWebViewWithUid(this UniWebComponent uniWebComponent, string url, Rect frame, bool useToolBar, Action<UniWebViewMessage> onMessage, Action<int, string, UniWebViewNativeResultPayload> onError)
	{
		ServiceSystem instance = Singleton<ServiceSystem>.Instance;
		if (instance == null || instance.GetService<IRoleService>()?.Uid != 0)
		{
			url = InjectParamsToUrl(url, "uid", Singleton<ServiceSystem>.Instance?.GetService<IRoleService>()?.Uid.ToString());
		}
		return uniWebComponent.OpenWebView(url, frame, useToolBar, onMessage, onError);
	}

	private static string InjectParamsToUrl(string url, string key, string value)
	{
		if (url.Contains("?"))
		{
			return url + "&" + key + "=" + value;
		}
		return url + "?" + key + "=" + value;
	}
}
