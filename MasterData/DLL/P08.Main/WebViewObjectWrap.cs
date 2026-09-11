using System;
using LuaInterface;
using UnityEngine;

public class WebViewObjectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(WebViewObject), typeof(MonoBehaviour));
		L.RegFunction("IsWebViewAvailable", IsWebViewAvailable);
		L.RegFunction("Init", Init);
		L.RegFunction("SetCenterPositionWithScale", SetCenterPositionWithScale);
		L.RegFunction("SetMargins", SetMargins);
		L.RegFunction("SetVisibility", SetVisibility);
		L.RegFunction("GetVisibility", GetVisibility);
		L.RegFunction("SetAlertDialogEnabled", SetAlertDialogEnabled);
		L.RegFunction("GetAlertDialogEnabled", GetAlertDialogEnabled);
		L.RegFunction("SetScrollBounceEnabled", SetScrollBounceEnabled);
		L.RegFunction("GetScrollBounceEnabled", GetScrollBounceEnabled);
		L.RegFunction("SetURLPattern", SetURLPattern);
		L.RegFunction("LoadURL", LoadURL);
		L.RegFunction("LoadHTML", LoadHTML);
		L.RegFunction("EvaluateJS", EvaluateJS);
		L.RegFunction("Progress", Progress);
		L.RegFunction("CanGoBack", CanGoBack);
		L.RegFunction("CanGoForward", CanGoForward);
		L.RegFunction("GoBack", GoBack);
		L.RegFunction("GoForward", GoForward);
		L.RegFunction("CallOnError", CallOnError);
		L.RegFunction("CallOnHttpError", CallOnHttpError);
		L.RegFunction("CallOnStarted", CallOnStarted);
		L.RegFunction("CallOnLoaded", CallOnLoaded);
		L.RegFunction("CallFromJS", CallFromJS);
		L.RegFunction("CallOnHooked", CallOnHooked);
		L.RegFunction("AddCustomHeader", AddCustomHeader);
		L.RegFunction("GetCustomHeaderValue", GetCustomHeaderValue);
		L.RegFunction("RemoveCustomHeader", RemoveCustomHeader);
		L.RegFunction("ClearCustomHeader", ClearCustomHeader);
		L.RegFunction("ClearCookies", ClearCookies);
		L.RegFunction("SaveCookies", SaveCookies);
		L.RegFunction("GetCookies", GetCookies);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("IsKeyboardVisible", get_IsKeyboardVisible, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsWebViewAvailable(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = WebViewObject.IsWebViewAvailable();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Init(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1)).Init();
				return 0;
			case 2:
			{
				WebViewObject obj9 = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
				Action<string> cb9 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 2);
				obj9.Init(cb9);
				return 0;
			}
			case 3:
			{
				WebViewObject obj8 = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
				Action<string> cb8 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 2);
				bool transparent8 = LuaDLL.luaL_checkboolean(L, 3);
				obj8.Init(cb8, transparent8);
				return 0;
			}
			case 4:
			{
				WebViewObject obj7 = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
				Action<string> cb7 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 2);
				bool transparent7 = LuaDLL.luaL_checkboolean(L, 3);
				string ua7 = ToLua.CheckString(L, 4);
				obj7.Init(cb7, transparent7, ua7);
				return 0;
			}
			case 5:
			{
				WebViewObject obj6 = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
				Action<string> cb6 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 2);
				bool transparent6 = LuaDLL.luaL_checkboolean(L, 3);
				string ua6 = ToLua.CheckString(L, 4);
				Action<string> err6 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 5);
				obj6.Init(cb6, transparent6, ua6, err6);
				return 0;
			}
			case 6:
			{
				WebViewObject obj5 = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
				Action<string> cb5 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 2);
				bool transparent5 = LuaDLL.luaL_checkboolean(L, 3);
				string ua5 = ToLua.CheckString(L, 4);
				Action<string> err5 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 5);
				Action<string> httpErr5 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 6);
				obj5.Init(cb5, transparent5, ua5, err5, httpErr5);
				return 0;
			}
			case 7:
			{
				WebViewObject obj4 = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
				Action<string> cb4 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 2);
				bool transparent4 = LuaDLL.luaL_checkboolean(L, 3);
				string ua4 = ToLua.CheckString(L, 4);
				Action<string> err4 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 5);
				Action<string> httpErr4 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 6);
				Action<string> ld4 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 7);
				obj4.Init(cb4, transparent4, ua4, err4, httpErr4, ld4);
				return 0;
			}
			case 8:
			{
				WebViewObject obj3 = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
				Action<string> cb3 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 2);
				bool transparent3 = LuaDLL.luaL_checkboolean(L, 3);
				string ua3 = ToLua.CheckString(L, 4);
				Action<string> err3 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 5);
				Action<string> httpErr3 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 6);
				Action<string> ld3 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 7);
				bool enableWKWebView3 = LuaDLL.luaL_checkboolean(L, 8);
				obj3.Init(cb3, transparent3, ua3, err3, httpErr3, ld3, enableWKWebView3);
				return 0;
			}
			case 9:
			{
				WebViewObject obj2 = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
				Action<string> cb2 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 2);
				bool transparent2 = LuaDLL.luaL_checkboolean(L, 3);
				string ua2 = ToLua.CheckString(L, 4);
				Action<string> err2 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 5);
				Action<string> httpErr2 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 6);
				Action<string> ld2 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 7);
				bool enableWKWebView2 = LuaDLL.luaL_checkboolean(L, 8);
				Action<string> started2 = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 9);
				obj2.Init(cb2, transparent2, ua2, err2, httpErr2, ld2, enableWKWebView2, started2);
				return 0;
			}
			case 10:
			{
				WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
				Action<string> cb = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 2);
				bool transparent = LuaDLL.luaL_checkboolean(L, 3);
				string ua = ToLua.CheckString(L, 4);
				Action<string> err = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 5);
				Action<string> httpErr = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 6);
				Action<string> ld = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 7);
				bool enableWKWebView = LuaDLL.luaL_checkboolean(L, 8);
				Action<string> started = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 9);
				Action<string> hooked = (Action<string>)ToLua.CheckDelegate<Action<string>>(L, 10);
				obj.Init(cb, transparent, ua, err, httpErr, ld, enableWKWebView, started, hooked);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: WebViewObject.Init");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCenterPositionWithScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			Vector2 center = ToLua.ToVector2(L, 2);
			Vector2 scale = ToLua.ToVector2(L, 3);
			obj.SetCenterPositionWithScale(center, scale);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMargins(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 5:
			{
				WebViewObject obj2 = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
				int left2 = (int)LuaDLL.luaL_checknumber(L, 2);
				int top2 = (int)LuaDLL.luaL_checknumber(L, 3);
				int right2 = (int)LuaDLL.luaL_checknumber(L, 4);
				int bottom2 = (int)LuaDLL.luaL_checknumber(L, 5);
				obj2.SetMargins(left2, top2, right2, bottom2);
				return 0;
			}
			case 6:
			{
				WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
				int left = (int)LuaDLL.luaL_checknumber(L, 2);
				int top = (int)LuaDLL.luaL_checknumber(L, 3);
				int right = (int)LuaDLL.luaL_checknumber(L, 4);
				int bottom = (int)LuaDLL.luaL_checknumber(L, 5);
				bool relative = LuaDLL.luaL_checkboolean(L, 6);
				obj.SetMargins(left, top, right, bottom, relative);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: WebViewObject.SetMargins");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetVisibility(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			bool visibility = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetVisibility(visibility);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetVisibility(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool visibility = ((WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1)).GetVisibility();
			LuaDLL.lua_pushboolean(L, visibility);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAlertDialogEnabled(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			bool alertDialogEnabled = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetAlertDialogEnabled(alertDialogEnabled);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAlertDialogEnabled(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool alertDialogEnabled = ((WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1)).GetAlertDialogEnabled();
			LuaDLL.lua_pushboolean(L, alertDialogEnabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetScrollBounceEnabled(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			bool scrollBounceEnabled = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetScrollBounceEnabled(scrollBounceEnabled);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetScrollBounceEnabled(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool scrollBounceEnabled = ((WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1)).GetScrollBounceEnabled();
			LuaDLL.lua_pushboolean(L, scrollBounceEnabled);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetURLPattern(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string allowPattern = ToLua.CheckString(L, 2);
			string denyPattern = ToLua.CheckString(L, 3);
			string hookPattern = ToLua.CheckString(L, 4);
			bool value = obj.SetURLPattern(allowPattern, denyPattern, hookPattern);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadURL(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string url = ToLua.CheckString(L, 2);
			obj.LoadURL(url);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadHTML(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string html = ToLua.CheckString(L, 2);
			string baseUrl = ToLua.CheckString(L, 3);
			obj.LoadHTML(html, baseUrl);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EvaluateJS(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string js = ToLua.CheckString(L, 2);
			obj.EvaluateJS(js);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Progress(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int n = ((WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1)).Progress();
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CanGoBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1)).CanGoBack();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CanGoForward(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1)).CanGoForward();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GoBack(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1)).GoBack();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GoForward(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1)).GoForward();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CallOnError(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string error = ToLua.CheckString(L, 2);
			obj.CallOnError(error);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CallOnHttpError(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string error = ToLua.CheckString(L, 2);
			obj.CallOnHttpError(error);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CallOnStarted(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string url = ToLua.CheckString(L, 2);
			obj.CallOnStarted(url);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CallOnLoaded(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string url = ToLua.CheckString(L, 2);
			obj.CallOnLoaded(url);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CallFromJS(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string message = ToLua.CheckString(L, 2);
			obj.CallFromJS(message);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CallOnHooked(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string message = ToLua.CheckString(L, 2);
			obj.CallOnHooked(message);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddCustomHeader(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string headerKey = ToLua.CheckString(L, 2);
			string headerValue = ToLua.CheckString(L, 3);
			obj.AddCustomHeader(headerKey, headerValue);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCustomHeaderValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string headerKey = ToLua.CheckString(L, 2);
			string customHeaderValue = obj.GetCustomHeaderValue(headerKey);
			LuaDLL.lua_pushstring(L, customHeaderValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveCustomHeader(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string headerKey = ToLua.CheckString(L, 2);
			obj.RemoveCustomHeader(headerKey);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearCustomHeader(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1)).ClearCustomHeader();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearCookies(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1)).ClearCookies();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SaveCookies(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1)).SaveCookies();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCookies(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			WebViewObject obj = (WebViewObject)ToLua.CheckObject<WebViewObject>(L, 1);
			string url = ToLua.CheckString(L, 2);
			string cookies = obj.GetCookies(url);
			LuaDLL.lua_pushstring(L, cookies);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int op_Equality(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			UnityEngine.Object obj = (UnityEngine.Object)ToLua.ToObject(L, 1);
			UnityEngine.Object obj2 = (UnityEngine.Object)ToLua.ToObject(L, 2);
			bool value = obj == obj2;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsKeyboardVisible(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isKeyboardVisible = ((WebViewObject)obj).IsKeyboardVisible;
			LuaDLL.lua_pushboolean(L, isKeyboardVisible);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsKeyboardVisible on a nil value");
		}
	}
}
