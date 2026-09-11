using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class QWorldMaxMapUIWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWorldMaxMapUI), typeof(MonoBehaviour));
		L.RegFunction("Init", Init);
		L.RegFunction("Dispose", Dispose);
		L.RegFunction("GetAngleBetweenVectors", GetAngleBetweenVectors);
		L.RegFunction("SelectInMaxMap", SelectInMaxMap);
		L.RegFunction("SelectPlayerInMaxMap", SelectPlayerInMaxMap);
		L.RegFunction("SetMapPos", SetMapPos);
		L.RegFunction("GetSelectEntityEntityIds", GetSelectEntityEntityIds);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("image", get_image, set_image);
		L.RegVar("agentIcon", get_agentIcon, set_agentIcon);
		L.RegVar("agentIcon_D", get_agentIcon_D, set_agentIcon_D);
		L.RegVar("agentArrow", get_agentArrow, set_agentArrow);
		L.RegVar("agentPlayer", get_agentPlayer, set_agentPlayer);
		L.RegVar("mapContent", get_mapContent, set_mapContent);
		L.RegVar("MapContentHalfSize", get_MapContentHalfSize, set_MapContentHalfSize);
		L.RegVar("mapImag", get_mapImag, set_mapImag);
		L.RegVar("slider", get_slider, set_slider);
		L.RegVar("OnMapUnitSelectAction", get_OnMapUnitSelectAction, set_OnMapUnitSelectAction);
		L.RegVar("MAX_MAP_RATIO", get_MAX_MAP_RATIO, set_MAX_MAP_RATIO);
		L.RegVar("AGENT_POSITION_OFFSET", get_AGENT_POSITION_OFFSET, set_AGENT_POSITION_OFFSET);
		L.RegVar("zoomSpeed", get_zoomSpeed, set_zoomSpeed);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Init(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 9);
			QWorldMaxMapUI obj = (QWorldMaxMapUI)ToLua.CheckObject<QWorldMaxMapUI>(L, 1);
			string path = ToLua.CheckString(L, 2);
			float width = (float)LuaDLL.luaL_checknumber(L, 3);
			float height = (float)LuaDLL.luaL_checknumber(L, 4);
			float map_rate = (float)LuaDLL.luaL_checknumber(L, 5);
			Vector3 center_offset = ToLua.ToVector3(L, 6);
			float initialscale = (float)LuaDLL.luaL_checknumber(L, 7);
			float maxscale = (float)LuaDLL.luaL_checknumber(L, 8);
			float miniscale = (float)LuaDLL.luaL_checknumber(L, 9);
			obj.Init(path, width, height, map_rate, center_offset, initialscale, maxscale, miniscale);
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
			((QWorldMaxMapUI)ToLua.CheckObject<QWorldMaxMapUI>(L, 1)).Dispose();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAngleBetweenVectors(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Vector3 a = ToLua.ToVector3(L, 1);
			Vector3 b = ToLua.ToVector3(L, 2);
			Vector3 axis = ToLua.ToVector3(L, 3);
			float angleBetweenVectors = QWorldMaxMapUI.GetAngleBetweenVectors(a, b, axis);
			LuaDLL.lua_pushnumber(L, angleBetweenVectors);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SelectInMaxMap(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMaxMapUI obj = (QWorldMaxMapUI)ToLua.CheckObject<QWorldMaxMapUI>(L, 1);
			int entityId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SelectInMaxMap(entityId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SelectPlayerInMaxMap(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWorldMaxMapUI)ToLua.CheckObject<QWorldMaxMapUI>(L, 1)).SelectPlayerInMaxMap();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMapPos(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMaxMapUI obj = (QWorldMaxMapUI)ToLua.CheckObject<QWorldMaxMapUI>(L, 1);
			Vector2 mapPos = ToLua.ToVector2(L, 2);
			obj.SetMapPos(mapPos);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSelectEntityEntityIds(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int[] selectEntityEntityIds = ((QWorldMaxMapUI)ToLua.CheckObject<QWorldMaxMapUI>(L, 1)).GetSelectEntityEntityIds();
			ToLua.Push(L, selectEntityEntityIds);
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
	private static int get_image(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Image image = ((QWorldMaxMapUI)obj).image;
			ToLua.Push(L, image);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index image on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_agentIcon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform agentIcon = ((QWorldMaxMapUI)obj).agentIcon;
			ToLua.PushSealed(L, agentIcon);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentIcon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_agentIcon_D(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform agentIcon_D = ((QWorldMaxMapUI)obj).agentIcon_D;
			ToLua.PushSealed(L, agentIcon_D);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentIcon_D on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_agentArrow(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform agentArrow = ((QWorldMaxMapUI)obj).agentArrow;
			ToLua.PushSealed(L, agentArrow);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentArrow on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_agentPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform agentPlayer = ((QWorldMaxMapUI)obj).agentPlayer;
			ToLua.PushSealed(L, agentPlayer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mapContent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform mapContent = ((QWorldMaxMapUI)obj).mapContent;
			ToLua.PushSealed(L, mapContent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapContent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MapContentHalfSize(IntPtr L)
	{
		try
		{
			ToLua.Push(L, QWorldMaxMapUI.MapContentHalfSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mapImag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RectTransform mapImag = ((QWorldMaxMapUI)obj).mapImag;
			ToLua.PushSealed(L, mapImag);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mapImag on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_slider(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Slider slider = ((QWorldMaxMapUI)obj).slider;
			ToLua.Push(L, slider);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index slider on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnMapUnitSelectAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action onMapUnitSelectAction = ((QWorldMaxMapUI)obj).OnMapUnitSelectAction;
			ToLua.Push(L, onMapUnitSelectAction);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnMapUnitSelectAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MAX_MAP_RATIO(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushnumber(L, QWorldMaxMapUI.MAX_MAP_RATIO);
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
			ToLua.Push(L, QWorldMaxMapUI.AGENT_POSITION_OFFSET);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_zoomSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float zoomSpeed = ((QWorldMaxMapUI)obj).zoomSpeed;
			LuaDLL.lua_pushnumber(L, zoomSpeed);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index zoomSpeed on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_image(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMaxMapUI obj2 = (QWorldMaxMapUI)obj;
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
	private static int set_agentIcon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMaxMapUI obj2 = (QWorldMaxMapUI)obj;
			RectTransform agentIcon = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.agentIcon = agentIcon;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentIcon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_agentIcon_D(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMaxMapUI obj2 = (QWorldMaxMapUI)obj;
			RectTransform agentIcon_D = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.agentIcon_D = agentIcon_D;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentIcon_D on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_agentArrow(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMaxMapUI obj2 = (QWorldMaxMapUI)obj;
			RectTransform agentArrow = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.agentArrow = agentArrow;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentArrow on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_agentPlayer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMaxMapUI obj2 = (QWorldMaxMapUI)obj;
			RectTransform agentPlayer = (RectTransform)ToLua.CheckObject(L, 2, typeof(RectTransform));
			obj2.agentPlayer = agentPlayer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index agentPlayer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapContent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMaxMapUI obj2 = (QWorldMaxMapUI)obj;
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
	private static int set_MapContentHalfSize(IntPtr L)
	{
		try
		{
			QWorldMaxMapUI.MapContentHalfSize = ToLua.ToVector2(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mapImag(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMaxMapUI obj2 = (QWorldMaxMapUI)obj;
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
	private static int set_slider(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMaxMapUI obj2 = (QWorldMaxMapUI)obj;
			Slider slider = (Slider)ToLua.CheckObject<Slider>(L, 2);
			obj2.slider = slider;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index slider on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnMapUnitSelectAction(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMaxMapUI obj2 = (QWorldMaxMapUI)obj;
			Action onMapUnitSelectAction = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.OnMapUnitSelectAction = onMapUnitSelectAction;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnMapUnitSelectAction on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_MAX_MAP_RATIO(IntPtr L)
	{
		try
		{
			QWorldMaxMapUI.MAX_MAP_RATIO = (float)LuaDLL.luaL_checknumber(L, 2);
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
			QWorldMaxMapUI.AGENT_POSITION_OFFSET = ToLua.ToVector3(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_zoomSpeed(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMaxMapUI obj2 = (QWorldMaxMapUI)obj;
			float zoomSpeed = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.zoomSpeed = zoomSpeed;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index zoomSpeed on a nil value");
		}
	}
}
