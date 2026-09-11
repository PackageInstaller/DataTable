using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class GuildActivityManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(GuildActivityManager), typeof(MonoBehaviour));
		L.RegFunction("StartGame", StartGame);
		L.RegFunction("LoadLevel", LoadLevel);
		L.RegFunction("UpdateNodeData", UpdateNodeData);
		L.RegFunction("SetOnWarField", SetOnWarField);
		L.RegFunction("IsOnWarField", IsOnWarField);
		L.RegFunction("SetZoom", SetZoom);
		L.RegFunction("ClickNode", ClickNode);
		L.RegFunction("ClickBonusNode", ClickBonusNode);
		L.RegFunction("ClickBg", ClickBg);
		L.RegFunction("AddTimer", AddTimer);
		L.RegFunction("RemoveTimer", RemoveTimer);
		L.RegFunction("GetServerTime", GetServerTime);
		L.RegFunction("IsNodeCanReach", IsNodeCanReach);
		L.RegFunction("SetOnNodeClick", SetOnNodeClick);
		L.RegFunction("SetOnBonusClick", SetOnBonusClick);
		L.RegFunction("SetOnZoomByFingerHandler", SetOnZoomByFingerHandler);
		L.RegFunction("SetOnBgClick", SetOnBgClick);
		L.RegFunction("SetOnLevelLoaded", SetOnLevelLoaded);
		L.RegFunction("GetInstance", GetInstance);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("luaData", get_luaData, set_luaData);
		L.RegVar("dataOfNode", get_dataOfNode, set_dataOfNode);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartGame(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			int enterNodeId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.StartGame(enterNodeId);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadLevel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			int level = (int)LuaDLL.luaL_checknumber(L, 2);
			GuildActivityWarFieldLevel obj2 = obj.LoadLevel(level);
			ToLua.Push(L, obj2);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UpdateNodeData(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				GuildActivityManager obj2 = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
				GuildActivityNodeDataList dataList2 = (GuildActivityNodeDataList)ToLua.CheckObject<GuildActivityNodeDataList>(L, 2);
				obj2.UpdateNodeData(dataList2);
				return 0;
			}
			case 3:
			{
				GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
				GuildActivityNodeDataList dataList = (GuildActivityNodeDataList)ToLua.CheckObject<GuildActivityNodeDataList>(L, 2);
				bool isFirst = LuaDLL.luaL_checkboolean(L, 3);
				obj.UpdateNodeData(dataList, isFirst);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: GuildActivityManager.UpdateNodeData");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetOnWarField(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			bool onWarField = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetOnWarField(onWarField);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsOnWarField(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1)).IsOnWarField();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetZoom(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			float zoom = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetZoom(zoom);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClickNode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			GuildActivityWarFieldNode node = (GuildActivityWarFieldNode)ToLua.CheckObject<GuildActivityWarFieldNode>(L, 2);
			obj.ClickNode(node);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClickBonusNode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			GuildActivityWarFieldNode node = (GuildActivityWarFieldNode)ToLua.CheckObject<GuildActivityWarFieldNode>(L, 2);
			obj.ClickBonusNode(node);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClickBg(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1)).ClickBg();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddTimer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			Action action = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.AddTimer(action);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveTimer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			Action action = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.RemoveTimer(action);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetServerTime(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int serverTime = ((GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1)).GetServerTime();
			LuaDLL.lua_pushinteger(L, serverTime);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsNodeCanReach(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			int nodeId = (int)LuaDLL.luaL_checknumber(L, 2);
			bool value = obj.IsNodeCanReach(nodeId);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetOnNodeClick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			Action<int> onNodeClick = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 2);
			obj.SetOnNodeClick(onNodeClick);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetOnBonusClick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			Action<int> onBonusClick = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 2);
			obj.SetOnBonusClick(onBonusClick);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetOnZoomByFingerHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			Action<float> onZoomByFingerHandler = (Action<float>)ToLua.CheckDelegate<Action<float>>(L, 2);
			obj.SetOnZoomByFingerHandler(onZoomByFingerHandler);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetOnBgClick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			Action onBgClick = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.SetOnBgClick(onBgClick);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetOnLevelLoaded(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GuildActivityManager obj = (GuildActivityManager)ToLua.CheckObject<GuildActivityManager>(L, 1);
			Action<int> onLevelLoaded = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 2);
			obj.SetOnLevelLoaded(onLevelLoaded);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetInstance(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			GuildActivityManager instance = GuildActivityManager.GetInstance();
			ToLua.Push(L, instance);
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

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_luaData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivitySelfData luaData = ((GuildActivityManager)obj).luaData;
			ToLua.PushObject(L, luaData);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index luaData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_dataOfNode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Dictionary<int, GuildActivityNodeData> dataOfNode = ((GuildActivityManager)obj).dataOfNode;
			ToLua.PushSealed(L, dataOfNode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dataOfNode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_luaData(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivityManager obj2 = (GuildActivityManager)obj;
			GuildActivitySelfData luaData = (GuildActivitySelfData)ToLua.CheckObject<GuildActivitySelfData>(L, 2);
			obj2.luaData = luaData;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index luaData on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_dataOfNode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GuildActivityManager obj2 = (GuildActivityManager)obj;
			Dictionary<int, GuildActivityNodeData> dataOfNode = (Dictionary<int, GuildActivityNodeData>)ToLua.CheckObject(L, 2, typeof(Dictionary<int, GuildActivityNodeData>));
			obj2.dataOfNode = dataOfNode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index dataOfNode on a nil value");
		}
	}
}
