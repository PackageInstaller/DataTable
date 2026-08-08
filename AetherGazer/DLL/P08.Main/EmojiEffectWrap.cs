using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;
using UnityEngine.UI;

public class EmojiEffectWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(EmojiEffect), typeof(BaseMeshEffect));
		L.RegFunction("ModifyMesh", ModifyMesh);
		L.RegFunction("SetEmojiByEmojiRawImage", SetEmojiByEmojiRawImage);
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
			if (num == 2 && TypeChecker.CheckTypes<Mesh>(L, 2))
			{
				EmojiEffect obj = (EmojiEffect)ToLua.CheckObject<EmojiEffect>(L, 1);
				Mesh mesh = (Mesh)ToLua.ToObject(L, 2);
				obj.ModifyMesh(mesh);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<VertexHelper>(L, 2))
			{
				EmojiEffect obj2 = (EmojiEffect)ToLua.CheckObject<EmojiEffect>(L, 1);
				VertexHelper vh = (VertexHelper)ToLua.ToObject(L, 2);
				obj2.ModifyMesh(vh);
				return 0;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: EmojiEffect.ModifyMesh");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetEmojiByEmojiRawImage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			EmojiEffect obj = (EmojiEffect)ToLua.CheckObject<EmojiEffect>(L, 1);
			List<EmojiItem> emojiByEmojiRawImage = (List<EmojiItem>)ToLua.CheckObject(L, 2, typeof(List<EmojiItem>));
			List<Image> o = obj.SetEmojiByEmojiRawImage(emojiByEmojiRawImage);
			ToLua.PushSealed(L, o);
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
}
