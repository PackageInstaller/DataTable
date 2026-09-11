using System;
using LuaInterface;
using UnityEngine;

public class DrawGeometryWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(DrawGeometry), typeof(MonoBehaviour));
		L.RegFunction("AddGeometry", AddGeometry);
		L.RegFunction("AddCircleGeometry", AddCircleGeometry);
		L.RegFunction("RemoveGeometry", RemoveGeometry);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddGeometry(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 5:
			{
				DrawGeometry obj2 = (DrawGeometry)ToLua.CheckObject<DrawGeometry>(L, 1);
				GeometryType type2 = (GeometryType)ToLua.CheckObject(L, 2, typeof(GeometryType));
				Vector3 transformPosition2 = ToLua.ToVector3(L, 3);
				Vector3 argVector2 = ToLua.ToVector3(L, 4);
				Color color2 = ToLua.ToColor(L, 5);
				obj2.AddGeometry(type2, transformPosition2, argVector2, color2);
				return 0;
			}
			case 6:
			{
				DrawGeometry obj = (DrawGeometry)ToLua.CheckObject<DrawGeometry>(L, 1);
				GeometryType type = (GeometryType)ToLua.CheckObject(L, 2, typeof(GeometryType));
				Vector3 transformPosition = ToLua.ToVector3(L, 3);
				Vector3 argVector = ToLua.ToVector3(L, 4);
				Color color = ToLua.ToColor(L, 5);
				bool isSelect = LuaDLL.luaL_checkboolean(L, 6);
				obj.AddGeometry(type, transformPosition, argVector, color, isSelect);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DrawGeometry.AddGeometry");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddCircleGeometry(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 5:
			{
				DrawGeometry obj2 = (DrawGeometry)ToLua.CheckObject<DrawGeometry>(L, 1);
				GeometryType type2 = (GeometryType)ToLua.CheckObject(L, 2, typeof(GeometryType));
				Vector3 transformPosition2 = ToLua.ToVector3(L, 3);
				float radius2 = (float)LuaDLL.luaL_checknumber(L, 4);
				Color color2 = ToLua.ToColor(L, 5);
				obj2.AddCircleGeometry(type2, transformPosition2, radius2, color2);
				return 0;
			}
			case 6:
			{
				DrawGeometry obj = (DrawGeometry)ToLua.CheckObject<DrawGeometry>(L, 1);
				GeometryType type = (GeometryType)ToLua.CheckObject(L, 2, typeof(GeometryType));
				Vector3 transformPosition = ToLua.ToVector3(L, 3);
				float radius = (float)LuaDLL.luaL_checknumber(L, 4);
				Color color = ToLua.ToColor(L, 5);
				bool isSelect = LuaDLL.luaL_checkboolean(L, 6);
				obj.AddCircleGeometry(type, transformPosition, radius, color, isSelect);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DrawGeometry.AddCircleGeometry");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveGeometry(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
				((DrawGeometry)ToLua.CheckObject<DrawGeometry>(L, 1)).RemoveGeometry();
				return 0;
			case 2:
			{
				DrawGeometry obj = (DrawGeometry)ToLua.CheckObject<DrawGeometry>(L, 1);
				bool isSelect = LuaDLL.luaL_checkboolean(L, 2);
				obj.RemoveGeometry(isSelect);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: DrawGeometry.RemoveGeometry");
			}
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
}
