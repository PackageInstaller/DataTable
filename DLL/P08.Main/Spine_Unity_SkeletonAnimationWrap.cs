using System;
using LuaInterface;
using Spine;
using Spine.Unity;
using UnityEngine;

public class Spine_Unity_SkeletonAnimationWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SkeletonAnimation), typeof(SkeletonRenderer));
		L.RegFunction("AddToGameObject", AddToGameObject);
		L.RegFunction("NewSkeletonAnimationGameObject", NewSkeletonAnimationGameObject);
		L.RegFunction("ClearState", ClearState);
		L.RegFunction("Initialize", Initialize);
		L.RegFunction("Update", Update);
		L.RegFunction("LateUpdate", LateUpdate);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("state", get_state, set_state);
		L.RegVar("loop", get_loop, set_loop);
		L.RegVar("timeScale", get_timeScale, set_timeScale);
		L.RegVar("AnimationState", get_AnimationState, null);
		L.RegVar("AnimationName", get_AnimationName, set_AnimationName);
		L.RegVar("BeforeApply", get_BeforeApply, set_BeforeApply);
		L.RegVar("UpdateLocal", get_UpdateLocal, set_UpdateLocal);
		L.RegVar("UpdateWorld", get_UpdateWorld, set_UpdateWorld);
		L.RegVar("UpdateComplete", get_UpdateComplete, set_UpdateComplete);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddToGameObject(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				GameObject gameObject2 = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				SkeletonDataAsset skeletonDataAsset2 = (SkeletonDataAsset)ToLua.CheckObject<SkeletonDataAsset>(L, 2);
				SkeletonAnimation obj2 = SkeletonAnimation.AddToGameObject(gameObject2, skeletonDataAsset2);
				ToLua.Push(L, obj2);
				return 1;
			}
			case 3:
			{
				GameObject gameObject = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
				SkeletonDataAsset skeletonDataAsset = (SkeletonDataAsset)ToLua.CheckObject<SkeletonDataAsset>(L, 2);
				bool quiet = LuaDLL.luaL_checkboolean(L, 3);
				SkeletonAnimation obj = SkeletonAnimation.AddToGameObject(gameObject, skeletonDataAsset, quiet);
				ToLua.Push(L, obj);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Spine.Unity.SkeletonAnimation.AddToGameObject");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int NewSkeletonAnimationGameObject(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				SkeletonAnimation obj2 = SkeletonAnimation.NewSkeletonAnimationGameObject((SkeletonDataAsset)ToLua.CheckObject<SkeletonDataAsset>(L, 1));
				ToLua.Push(L, obj2);
				return 1;
			}
			case 2:
			{
				SkeletonDataAsset skeletonDataAsset = (SkeletonDataAsset)ToLua.CheckObject<SkeletonDataAsset>(L, 1);
				bool quiet = LuaDLL.luaL_checkboolean(L, 2);
				SkeletonAnimation obj = SkeletonAnimation.NewSkeletonAnimationGameObject(skeletonDataAsset, quiet);
				ToLua.Push(L, obj);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Spine.Unity.SkeletonAnimation.NewSkeletonAnimationGameObject");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SkeletonAnimation)ToLua.CheckObject<SkeletonAnimation>(L, 1)).ClearState();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Initialize(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				SkeletonAnimation obj2 = (SkeletonAnimation)ToLua.CheckObject<SkeletonAnimation>(L, 1);
				bool overwrite2 = LuaDLL.luaL_checkboolean(L, 2);
				obj2.Initialize(overwrite2);
				return 0;
			}
			case 3:
			{
				SkeletonAnimation obj = (SkeletonAnimation)ToLua.CheckObject<SkeletonAnimation>(L, 1);
				bool overwrite = LuaDLL.luaL_checkboolean(L, 2);
				bool quiet = LuaDLL.luaL_checkboolean(L, 3);
				obj.Initialize(overwrite, quiet);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: Spine.Unity.SkeletonAnimation.Initialize");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Update(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			SkeletonAnimation obj = (SkeletonAnimation)ToLua.CheckObject<SkeletonAnimation>(L, 1);
			float deltaTime = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.Update(deltaTime);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LateUpdate(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((SkeletonAnimation)ToLua.CheckObject<SkeletonAnimation>(L, 1)).LateUpdate();
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
	private static int get_state(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Spine.AnimationState state = ((SkeletonAnimation)obj).state;
			ToLua.PushObject(L, state);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index state on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool loop = ((SkeletonAnimation)obj).loop;
			LuaDLL.lua_pushboolean(L, loop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_timeScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float timeScale = ((SkeletonAnimation)obj).timeScale;
			LuaDLL.lua_pushnumber(L, timeScale);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AnimationState(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Spine.AnimationState animationState = ((SkeletonAnimation)obj).AnimationState;
			ToLua.PushObject(L, animationState);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AnimationState on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_AnimationName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string animationName = ((SkeletonAnimation)obj).AnimationName;
			LuaDLL.lua_pushstring(L, animationName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AnimationName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BeforeApply(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(UpdateBonesDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UpdateLocal(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(UpdateBonesDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UpdateWorld(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(UpdateBonesDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_UpdateComplete(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(UpdateBonesDelegate)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_state(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonAnimation obj2 = (SkeletonAnimation)obj;
			Spine.AnimationState state = (Spine.AnimationState)ToLua.CheckObject<Spine.AnimationState>(L, 2);
			obj2.state = state;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index state on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonAnimation obj2 = (SkeletonAnimation)obj;
			bool loop = LuaDLL.luaL_checkboolean(L, 2);
			obj2.loop = loop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_timeScale(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonAnimation obj2 = (SkeletonAnimation)obj;
			float timeScale = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.timeScale = timeScale;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index timeScale on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_AnimationName(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SkeletonAnimation obj2 = (SkeletonAnimation)obj;
			string animationName = ToLua.CheckString(L, 2);
			obj2.AnimationName = animationName;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index AnimationName on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_BeforeApply(IntPtr L)
	{
		try
		{
			SkeletonAnimation skeletonAnimation = (SkeletonAnimation)ToLua.CheckObject(L, 1, typeof(SkeletonAnimation));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					UpdateBonesDelegate value = (UpdateBonesDelegate)eventObject.func;
					skeletonAnimation.BeforeApply += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					UpdateBonesDelegate value2 = (UpdateBonesDelegate)eventObject.func;
					skeletonAnimation.BeforeApply -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonAnimation.BeforeApply' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonAnimation'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_UpdateLocal(IntPtr L)
	{
		try
		{
			SkeletonAnimation skeletonAnimation = (SkeletonAnimation)ToLua.CheckObject(L, 1, typeof(SkeletonAnimation));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					UpdateBonesDelegate value = (UpdateBonesDelegate)eventObject.func;
					skeletonAnimation.UpdateLocal += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					UpdateBonesDelegate value2 = (UpdateBonesDelegate)eventObject.func;
					skeletonAnimation.UpdateLocal -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonAnimation.UpdateLocal' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonAnimation'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_UpdateWorld(IntPtr L)
	{
		try
		{
			SkeletonAnimation skeletonAnimation = (SkeletonAnimation)ToLua.CheckObject(L, 1, typeof(SkeletonAnimation));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					UpdateBonesDelegate value = (UpdateBonesDelegate)eventObject.func;
					skeletonAnimation.UpdateWorld += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					UpdateBonesDelegate value2 = (UpdateBonesDelegate)eventObject.func;
					skeletonAnimation.UpdateWorld -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonAnimation.UpdateWorld' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonAnimation'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_UpdateComplete(IntPtr L)
	{
		try
		{
			SkeletonAnimation skeletonAnimation = (SkeletonAnimation)ToLua.CheckObject(L, 1, typeof(SkeletonAnimation));
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					UpdateBonesDelegate value = (UpdateBonesDelegate)eventObject.func;
					skeletonAnimation.UpdateComplete += value;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					UpdateBonesDelegate value2 = (UpdateBonesDelegate)eventObject.func;
					skeletonAnimation.UpdateComplete -= value2;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'Spine.Unity.SkeletonAnimation.UpdateComplete' can only appear on the left hand side of += or -= when used outside of the type 'Spine.Unity.SkeletonAnimation'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
