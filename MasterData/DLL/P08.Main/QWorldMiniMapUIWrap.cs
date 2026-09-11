using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class QWorldMiniMapUIWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWorldMiniMapUI), typeof(MonoBehaviour));
		L.RegFunction("Init", Init);
		L.RegFunction("Dispose", Dispose);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("image", get_image, set_image);
		L.RegVar("agentArror", get_agentArror, set_agentArror);
		L.RegVar("cameraViewTrans", get_cameraViewTrans, set_cameraViewTrans);
		L.RegVar("mapImag", get_mapImag, set_mapImag);
		L.RegVar("miniEntityContent", get_miniEntityContent, set_miniEntityContent);
		L.RegVar("mapContent", get_mapContent, set_mapContent);
		L.RegVar("MINI_MAP_RATIO", get_MINI_MAP_RATIO, set_MINI_MAP_RATIO);
		L.RegVar("AGENT_POSITION_OFFSET", get_AGENT_POSITION_OFFSET, set_AGENT_POSITION_OFFSET);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Init(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 6);
			QWorldMiniMapUI obj = (QWorldMiniMapUI)ToLua.CheckObject<QWorldMiniMapUI>(L, 1);
			string path = ToLua.CheckString(L, 2);
			float width = (float)LuaDLL.luaL_checknumber(L, 3);
			float height = (float)LuaDLL.luaL_checknumber(L, 4);
			float map_rate = (float)LuaDLL.luaL_checknumber(L, 5);
			Vector3 center_offset = ToLua.ToVector3(L, 6);
			obj.Init(path, width, height, map_rate, center_offset);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Dispose(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWorldMiniMapUI)ToLua.CheckObject<QWorldMiniMapUI>(L, 1)).Dispose();
			return 0;
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
	private static int get_image(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image image = ((QWorldMiniMapUI)obj).image;
			ToLua.Push(L, image);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index image on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_agentArror(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform agentArror = ((QWorldMiniMapUI)obj).agentArror;
			ToLua.PushSealed(L, agentArror);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentArror on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cameraViewTrans(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform cameraViewTrans = ((QWorldMiniMapUI)obj).cameraViewTrans;
			ToLua.PushSealed(L, cameraViewTrans);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cameraViewTrans on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mapImag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform mapImag = ((QWorldMiniMapUI)obj).mapImag;
			ToLua.PushSealed(L, mapImag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapImag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_miniEntityContent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform miniEntityContent = ((QWorldMiniMapUI)obj).miniEntityContent;
			ToLua.PushSealed(L, miniEntityContent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index miniEntityContent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mapContent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform mapContent = ((QWorldMiniMapUI)obj).mapContent;
			ToLua.PushSealed(L, mapContent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapContent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MINI_MAP_RATIO(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, QWorldMiniMapUI.MINI_MAP_RATIO);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AGENT_POSITION_OFFSET(IntPtr L)
	{
		try
		{
			ToLua.Push(L, QWorldMiniMapUI.AGENT_POSITION_OFFSET);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_image(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMiniMapUI obj2 = (QWorldMiniMapUI)obj;
			Image image = (Image)ToLua.CheckObject<Image>(L, 2);
			obj2.image = image;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index image on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_agentArror(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMiniMapUI obj2 = (QWorldMiniMapUI)obj;
			RectTransform agentArror = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.agentArror = agentArror;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentArror on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cameraViewTrans(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMiniMapUI obj2 = (QWorldMiniMapUI)obj;
			RectTransform cameraViewTrans = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.cameraViewTrans = cameraViewTrans;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cameraViewTrans on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapImag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMiniMapUI obj2 = (QWorldMiniMapUI)obj;
			RectTransform mapImag = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.mapImag = mapImag;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapImag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_miniEntityContent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMiniMapUI obj2 = (QWorldMiniMapUI)obj;
			RectTransform miniEntityContent = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.miniEntityContent = miniEntityContent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index miniEntityContent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapContent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMiniMapUI obj2 = (QWorldMiniMapUI)obj;
			RectTransform mapContent = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.mapContent = mapContent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapContent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_MINI_MAP_RATIO(IntPtr L)
	{
		try
		{
			QWorldMiniMapUI.MINI_MAP_RATIO = (float)LuaDLL.luaL_checknumber(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AGENT_POSITION_OFFSET(IntPtr L)
	{
		try
		{
			QWorldMiniMapUI.AGENT_POSITION_OFFSET = ToLua.ToVector3(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
