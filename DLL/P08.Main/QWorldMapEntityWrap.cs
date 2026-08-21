using System;
using System.Collections.Generic;
using LuaInterface;
using UnityEngine;

public class QWorldMapEntityWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWorldMapEntity), typeof(MonoBehaviour));
		L.RegFunction("AddBubbleTag", AddBubbleTag);
		L.RegFunction("RemoveBubbleTag", RemoveBubbleTag);
		L.RegFunction("SetCheckBubbbleRange", SetCheckBubbbleRange);
		L.RegFunction("InvokeBubbleClick", InvokeBubbleClick);
		L.RegFunction("SetBubbbleLookAt", SetBubbbleLookAt);
		L.RegFunction("GetCheckBubbleRange", GetCheckBubbleRange);
		L.RegFunction("InitEntityData", InitEntityData);
		L.RegFunction("GetPosition", GetPosition);
		L.RegFunction("SetPosition", SetPosition);
		L.RegFunction("GetRotation", GetRotation);
		L.RegFunction("GetForward", GetForward);
		L.RegFunction("GetTransform", GetTransform);
		L.RegFunction("SetHudDisplay", SetHudDisplay);
		L.RegFunction("GetDefaultInteract", GetDefaultInteract);
		L.RegFunction("GetTeleportId", GetTeleportId);
		L.RegFunction("GetEnterRadius", GetEnterRadius);
		L.RegFunction("GetExitRadius", GetExitRadius);
		L.RegFunction("GetMiniGameCamera", GetMiniGameCamera);
		L.RegFunction("IsNpc", IsNpc);
		L.RegFunction("IsPlayer", IsPlayer);
		L.RegFunction("Is", Is);
		L.RegFunction("ChangeCullMode", ChangeCullMode);
		L.RegFunction("GetMiniMapUnit", GetMiniMapUnit);
		L.RegFunction("AddMiniMap", AddMiniMap);
		L.RegFunction("RemoveMiniMap", RemoveMiniMap);
		L.RegFunction("AddComponent", AddComponent);
		L.RegFunction("GetBlackBoard", GetBlackBoard);
		L.RegFunction("SetBuild", SetBuild);
		L.RegFunction("LuaRequestLoad", LuaRequestLoad);
		L.RegFunction("SetName", SetName);
		L.RegFunction("GetName", GetName);
		L.RegFunction("GetEventHud", GetEventHud);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("bubbleBehvaiour", get_bubbleBehvaiour, set_bubbleBehvaiour);
		L.RegVar("uniqueId", get_uniqueId, set_uniqueId);
		L.RegVar("entityId", get_entityId, set_entityId);
		L.RegVar("size", get_size, set_size);
		L.RegVar("cullMode", get_cullMode, set_cullMode);
		L.RegVar("componentDict", get_componentDict, set_componentDict);
		L.RegVar("nightBase", get_nightBase, set_nightBase);
		L.RegVar("exchangeNightBase", get_exchangeNightBase, set_exchangeNightBase);
		L.RegVar("bubbleClick", get_bubbleClick, set_bubbleClick);
		L.RegVar("isShowBubble", get_isShowBubble, set_isShowBubble);
		L.RegVar("isInScreen", get_isInScreen, set_isInScreen);
		L.RegVar("BlackBoard", get_BlackBoard, null);
		L.RegVar("NPCBlackBoard", get_NPCBlackBoard, null);
		L.RegVar("isLoaded", get_isLoaded, null);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddBubbleTag(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				QWorldMapEntity obj2 = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				int tag2 = (int)LuaDLL.luaL_checknumber(L, 2);
				string text2 = ToLua.CheckString(L, 3);
				obj2.AddBubbleTag(tag2, text2);
				return 0;
			}
			case 4:
			{
				QWorldMapEntity obj = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				int tag = (int)LuaDLL.luaL_checknumber(L, 2);
				string text = ToLua.CheckString(L, 3);
				string micon = ToLua.CheckString(L, 4);
				obj.AddBubbleTag(tag, text, micon);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorldMapEntity.AddBubbleTag");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveBubbleTag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMapEntity obj = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			int tag = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.RemoveBubbleTag(tag);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCheckBubbbleRange(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMapEntity obj = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			float checkBubbbleRange = (float)LuaDLL.luaL_checknumber(L, 2);
			obj.SetCheckBubbbleRange(checkBubbbleRange);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InvokeBubbleClick(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).InvokeBubbleClick();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBubbbleLookAt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMapEntity obj = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			bool bubbbleLookAt = LuaDLL.luaL_checkboolean(L, 2);
			obj.SetBubbbleLookAt(bubbbleLookAt);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCheckBubbleRange(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float checkBubbleRange = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetCheckBubbleRange();
			LuaDLL.lua_pushnumber(L, checkBubbleRange);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitEntityData(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMapEntity obj = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			QWorldThingEntityData entityData = (QWorldThingEntityData)ToLua.CheckObject<QWorldThingEntityData>(L, 2);
			obj.InitEntityData(entityData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPosition(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 position = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetPosition();
			ToLua.Push(L, position);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetPosition(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				QWorldMapEntity obj2 = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				Vector3 position = ToLua.ToVector3(L, 2);
				obj2.SetPosition(position);
				return 0;
			}
			case 4:
			{
				QWorldMapEntity obj = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				int x = (int)LuaDLL.luaL_checknumber(L, 2);
				int y = (int)LuaDLL.luaL_checknumber(L, 3);
				int z = (int)LuaDLL.luaL_checknumber(L, 4);
				obj.SetPosition(x, y, z);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWorldMapEntity.SetPosition");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetRotation(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Quaternion rotation = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetRotation();
			ToLua.Push(L, rotation);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetForward(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Vector3 forward = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetForward();
			ToLua.Push(L, forward);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTransform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Transform transform = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetTransform();
			ToLua.Push(L, transform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetHudDisplay(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMapEntity obj = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			int hudDisplay = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.SetHudDisplay(hudDisplay);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetDefaultInteract(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool defaultInteract = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetDefaultInteract();
			LuaDLL.lua_pushboolean(L, defaultInteract);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTeleportId(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int teleportId = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetTeleportId();
			LuaDLL.lua_pushinteger(L, teleportId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEnterRadius(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int enterRadius = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetEnterRadius();
			LuaDLL.lua_pushinteger(L, enterRadius);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetExitRadius(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int exitRadius = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetExitRadius();
			LuaDLL.lua_pushinteger(L, exitRadius);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMiniGameCamera(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string miniGameCamera = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetMiniGameCamera();
			LuaDLL.lua_pushstring(L, miniGameCamera);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsNpc(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).IsNpc();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsPlayer(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).IsPlayer();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Is(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMapEntity obj = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			QWAgentLayer layer = (QWAgentLayer)ToLua.CheckObject(L, 2, typeof(QWAgentLayer));
			bool value = obj.Is(layer);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ChangeCullMode(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMapEntity obj = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			int cullMode = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.ChangeCullMode(cullMode);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetMiniMapUnit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldMiniMapUnit miniMapUnit = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetMiniMapUnit();
			ToLua.PushObject(L, miniMapUnit);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddMiniMap(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			QWorldMiniMapUnit o = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).AddMiniMap();
			ToLua.PushObject(L, o);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int RemoveMiniMap(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).RemoveMiniMap();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AddComponent(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMapEntity obj = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			string component = ToLua.CheckString(L, 2);
			obj.AddComponent(component);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetBlackBoard(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			IQWBlackboard blackBoard = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetBlackBoard();
			ToLua.PushObject(L, blackBoard);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetBuild(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMapEntity obj = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			string build = ToLua.CheckString(L, 2);
			obj.SetBuild(build);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaRequestLoad(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMapEntity obj = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			int loadMode = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.LuaRequestLoad(loadMode);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWorldMapEntity obj = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			string name = ToLua.CheckString(L, 2);
			obj.SetName(name);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string name = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetName();
			LuaDLL.lua_pushstring(L, name);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetEventHud(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int eventHud = ((QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1)).GetEventHud();
			LuaDLL.lua_pushinteger(L, eventHud);
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
	private static int get_bubbleBehvaiour(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWBubbleBehvaiour bubbleBehvaiour = ((QWorldMapEntity)obj).bubbleBehvaiour;
			ToLua.Push(L, bubbleBehvaiour);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bubbleBehvaiour on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_uniqueId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int uniqueId = ((QWorldMapEntity)obj).uniqueId;
			LuaDLL.lua_pushinteger(L, uniqueId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uniqueId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_entityId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int entityId = ((QWorldMapEntity)obj).entityId;
			LuaDLL.lua_pushinteger(L, entityId);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index entityId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_size(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Vector3 size = ((QWorldMapEntity)obj).size;
			ToLua.Push(L, size);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index size on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cullMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			CullMode cullMode = ((QWorldMapEntity)obj).cullMode;
			ToLua.Push(L, cullMode);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cullMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_componentDict(IntPtr L)
	{
		try
		{
			ToLua.PushSealed(L, QWorldMapEntity.componentDict);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_nightBase(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, QWorldMapEntity.nightBase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_exchangeNightBase(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushstring(L, QWorldMapEntity.exchangeNightBase);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bubbleClick(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<int> bubbleClick = ((QWorldMapEntity)obj).bubbleClick;
			ToLua.Push(L, bubbleClick);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bubbleClick on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isShowBubble(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isShowBubble = ((QWorldMapEntity)obj).isShowBubble;
			LuaDLL.lua_pushboolean(L, isShowBubble);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isShowBubble on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isInScreen(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isInScreen = ((QWorldMapEntity)obj).isInScreen;
			LuaDLL.lua_pushboolean(L, isInScreen);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isInScreen on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BlackBoard(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWBlackboard blackBoard = ((QWorldMapEntity)obj).BlackBoard;
			ToLua.Push(L, blackBoard);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index BlackBoard on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_NPCBlackBoard(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWNPCBlackboard nPCBlackBoard = ((QWorldMapEntity)obj).NPCBlackBoard;
			ToLua.Push(L, nPCBlackBoard);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index NPCBlackBoard on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_isLoaded(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			bool isLoaded = ((QWorldMapEntity)obj).isLoaded;
			LuaDLL.lua_pushboolean(L, isLoaded);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isLoaded on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bubbleBehvaiour(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMapEntity obj2 = (QWorldMapEntity)obj;
			QWBubbleBehvaiour bubbleBehvaiour = (QWBubbleBehvaiour)ToLua.CheckObject<QWBubbleBehvaiour>(L, 2);
			obj2.bubbleBehvaiour = bubbleBehvaiour;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bubbleBehvaiour on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_uniqueId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMapEntity obj2 = (QWorldMapEntity)obj;
			int uniqueId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.uniqueId = uniqueId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index uniqueId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_entityId(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMapEntity obj2 = (QWorldMapEntity)obj;
			int entityId = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.entityId = entityId;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index entityId on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_size(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMapEntity obj2 = (QWorldMapEntity)obj;
			Vector3 size = ToLua.ToVector3(L, 2);
			obj2.size = size;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index size on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cullMode(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMapEntity obj2 = (QWorldMapEntity)obj;
			CullMode cullMode = (CullMode)ToLua.CheckObject(L, 2, typeof(CullMode));
			obj2.cullMode = cullMode;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cullMode on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_componentDict(IntPtr L)
	{
		try
		{
			QWorldMapEntity.componentDict = (Dictionary<string, Type>)ToLua.CheckObject(L, 2, typeof(Dictionary<string, Type>));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_nightBase(IntPtr L)
	{
		try
		{
			QWorldMapEntity.nightBase = ToLua.CheckString(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_exchangeNightBase(IntPtr L)
	{
		try
		{
			QWorldMapEntity.exchangeNightBase = ToLua.CheckString(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bubbleClick(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMapEntity obj2 = (QWorldMapEntity)obj;
			Action<int> bubbleClick = (Action<int>)ToLua.CheckDelegate<Action<int>>(L, 2);
			obj2.bubbleClick = bubbleClick;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bubbleClick on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isShowBubble(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMapEntity obj2 = (QWorldMapEntity)obj;
			bool isShowBubble = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isShowBubble = isShowBubble;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isShowBubble on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_isInScreen(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			QWorldMapEntity obj2 = (QWorldMapEntity)obj;
			bool isInScreen = LuaDLL.luaL_checkboolean(L, 2);
			obj2.isInScreen = isInScreen;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index isInScreen on a nil value");
		}
	}
}
