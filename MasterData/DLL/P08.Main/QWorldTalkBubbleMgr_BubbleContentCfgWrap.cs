using System;
using LuaInterface;

public class QWorldTalkBubbleMgr_BubbleContentCfgWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWorldTalkBubbleMgr.BubbleContentCfg), null);
		L.RegFunction("New", _CreateQWorldTalkBubbleMgr_BubbleContentCfg);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("charaIdx", get_charaIdx, set_charaIdx);
		L.RegVar("content", get_content, set_content);
		L.RegVar("duration", get_duration, set_duration);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateQWorldTalkBubbleMgr_BubbleContentCfg(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 4:
			{
				int gourpID = (int)LuaDLL.luaL_checknumber(L, 1);
				int charaIdx = (int)LuaDLL.luaL_checknumber(L, 2);
				string content = ToLua.CheckString(L, 3);
				float duration = (float)LuaDLL.luaL_checknumber(L, 4);
				QWorldTalkBubbleMgr.BubbleContentCfg v = new QWorldTalkBubbleMgr.BubbleContentCfg(gourpID, charaIdx, content, duration);
				ToLua.PushValue(L, v);
				return 1;
			}
			case 0:
				ToLua.PushValue(L, default(QWorldTalkBubbleMgr.BubbleContentCfg));
				return 1;
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: QWorldTalkBubbleMgr.BubbleContentCfg.New");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_charaIdx(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int charaIdx = ((QWorldTalkBubbleMgr.BubbleContentCfg)obj).charaIdx;
			LuaDLL.lua_pushinteger(L, charaIdx);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index charaIdx on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_content(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string content = ((QWorldTalkBubbleMgr.BubbleContentCfg)obj).content;
			LuaDLL.lua_pushstring(L, content);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index content on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float duration = ((QWorldTalkBubbleMgr.BubbleContentCfg)obj).duration;
			LuaDLL.lua_pushnumber(L, duration);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index duration on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_charaIdx(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldTalkBubbleMgr.BubbleContentCfg bubbleContentCfg = (QWorldTalkBubbleMgr.BubbleContentCfg)obj;
			int charaIdx = (int)LuaDLL.luaL_checknumber(L, 2);
			bubbleContentCfg.charaIdx = charaIdx;
			ToLua.SetBack(L, 1, bubbleContentCfg);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index charaIdx on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_content(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldTalkBubbleMgr.BubbleContentCfg bubbleContentCfg = (QWorldTalkBubbleMgr.BubbleContentCfg)obj;
			string content = ToLua.CheckString(L, 2);
			bubbleContentCfg.content = content;
			ToLua.SetBack(L, 1, bubbleContentCfg);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index content on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_duration(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldTalkBubbleMgr.BubbleContentCfg bubbleContentCfg = (QWorldTalkBubbleMgr.BubbleContentCfg)obj;
			float duration = (float)LuaDLL.luaL_checknumber(L, 2);
			bubbleContentCfg.duration = duration;
			ToLua.SetBack(L, 1, bubbleContentCfg);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index duration on a nil value");
		}
	}
}
