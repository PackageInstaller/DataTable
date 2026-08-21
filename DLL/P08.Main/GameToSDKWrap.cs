using System;
using LuaInterface;

public class GameToSDKWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("GameToSDK");
		L.RegFunction("GetReady", GetReady);
		L.RegFunction("Initialize", Initialize);
		L.RegFunction("Init", Init);
		L.RegFunction("Login", Login);
		L.RegFunction("Logout", Logout);
		L.RegFunction("LogOff", LogOff);
		L.RegFunction("Exit", Exit);
		L.RegFunction("UpUserInfo", UpUserInfo);
		L.RegFunction("UpUserEvent", UpUserEvent);
		L.RegFunction("GoUserCenter", GoUserCenter);
		L.RegFunction("GetChannelMasterId", GetChannelMasterId);
		L.RegFunction("GetData", GetData);
		L.RegFunction("SendMessage", SendMessage);
		L.RegFunction("Pay", Pay);
		L.RegFunction("GetServerTime", GetServerTime);
		L.RegFunction("SetImageMaxCount", SetImageMaxCount);
		L.RegFunction("UploadImage", UploadImage);
		L.RegFunction("DownloadImage", DownloadImage);
		L.RegFunction("IsAndroidPlatform", IsAndroidPlatform);
		L.RegFunction("IsIOSPlatform", IsIOSPlatform);
		L.RegFunction("IsPCPlatform", IsPCPlatform);
		L.RegFunction("IsEditorPlatform", IsEditorPlatform);
		L.RegFunction("IsEditorOrPcPlatform", IsEditorOrPcPlatform);
		L.RegFunction("IsMobilePlatform", IsMobilePlatform);
		L.RegFunction("IsSDKUIShowing", IsSDKUIShowing);
		L.RegFunction("InitGMSDK", InitGMSDK);
		L.RegFunction("ExChangeGiftCode", ExChangeGiftCode);
		L.RegFunction("RegisterGiftCodeResultEvent", RegisterGiftCodeResultEvent);
		L.RegConstant("SDK_ID_DEV", 0.0);
		L.RegVar("CURRENT_SDK_ID", get_CURRENT_SDK_ID, set_CURRENT_SDK_ID);
		L.RegVar("CURRENT_SERVER", get_CURRENT_SERVER, set_CURRENT_SERVER);
		L.RegVar("SERVER_LIST", get_SERVER_LIST, set_SERVER_LIST);
		L.RegVar("Text_Language", get_Text_Language, set_Text_Language);
		L.RegVar("IsSDKInited", get_IsSDKInited, set_IsSDKInited);
		L.RegVar("IsDeviceInfoGetted", get_IsDeviceInfoGetted, set_IsDeviceInfoGetted);
		L.RegVar("vClientVersionInfo", get_vClientVersionInfo, set_vClientVersionInfo);
		L.RegVar("vClientResVersionInfo", get_vClientResVersionInfo, set_vClientResVersionInfo);
		L.RegVar("pvName", get_pvName, set_pvName);
		L.RegVar("IsUpdateInfoGet", get_IsUpdateInfoGet, set_IsUpdateInfoGet);
		L.RegVar("PLATFORM_ID", get_PLATFORM_ID, set_PLATFORM_ID);
		L.RegVar("clientInfo", get_clientInfo, set_clientInfo);
		L.RegVar("bridge", get_bridge, set_bridge);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetReady(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool ready = GameToSDK.GetReady();
			LuaDLL.lua_pushboolean(L, ready);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Initialize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			GameToSDK.Initialize();
			return 0;
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
			ToLua.CheckArgsCount(L, 1);
			GameToSDK.Init(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Login(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameToSDK.Login(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Logout(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			GameToSDK.Logout();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LogOff(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			GameToSDK.LogOff();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Exit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			GameToSDK.Exit();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpUserInfo(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameToSDK.UpUserInfo(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpUserEvent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameToSDK.UpUserEvent(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GoUserCenter(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			GameToSDK.GoUserCenter();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetChannelMasterId(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			int channelMasterId = GameToSDK.GetChannelMasterId();
			LuaDLL.lua_pushinteger(L, channelMasterId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string data = GameToSDK.GetData(ToLua.CheckString(L, 1));
			LuaDLL.lua_pushstring(L, data);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendMessage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameToSDK.SendMessage(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Pay(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameToSDK.Pay(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetServerTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			GameToSDK.GetServerTime();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetImageMaxCount(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameToSDK.SetImageMaxCount(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UploadImage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameToSDK.UploadImage(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DownloadImage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameToSDK.DownloadImage(ToLua.CheckString(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsAndroidPlatform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = GameToSDK.IsAndroidPlatform();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsIOSPlatform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = GameToSDK.IsIOSPlatform();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsPCPlatform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = GameToSDK.IsPCPlatform();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsEditorPlatform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = GameToSDK.IsEditorPlatform();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsEditorOrPcPlatform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = GameToSDK.IsEditorOrPcPlatform();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsMobilePlatform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = GameToSDK.IsMobilePlatform();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsSDKUIShowing(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = GameToSDK.IsSDKUIShowing();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitGMSDK(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			GameToSDK.InitGMSDK();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ExChangeGiftCode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			string uidSign = ToLua.CheckString(L, 1);
			string giftCode = ToLua.CheckString(L, 2);
			GameToSDK.ExChangeGiftCode(uidSign, giftCode);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RegisterGiftCodeResultEvent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			GameToSDK.RegisterGiftCodeResultEvent(ToLua.CheckLuaFunction(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CURRENT_SDK_ID(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, GameToSDK.CURRENT_SDK_ID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_CURRENT_SERVER(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, GameToSDK.CURRENT_SERVER);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_SERVER_LIST(IntPtr L)
	{
		try
		{
			ToLua.Push(L, GameToSDK.SERVER_LIST);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Text_Language(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, GameToSDK.Text_Language);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsSDKInited(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, GameToSDK.IsSDKInited);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsDeviceInfoGetted(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, GameToSDK.IsDeviceInfoGetted);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vClientVersionInfo(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, GameToSDK.vClientVersionInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_vClientResVersionInfo(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, GameToSDK.vClientResVersionInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_pvName(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, GameToSDK.pvName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsUpdateInfoGet(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushboolean(L, GameToSDK.IsUpdateInfoGet);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_PLATFORM_ID(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, GameToSDK.PLATFORM_ID);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_clientInfo(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, GameToSDK.clientInfo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bridge(IntPtr L)
	{
		try
		{
			ToLua.Push(L, GameToSDK.bridge);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_CURRENT_SDK_ID(IntPtr L)
	{
		try
		{
			GameToSDK.CURRENT_SDK_ID = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_CURRENT_SERVER(IntPtr L)
	{
		try
		{
			GameToSDK.CURRENT_SERVER = ToLua.CheckString(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_SERVER_LIST(IntPtr L)
	{
		try
		{
			GameToSDK.SERVER_LIST = ToLua.CheckStringArray(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Text_Language(IntPtr L)
	{
		try
		{
			GameToSDK.Text_Language = ToLua.CheckString(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_IsSDKInited(IntPtr L)
	{
		try
		{
			GameToSDK.IsSDKInited = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_IsDeviceInfoGetted(IntPtr L)
	{
		try
		{
			GameToSDK.IsDeviceInfoGetted = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_vClientVersionInfo(IntPtr L)
	{
		try
		{
			GameToSDK.vClientVersionInfo = (VersionInfo)ToLua.CheckObject<VersionInfo>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_vClientResVersionInfo(IntPtr L)
	{
		try
		{
			GameToSDK.vClientResVersionInfo = (VersionInfo)ToLua.CheckObject<VersionInfo>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_pvName(IntPtr L)
	{
		try
		{
			GameToSDK.pvName = ToLua.CheckString(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_IsUpdateInfoGet(IntPtr L)
	{
		try
		{
			GameToSDK.IsUpdateInfoGet = LuaDLL.luaL_checkboolean(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_PLATFORM_ID(IntPtr L)
	{
		try
		{
			GameToSDK.PLATFORM_ID = (int)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_clientInfo(IntPtr L)
	{
		try
		{
			GameToSDK.clientInfo = (ClientInfo)ToLua.CheckObject<ClientInfo>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bridge(IntPtr L)
	{
		try
		{
			GameToSDK.bridge = (UnityToSDK)ToLua.CheckObject<UnityToSDK>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
