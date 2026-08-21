using System;
using LuaInterface;
using UnityEngine;

public class QWorldThingEntityDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWorldThingEntityData), typeof(QWorldEntityData));
		L.RegFunction("IsNpc", IsNpc);
		L.RegFunction("IsSphereArea", IsSphereArea);
		L.RegFunction("IsSpriteRender", IsSpriteRender);
		L.RegFunction("New", _CreateQWorldThingEntityData);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("script_name", get_script_name, set_script_name);
		L.RegVar("spawn_type", get_spawn_type, set_spawn_type);
		L.RegVar("spawn_task_id", get_spawn_task_id, set_spawn_task_id);
		L.RegVar("defaultAnim", get_defaultAnim, set_defaultAnim);
		L.RegVar("defaultInteractive", get_defaultInteractive, set_defaultInteractive);
		L.RegVar("customIdle", get_customIdle, set_customIdle);
		L.RegVar("configId", get_configId, set_configId);
		L.RegVar("teleportId", get_teleportId, set_teleportId);
		L.RegVar("distance", get_distance, set_distance);
		L.RegVar("camera", get_camera, set_camera);
		L.RegVar("lookAtType", get_lookAtType, set_lookAtType);
		L.RegVar("lookAtEntityId", get_lookAtEntityId, set_lookAtEntityId);
		L.RegVar("lookAtPoint", get_lookAtPoint, set_lookAtPoint);
		L.RegVar("enterRadius", get_enterRadius, set_enterRadius);
		L.RegVar("exitRadius", get_exitRadius, set_exitRadius);
		L.RegVar("isAreaNode", get_isAreaNode, set_isAreaNode);
		L.RegVar("index", get_index, set_index);
		L.RegVar("isLast", get_isLast, set_isLast);
		L.RegVar("startEffect", get_startEffect, set_startEffect);
		L.RegVar("startLoopEffect", get_startLoopEffect, set_startLoopEffect);
		L.RegVar("collectStartEffect", get_collectStartEffect, set_collectStartEffect);
		L.RegVar("collectNormalEffect", get_collectNormalEffect, set_collectNormalEffect);
		L.RegVar("collectDirEffect", get_collectDirEffect, set_collectDirEffect);
		L.RegVar("failEffect", get_failEffect, set_failEffect);
		L.RegVar("winEffect", get_winEffect, set_winEffect);
		L.RegVar("spritePath", get_spritePath, set_spritePath);
		L.RegVar("otherData", get_otherData, set_otherData);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateQWorldThingEntityData(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				QWorldThingEntityData o = new QWorldThingEntityData();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: QWorldThingEntityData.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsNpc(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((QWorldThingEntityData)ToLua.CheckObject<QWorldThingEntityData>(L, 1)).IsNpc();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsSphereArea(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((QWorldThingEntityData)ToLua.CheckObject<QWorldThingEntityData>(L, 1)).IsSphereArea();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsSpriteRender(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((QWorldThingEntityData)ToLua.CheckObject<QWorldThingEntityData>(L, 1)).IsSpriteRender();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_script_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string script_name = ((QWorldThingEntityData)obj).script_name;
			LuaDLL.lua_pushstring(L, script_name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index script_name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spawn_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QworldEntitySpawnType spawn_type = ((QWorldThingEntityData)obj).spawn_type;
			ToLua.Push(L, spawn_type);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spawn_type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spawn_task_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int spawn_task_id = ((QWorldThingEntityData)obj).spawn_task_id;
			LuaDLL.lua_pushinteger(L, spawn_task_id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spawn_task_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultAnim(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string defaultAnim = ((QWorldThingEntityData)obj).defaultAnim;
			LuaDLL.lua_pushstring(L, defaultAnim);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultAnim on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_defaultInteractive(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool defaultInteractive = ((QWorldThingEntityData)obj).defaultInteractive;
			LuaDLL.lua_pushboolean(L, defaultInteractive);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultInteractive on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_customIdle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWLocomotionCustomIdleState customIdle = ((QWorldThingEntityData)obj).customIdle;
			ToLua.Push(L, customIdle);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index customIdle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_configId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int configId = ((QWorldThingEntityData)obj).configId;
			LuaDLL.lua_pushinteger(L, configId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index configId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_teleportId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int teleportId = ((QWorldThingEntityData)obj).teleportId;
			LuaDLL.lua_pushinteger(L, teleportId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index teleportId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_distance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float distance = ((QWorldThingEntityData)obj).distance;
			LuaDLL.lua_pushnumber(L, distance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index distance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_camera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string camera = ((QWorldThingEntityData)obj).camera;
			LuaDLL.lua_pushstring(L, camera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index camera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lookAtType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QworldEntityLookAtType lookAtType = ((QWorldThingEntityData)obj).lookAtType;
			ToLua.Push(L, lookAtType);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lookAtType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lookAtEntityId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int lookAtEntityId = ((QWorldThingEntityData)obj).lookAtEntityId;
			LuaDLL.lua_pushinteger(L, lookAtEntityId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lookAtEntityId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_lookAtPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 lookAtPoint = ((QWorldThingEntityData)obj).lookAtPoint;
			ToLua.Push(L, lookAtPoint);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lookAtPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_enterRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int enterRadius = ((QWorldThingEntityData)obj).enterRadius;
			LuaDLL.lua_pushinteger(L, enterRadius);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enterRadius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_exitRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int exitRadius = ((QWorldThingEntityData)obj).exitRadius;
			LuaDLL.lua_pushinteger(L, exitRadius);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index exitRadius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isAreaNode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isAreaNode = ((QWorldThingEntityData)obj).isAreaNode;
			LuaDLL.lua_pushboolean(L, isAreaNode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isAreaNode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_index(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int index = ((QWorldThingEntityData)obj).index;
			LuaDLL.lua_pushinteger(L, index);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index index on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isLast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isLast = ((QWorldThingEntityData)obj).isLast;
			LuaDLL.lua_pushboolean(L, isLast);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string startEffect = ((QWorldThingEntityData)obj).startEffect;
			LuaDLL.lua_pushstring(L, startEffect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_startLoopEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string startLoopEffect = ((QWorldThingEntityData)obj).startLoopEffect;
			LuaDLL.lua_pushstring(L, startLoopEffect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startLoopEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_collectStartEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string collectStartEffect = ((QWorldThingEntityData)obj).collectStartEffect;
			LuaDLL.lua_pushstring(L, collectStartEffect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index collectStartEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_collectNormalEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string collectNormalEffect = ((QWorldThingEntityData)obj).collectNormalEffect;
			LuaDLL.lua_pushstring(L, collectNormalEffect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index collectNormalEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_collectDirEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string collectDirEffect = ((QWorldThingEntityData)obj).collectDirEffect;
			LuaDLL.lua_pushstring(L, collectDirEffect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index collectDirEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_failEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string failEffect = ((QWorldThingEntityData)obj).failEffect;
			LuaDLL.lua_pushstring(L, failEffect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index failEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_winEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string winEffect = ((QWorldThingEntityData)obj).winEffect;
			LuaDLL.lua_pushstring(L, winEffect);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index winEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spritePath(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string spritePath = ((QWorldThingEntityData)obj).spritePath;
			LuaDLL.lua_pushstring(L, spritePath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spritePath on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_otherData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			object otherData = ((QWorldThingEntityData)obj).otherData;
			ToLua.Push(L, otherData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index otherData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_script_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			string script_name = ToLua.CheckString(L, 2);
			obj2.script_name = script_name;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index script_name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spawn_type(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			QworldEntitySpawnType spawn_type = (QworldEntitySpawnType)ToLua.CheckObject(L, 2, typeof(QworldEntitySpawnType));
			obj2.spawn_type = spawn_type;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spawn_type on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spawn_task_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			int spawn_task_id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.spawn_task_id = spawn_task_id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spawn_task_id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_defaultAnim(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			string defaultAnim = ToLua.CheckString(L, 2);
			obj2.defaultAnim = defaultAnim;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultAnim on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_defaultInteractive(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			bool defaultInteractive = LuaDLL.luaL_checkboolean(L, 2);
			obj2.defaultInteractive = defaultInteractive;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index defaultInteractive on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_customIdle(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			QWLocomotionCustomIdleState customIdle = (QWLocomotionCustomIdleState)ToLua.CheckObject<QWLocomotionCustomIdleState>(L, 2);
			obj2.customIdle = customIdle;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index customIdle on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_configId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			int configId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.configId = configId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index configId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_teleportId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			int teleportId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.teleportId = teleportId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index teleportId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_distance(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			float distance = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.distance = distance;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index distance on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_camera(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			string camera = ToLua.CheckString(L, 2);
			obj2.camera = camera;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index camera on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lookAtType(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			QworldEntityLookAtType lookAtType = (QworldEntityLookAtType)ToLua.CheckObject(L, 2, typeof(QworldEntityLookAtType));
			obj2.lookAtType = lookAtType;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lookAtType on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lookAtEntityId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			int lookAtEntityId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.lookAtEntityId = lookAtEntityId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lookAtEntityId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_lookAtPoint(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			Vector3 lookAtPoint = ToLua.ToVector3(L, 2);
			obj2.lookAtPoint = lookAtPoint;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index lookAtPoint on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_enterRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			int enterRadius = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.enterRadius = enterRadius;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index enterRadius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_exitRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			int exitRadius = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.exitRadius = exitRadius;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index exitRadius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isAreaNode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			bool isAreaNode = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isAreaNode = isAreaNode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isAreaNode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_index(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			int index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.index = index;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index index on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isLast(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			bool isLast = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isLast = isLast;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLast on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			string startEffect = ToLua.CheckString(L, 2);
			obj2.startEffect = startEffect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_startLoopEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			string startLoopEffect = ToLua.CheckString(L, 2);
			obj2.startLoopEffect = startLoopEffect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index startLoopEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_collectStartEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			string collectStartEffect = ToLua.CheckString(L, 2);
			obj2.collectStartEffect = collectStartEffect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index collectStartEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_collectNormalEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			string collectNormalEffect = ToLua.CheckString(L, 2);
			obj2.collectNormalEffect = collectNormalEffect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index collectNormalEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_collectDirEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			string collectDirEffect = ToLua.CheckString(L, 2);
			obj2.collectDirEffect = collectDirEffect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index collectDirEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_failEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			string failEffect = ToLua.CheckString(L, 2);
			obj2.failEffect = failEffect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index failEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_winEffect(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			string winEffect = ToLua.CheckString(L, 2);
			obj2.winEffect = winEffect;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index winEffect on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spritePath(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			string spritePath = ToLua.CheckString(L, 2);
			obj2.spritePath = spritePath;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spritePath on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_otherData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldThingEntityData obj2 = (QWorldThingEntityData)obj;
			object otherData = ToLua.ToVarObject(L, 2);
			obj2.otherData = otherData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index otherData on a nil value");
		}
	}
}
