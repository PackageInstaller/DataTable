using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class PaperCutUIImageWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PaperCutUIImage), typeof(Image));
		L.RegFunction("SetPaperCutMesh", SetPaperCutMesh);
		L.RegFunction("SetPaperCutTexture", SetPaperCutTexture);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("texture", get_texture, set_texture);
		L.RegVar("mesh", get_mesh, set_mesh);
		L.RegVar("mainTexture", get_mainTexture, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPaperCutMesh(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PaperCutUIImage obj = (PaperCutUIImage)ToLua.CheckObject<PaperCutUIImage>(L, 1);
			Mesh paperCutMesh = (Mesh)ToLua.CheckObject(L, 2, typeof(Mesh));
			obj.SetPaperCutMesh(paperCutMesh);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPaperCutTexture(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			PaperCutUIImage obj = (PaperCutUIImage)ToLua.CheckObject<PaperCutUIImage>(L, 1);
			Texture mainTex = (Texture)ToLua.CheckObject<Texture>(L, 2);
			Texture displayAreaTex = (Texture)ToLua.CheckObject<Texture>(L, 3);
			Texture backGroundTex = (Texture)ToLua.CheckObject<Texture>(L, 4);
			obj.SetPaperCutTexture(mainTex, displayAreaTex, backGroundTex);
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
	private static int get_texture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture texture = ((PaperCutUIImage)obj).texture;
			ToLua.Push(L, texture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index texture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mesh(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Mesh mesh = ((PaperCutUIImage)obj).mesh;
			ToLua.PushSealed(L, mesh);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mesh on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_mainTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture mainTexture = ((PaperCutUIImage)obj).mainTexture;
			ToLua.Push(L, mainTexture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mainTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_texture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutUIImage obj2 = (PaperCutUIImage)obj;
			Texture texture = (Texture)ToLua.CheckObject<Texture>(L, 2);
			obj2.texture = texture;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index texture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_mesh(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutUIImage obj2 = (PaperCutUIImage)obj;
			Mesh mesh = (Mesh)ToLua.CheckObject(L, 2, typeof(Mesh));
			obj2.mesh = mesh;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index mesh on a nil value");
		}
	}
}
