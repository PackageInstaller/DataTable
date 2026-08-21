using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class QWorldEntityDataWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWorldEntityData), typeof(object));
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("group_index", get_group_index, set_group_index);
		L.RegVar("id", get_id, set_id);
		L.RegVar("editor_prefab_name", get_editor_prefab_name, set_editor_prefab_name);
		L.RegVar("editor_prefab", get_editor_prefab, set_editor_prefab);
		L.RegVar("position", get_position, set_position);
		L.RegVar("rotation", get_rotation, set_rotation);
		L.RegVar("localScale", get_localScale, set_localScale);
		L.RegVar("entity_child_list", get_entity_child_list, set_entity_child_list);
		L.RegVar("size", get_size, set_size);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_group_index(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int group_index = ((QWorldEntityData)obj).group_index;
			LuaDLL.lua_pushinteger(L, group_index);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index group_index on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int id = ((QWorldEntityData)obj).id;
			LuaDLL.lua_pushinteger(L, id);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_editor_prefab_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string editor_prefab_name = ((QWorldEntityData)obj).editor_prefab_name;
			LuaDLL.lua_pushstring(L, editor_prefab_name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index editor_prefab_name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_editor_prefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string editor_prefab = ((QWorldEntityData)obj).editor_prefab;
			LuaDLL.lua_pushstring(L, editor_prefab);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index editor_prefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 position = ((QWorldEntityData)obj).position;
			ToLua.Push(L, position);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_rotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Quaternion rotation = ((QWorldEntityData)obj).rotation;
			ToLua.Push(L, rotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_localScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 localScale = ((QWorldEntityData)obj).localScale;
			ToLua.Push(L, localScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_entity_child_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			List<int> entity_child_list = ((QWorldEntityData)obj).entity_child_list;
			ToLua.PushSealed(L, entity_child_list);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index entity_child_list on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_size(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 size = ((QWorldEntityData)obj).size;
			ToLua.Push(L, size);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index size on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_group_index(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldEntityData obj2 = (QWorldEntityData)obj;
			int group_index = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.group_index = group_index;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index group_index on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_id(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldEntityData obj2 = (QWorldEntityData)obj;
			int id = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.id = id;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index id on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_editor_prefab_name(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldEntityData obj2 = (QWorldEntityData)obj;
			string editor_prefab_name = ToLua.CheckString(L, 2);
			obj2.editor_prefab_name = editor_prefab_name;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index editor_prefab_name on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_editor_prefab(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldEntityData obj2 = (QWorldEntityData)obj;
			string editor_prefab = ToLua.CheckString(L, 2);
			obj2.editor_prefab = editor_prefab;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index editor_prefab on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_position(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldEntityData obj2 = (QWorldEntityData)obj;
			Vector3 position = ToLua.ToVector3(L, 2);
			obj2.position = position;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index position on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_rotation(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldEntityData obj2 = (QWorldEntityData)obj;
			Quaternion rotation = ToLua.ToQuaternion(L, 2);
			obj2.rotation = rotation;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index rotation on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_localScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldEntityData obj2 = (QWorldEntityData)obj;
			Vector3 localScale = ToLua.ToVector3(L, 2);
			obj2.localScale = localScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index localScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_entity_child_list(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldEntityData obj2 = (QWorldEntityData)obj;
			List<int> entity_child_list = (List<int>)ToLua.CheckObject(L, 2, typeof(List<int>));
			obj2.entity_child_list = entity_child_list;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index entity_child_list on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_size(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldEntityData obj2 = (QWorldEntityData)obj;
			Vector3 size = ToLua.ToVector3(L, 2);
			obj2.size = size;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index size on a nil value");
		}
	}
}
