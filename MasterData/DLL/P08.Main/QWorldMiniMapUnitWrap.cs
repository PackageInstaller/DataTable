using System;
using LuaInterface;
using UnityEngine;

public class QWorldMiniMapUnitWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWorldMiniMapUnit), typeof(object));
		L.RegFunction("Dispose", Dispose);
		L.RegFunction("SetAllDirty", SetAllDirty);
		L.RegFunction("SetIcon", SetIcon);
		L.RegFunction("SetSelect", SetSelect);
		L.RegFunction("SetMiniType", SetMiniType);
		L.RegFunction("SetMapDisplay", SetMapDisplay);
		L.RegFunction("SetMapTrackShow", SetMapTrackShow);
		L.RegFunction("GetMiniMapDisplay", GetMiniMapDisplay);
		L.RegFunction("GetMaxMapDisplay", GetMaxMapDisplay);
		L.RegFunction("New", _CreateQWorldMiniMapUnit);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("tags", get_tags, set_tags);
		L.RegVar("m_miniDirty", get_m_miniDirty, set_m_miniDirty);
		L.RegVar("m_maxDirty", get_m_maxDirty, set_m_maxDirty);
		L.RegVar("EntityEntityId", get_EntityEntityId, null);
		L.RegVar("MiniMapType", get_MiniMapType, null);
		L.RegVar("Icon", get_Icon, null);
		L.RegVar("IconType", get_IconType, null);
		L.RegVar("baseIcon", get_baseIcon, null);
		L.RegVar("Select", get_Select, null);
		L.RegVar("MapDisplay", get_MapDisplay, null);
		L.RegVar("TrackShow", get_TrackShow, null);
		L.RegVar("IsTrack", get_IsTrack, null);
		L.RegVar("Position", get_Position, null);
		L.RegVar("Rotation", get_Rotation, null);
		L.RegVar("VolumeSize", get_VolumeSize, null);
		L.RegVar("Radius", get_Radius, null);
		L.RegVar("ZoneType", get_ZoneType, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateQWorldMiniMapUnit(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 3)
			{
				QWorldMap qWorldMap = (QWorldMap)ToLua.CheckObject<QWorldMap>(L, 1);
				int entityId = (int)LuaDLL.luaL_checknumber(L, 2);
				Transform entityTransform = (Transform)ToLua.CheckObject<Transform>(L, 3);
				QWorldMiniMapUnit o = new QWorldMiniMapUnit(qWorldMap, entityId, entityTransform);
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: QWorldMiniMapUnit.New");
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
			((QWorldMiniMapUnit)ToLua.CheckObject<QWorldMiniMapUnit>(L, 1)).Dispose();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetAllDirty(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWorldMiniMapUnit)ToLua.CheckObject<QWorldMiniMapUnit>(L, 1)).SetAllDirty();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetIcon(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				QWorldMiniMapUnit obj3 = (QWorldMiniMapUnit)ToLua.CheckObject<QWorldMiniMapUnit>(L, 1);
				string path3 = ToLua.CheckString(L, 2);
				obj3.SetIcon(path3);
				return 0;
			}
			case 3:
			{
				QWorldMiniMapUnit obj2 = (QWorldMiniMapUnit)ToLua.CheckObject<QWorldMiniMapUnit>(L, 1);
				string path2 = ToLua.CheckString(L, 2);
				int iconType2 = (int)LuaDLL.luaL_checknumber(L, 3);
				obj2.SetIcon(path2, iconType2);
				return 0;
			}
			case 4:
			{
				QWorldMiniMapUnit obj = (QWorldMiniMapUnit)ToLua.CheckObject<QWorldMiniMapUnit>(L, 1);
				string path = ToLua.CheckString(L, 2);
				int iconType = (int)LuaDLL.luaL_checknumber(L, 3);
				string basePath = ToLua.CheckString(L, 4);
				obj.SetIcon(path, iconType, basePath);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorldMiniMapUnit.SetIcon");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSelect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMiniMapUnit obj = (QWorldMiniMapUnit)ToLua.CheckObject<QWorldMiniMapUnit>(L, 1);
			bool flag = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetSelect(flag);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMiniType(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMiniMapUnit obj = (QWorldMiniMapUnit)ToLua.CheckObject<QWorldMiniMapUnit>(L, 1);
			int miniType = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetMiniType(miniType);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMapDisplay(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMiniMapUnit obj = (QWorldMiniMapUnit)ToLua.CheckObject<QWorldMiniMapUnit>(L, 1);
			int mapDisplay = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetMapDisplay(mapDisplay);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetMapTrackShow(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMiniMapUnit obj = (QWorldMiniMapUnit)ToLua.CheckObject<QWorldMiniMapUnit>(L, 1);
			bool mapTrackShow = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetMapTrackShow(mapTrackShow);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMiniMapDisplay(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool miniMapDisplay = ((QWorldMiniMapUnit)ToLua.CheckObject<QWorldMiniMapUnit>(L, 1)).GetMiniMapDisplay();
			LuaDLL.lua_pushboolean(L, miniMapDisplay);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMaxMapDisplay(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool maxMapDisplay = ((QWorldMiniMapUnit)ToLua.CheckObject<QWorldMiniMapUnit>(L, 1)).GetMaxMapDisplay();
			LuaDLL.lua_pushboolean(L, maxMapDisplay);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tags(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int tags = ((QWorldMiniMapUnit)obj).tags;
			LuaDLL.lua_pushinteger(L, tags);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tags on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_miniDirty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool miniDirty = ((QWorldMiniMapUnit)obj).m_miniDirty;
			LuaDLL.lua_pushboolean(L, miniDirty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_miniDirty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_m_maxDirty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool maxDirty = ((QWorldMiniMapUnit)obj).m_maxDirty;
			LuaDLL.lua_pushboolean(L, maxDirty);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_maxDirty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_EntityEntityId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int entityEntityId = ((QWorldMiniMapUnit)obj).EntityEntityId;
			LuaDLL.lua_pushinteger(L, entityEntityId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index EntityEntityId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MiniMapType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int miniMapType = ((QWorldMiniMapUnit)obj).MiniMapType;
			LuaDLL.lua_pushinteger(L, miniMapType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MiniMapType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Icon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string icon = ((QWorldMiniMapUnit)obj).Icon;
			LuaDLL.lua_pushstring(L, icon);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Icon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IconType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int iconType = ((QWorldMiniMapUnit)obj).IconType;
			LuaDLL.lua_pushinteger(L, iconType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IconType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_baseIcon(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string baseIcon = ((QWorldMiniMapUnit)obj).baseIcon;
			LuaDLL.lua_pushstring(L, baseIcon);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index baseIcon on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Select(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool value = ((QWorldMiniMapUnit)obj).Select;
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Select on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_MapDisplay(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int mapDisplay = ((QWorldMiniMapUnit)obj).MapDisplay;
			LuaDLL.lua_pushinteger(L, mapDisplay);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index MapDisplay on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_TrackShow(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool trackShow = ((QWorldMiniMapUnit)obj).TrackShow;
			LuaDLL.lua_pushboolean(L, trackShow);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index TrackShow on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_IsTrack(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isTrack = ((QWorldMiniMapUnit)obj).IsTrack;
			LuaDLL.lua_pushboolean(L, isTrack);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index IsTrack on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 position = ((QWorldMiniMapUnit)obj).Position;
			ToLua.Push(L, position);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Rotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Quaternion rotation = ((QWorldMiniMapUnit)obj).Rotation;
			ToLua.Push(L, rotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Rotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_VolumeSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 volumeSize = ((QWorldMiniMapUnit)obj).VolumeSize;
			ToLua.Push(L, volumeSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index VolumeSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Radius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float radius = ((QWorldMiniMapUnit)obj).Radius;
			LuaDLL.lua_pushnumber(L, radius);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index Radius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_ZoneType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int zoneType = ((QWorldMiniMapUnit)obj).ZoneType;
			LuaDLL.lua_pushinteger(L, zoneType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index ZoneType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tags(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMiniMapUnit obj2 = (QWorldMiniMapUnit)obj;
			int tags = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.tags = tags;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tags on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_miniDirty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMiniMapUnit obj2 = (QWorldMiniMapUnit)obj;
			bool miniDirty = LuaDLL.luaL_checkboolean(L, 2);
			obj2.m_miniDirty = miniDirty;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_miniDirty on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_m_maxDirty(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMiniMapUnit obj2 = (QWorldMiniMapUnit)obj;
			bool maxDirty = LuaDLL.luaL_checkboolean(L, 2);
			obj2.m_maxDirty = maxDirty;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index m_maxDirty on a nil value");
		}
	}
}
