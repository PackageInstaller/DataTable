using System;
using LuaInterface;

public class WaitRenderFrameUtilWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(WaitRenderFrameUtil), typeof(object));
		L.RegFunction("StartScreenShot", StartScreenShot);
		L.RegFunction("New", _CreateWaitRenderFrameUtil);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("_waitFrame", get__waitFrame, set__waitFrame);
		L.RegVar("_inst", get__inst, set__inst);
		L.RegVar("inst", get_inst, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateWaitRenderFrameUtil(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				WaitRenderFrameUtil o = new WaitRenderFrameUtil();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: WaitRenderFrameUtil.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartScreenShot(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			WaitRenderFrameUtil.StartScreenShot((Action)ToLua.CheckDelegate<Action>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__waitFrame(IntPtr L)
	{
		try
		{
			ToLua.Push(L, WaitRenderFrameUtil._waitFrame);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__inst(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, WaitRenderFrameUtil._inst);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inst(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, WaitRenderFrameUtil.inst);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__waitFrame(IntPtr L)
	{
		try
		{
			WaitRenderFrameUtil._waitFrame = (WaitRenderFrame)ToLua.CheckObject<WaitRenderFrame>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__inst(IntPtr L)
	{
		try
		{
			WaitRenderFrameUtil._inst = (WaitRenderFrameUtil)ToLua.CheckObject<WaitRenderFrameUtil>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
