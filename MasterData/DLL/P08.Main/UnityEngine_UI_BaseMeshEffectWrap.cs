using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class UnityEngine_UI_BaseMeshEffectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(BaseMeshEffect), typeof(UIBehaviour));
		L.RegFunction("ModifyMesh", ModifyMesh);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ModifyMesh(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 2 && TypeChecker.CheckTypes<VertexHelper>(L, 2))
			{
				BaseMeshEffect obj = (BaseMeshEffect)ToLua.CheckObject<BaseMeshEffect>(L, 1);
				VertexHelper vh = (VertexHelper)ToLua.ToObject(L, 2);
				obj.ModifyMesh(vh);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<Mesh>(L, 2))
			{
				BaseMeshEffect obj2 = (BaseMeshEffect)ToLua.CheckObject<BaseMeshEffect>(L, 1);
				Mesh mesh = (Mesh)ToLua.ToObject(L, 2);
				obj2.ModifyMesh(mesh);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.UI.BaseMeshEffect.ModifyMesh");
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
