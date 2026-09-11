using System;
using LuaInterface;

public class MusicDataForExchangeWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(MusicDataForExchange), typeof(object));
		L.RegFunction("New", _CreateMusicDataForExchange);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("musicPath", get_musicPath, set_musicPath);
		L.RegVar("cueSheetName", get_cueSheetName, set_cueSheetName);
		L.RegVar("cueName", get_cueName, set_cueName);
		L.RegVar("awbFile", get_awbFile, set_awbFile);
		L.RegVar("aisacKey", get_aisacKey, set_aisacKey);
		L.RegVar("aisacValue", get_aisacValue, set_aisacValue);
		L.RegVar("latency", get_latency, set_latency);
		L.RegVar("judgeLatency", get_judgeLatency, set_judgeLatency);
		L.RegVar("stayTime", get_stayTime, set_stayTime);
		L.RegVar("isVertical", get_isVertical, set_isVertical);
		L.RegVar("spectralType", get_spectralType, set_spectralType);
		L.RegVar("goodArea", get_goodArea, set_goodArea);
		L.RegVar("prefectArea", get_prefectArea, set_prefectArea);
		L.RegVar("perfectPlusArea", get_perfectPlusArea, set_perfectPlusArea);
		L.RegVar("longStartArea", get_longStartArea, set_longStartArea);
		L.RegVar("longEndArea", get_longEndArea, set_longEndArea);
		L.RegVar("interval", get_interval, set_interval);
		L.RegVar("preparationTime", get_preparationTime, set_preparationTime);
		L.RegVar("constantSpeed", get_constantSpeed, set_constantSpeed);
		L.RegVar("isConstant", get_isConstant, set_isConstant);
		L.RegVar("mixRange", get_mixRange, set_mixRange);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateMusicDataForExchange(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				MusicDataForExchange o = new MusicDataForExchange();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: MusicDataForExchange.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_musicPath(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string musicPath = ((MusicDataForExchange)obj).musicPath;
			LuaDLL.lua_pushstring(L, musicPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index musicPath on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cueSheetName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string cueSheetName = ((MusicDataForExchange)obj).cueSheetName;
			LuaDLL.lua_pushstring(L, cueSheetName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueSheetName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cueName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string cueName = ((MusicDataForExchange)obj).cueName;
			LuaDLL.lua_pushstring(L, cueName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_awbFile(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string awbFile = ((MusicDataForExchange)obj).awbFile;
			LuaDLL.lua_pushstring(L, awbFile);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index awbFile on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_aisacKey(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string aisacKey = ((MusicDataForExchange)obj).aisacKey;
			LuaDLL.lua_pushstring(L, aisacKey);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index aisacKey on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_aisacValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float aisacValue = ((MusicDataForExchange)obj).aisacValue;
			LuaDLL.lua_pushnumber(L, aisacValue);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index aisacValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_latency(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int latency = ((MusicDataForExchange)obj).latency;
			LuaDLL.lua_pushinteger(L, latency);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index latency on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_judgeLatency(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int judgeLatency = ((MusicDataForExchange)obj).judgeLatency;
			LuaDLL.lua_pushinteger(L, judgeLatency);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index judgeLatency on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_stayTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int stayTime = ((MusicDataForExchange)obj).stayTime;
			LuaDLL.lua_pushinteger(L, stayTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stayTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isVertical(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isVertical = ((MusicDataForExchange)obj).isVertical;
			LuaDLL.lua_pushboolean(L, isVertical);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isVertical on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spectralType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int spectralType = ((MusicDataForExchange)obj).spectralType;
			LuaDLL.lua_pushinteger(L, spectralType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spectralType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_goodArea(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int goodArea = ((MusicDataForExchange)obj).goodArea;
			LuaDLL.lua_pushinteger(L, goodArea);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goodArea on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_prefectArea(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int prefectArea = ((MusicDataForExchange)obj).prefectArea;
			LuaDLL.lua_pushinteger(L, prefectArea);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index prefectArea on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_perfectPlusArea(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int perfectPlusArea = ((MusicDataForExchange)obj).perfectPlusArea;
			LuaDLL.lua_pushinteger(L, perfectPlusArea);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index perfectPlusArea on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_longStartArea(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int longStartArea = ((MusicDataForExchange)obj).longStartArea;
			LuaDLL.lua_pushinteger(L, longStartArea);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index longStartArea on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_longEndArea(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int longEndArea = ((MusicDataForExchange)obj).longEndArea;
			LuaDLL.lua_pushinteger(L, longEndArea);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index longEndArea on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_interval(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int interval = ((MusicDataForExchange)obj).interval;
			LuaDLL.lua_pushinteger(L, interval);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interval on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_preparationTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int preparationTime = ((MusicDataForExchange)obj).preparationTime;
			LuaDLL.lua_pushinteger(L, preparationTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preparationTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_constantSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float constantSpeed = ((MusicDataForExchange)obj).constantSpeed;
			LuaDLL.lua_pushnumber(L, constantSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index constantSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isConstant(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isConstant = ((MusicDataForExchange)obj).isConstant;
			LuaDLL.lua_pushboolean(L, isConstant);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isConstant on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mixRange(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float mixRange = ((MusicDataForExchange)obj).mixRange;
			LuaDLL.lua_pushnumber(L, mixRange);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mixRange on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_musicPath(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			string musicPath = ToLua.CheckString(L, 2);
			obj2.musicPath = musicPath;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index musicPath on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cueSheetName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			string cueSheetName = ToLua.CheckString(L, 2);
			obj2.cueSheetName = cueSheetName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueSheetName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cueName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			string cueName = ToLua.CheckString(L, 2);
			obj2.cueName = cueName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_awbFile(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			string awbFile = ToLua.CheckString(L, 2);
			obj2.awbFile = awbFile;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index awbFile on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_aisacKey(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			string aisacKey = ToLua.CheckString(L, 2);
			obj2.aisacKey = aisacKey;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index aisacKey on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_aisacValue(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			float aisacValue = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.aisacValue = aisacValue;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index aisacValue on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_latency(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			int latency = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.latency = latency;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index latency on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_judgeLatency(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			int judgeLatency = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.judgeLatency = judgeLatency;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index judgeLatency on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_stayTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			int stayTime = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.stayTime = stayTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index stayTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isVertical(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			bool isVertical = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isVertical = isVertical;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isVertical on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spectralType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			int spectralType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.spectralType = spectralType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spectralType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_goodArea(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			int goodArea = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.goodArea = goodArea;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index goodArea on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_prefectArea(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			int prefectArea = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.prefectArea = prefectArea;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index prefectArea on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_perfectPlusArea(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			int perfectPlusArea = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.perfectPlusArea = perfectPlusArea;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index perfectPlusArea on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_longStartArea(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			int longStartArea = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.longStartArea = longStartArea;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index longStartArea on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_longEndArea(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			int longEndArea = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.longEndArea = longEndArea;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index longEndArea on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_interval(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			int interval = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.interval = interval;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index interval on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_preparationTime(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			int preparationTime = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.preparationTime = preparationTime;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index preparationTime on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_constantSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			float constantSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.constantSpeed = constantSpeed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index constantSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isConstant(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			bool isConstant = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isConstant = isConstant;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isConstant on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mixRange(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MusicDataForExchange obj2 = (MusicDataForExchange)obj;
			float mixRange = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.mixRange = mixRange;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mixRange on a nil value");
		}
	}
}
