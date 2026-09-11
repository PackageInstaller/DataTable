using System;
using LuaInterface;
using UnityEngine;

public class UnityEngine_MeshRendererWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(MeshRenderer), typeof(Renderer));
		L.RegFunction("New", _CreateUnityEngine_MeshRenderer);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("additionalVertexStreams", get_additionalVertexStreams, set_additionalVertexStreams);
		L.RegVar("subMeshStartIndex", get_subMeshStartIndex, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_MeshRenderer(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				MeshRenderer obj = new MeshRenderer();
				ToLua.Push(L, obj);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.MeshRenderer.New");
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
	private static int get_additionalVertexStreams(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh additionalVertexStreams = ((MeshRenderer)obj).additionalVertexStreams;
			ToLua.PushSealed(L, additionalVertexStreams);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index additionalVertexStreams on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_subMeshStartIndex(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int subMeshStartIndex = ((MeshRenderer)obj).subMeshStartIndex;
			LuaDLL.lua_pushinteger(L, subMeshStartIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index subMeshStartIndex on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_additionalVertexStreams(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MeshRenderer obj2 = (MeshRenderer)obj;
			Mesh additionalVertexStreams = (Mesh)ToLua.CheckObject(L, 2, typeof(Mesh));
			obj2.additionalVertexStreams = additionalVertexStreams;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index additionalVertexStreams on a nil value");
		}
	}
}
