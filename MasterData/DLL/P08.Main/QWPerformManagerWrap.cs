using System;
using LuaInterface;
using UnityEngine;

public class QWPerformManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(QWPerformManager), typeof(object));
		L.RegFunction("PlayAnimeDuringInteract", PlayAnimeDuringInteract);
		L.RegFunction("PutAt", PutAt);
		L.RegFunction("PlayEffect", PlayEffect);
		L.RegFunction("ClearEffect", ClearEffect);
		L.RegFunction("StartFurniturInteract", StartFurniturInteract);
		L.RegFunction("EndFurniturInteract", EndFurniturInteract);
		L.RegFunction("CheckFuniturePerformInterrupt", CheckFuniturePerformInterrupt);
		L.RegFunction("MarkFuniturePerformWaitInterrupt", MarkFuniturePerformWaitInterrupt);
		L.RegFunction("AttachToEntity", AttachToEntity);
		L.RegFunction("DeAttachFromEntity", DeAttachFromEntity);
		L.RegFunction("GrabItemPart", GrabItemPart);
		L.RegFunction("SetVisible", SetVisible);
		L.RegFunction("New", _CreateQWPerformManager);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("Instance", get_Instance, set_Instance);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateQWPerformManager(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				QWPerformManager o = new QWPerformManager();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: QWPerformManager.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayAnimeDuringInteract(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			QWPerformManager obj = (QWPerformManager)ToLua.CheckObject<QWPerformManager>(L, 1);
			QWorldMapEntity furniture = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 2);
			string animName = ToLua.CheckString(L, 3);
			float crossFade = (float)LuaDLL.luaL_checknumber(L, 4);
			int target = (int)LuaDLL.luaL_checknumber(L, 5);
			obj.PlayAnimeDuringInteract(furniture, animName, crossFade, target);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PutAt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			QWPerformManager obj = (QWPerformManager)ToLua.CheckObject<QWPerformManager>(L, 1);
			QWorldMapEntity furniture = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 2);
			string pointName = ToLua.CheckString(L, 3);
			obj.PutAt(furniture, pointName);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int PlayEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 9);
			QWPerformManager obj = (QWPerformManager)ToLua.CheckObject<QWPerformManager>(L, 1);
			QWorldMapEntity furniture = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 2);
			string attachPoint = ToLua.CheckString(L, 3);
			string efxPath = ToLua.CheckString(L, 4);
			Vector3 pos = ToLua.ToVector3(L, 5);
			Quaternion rot = ToLua.ToQuaternion(L, 6);
			Vector3 scale = ToLua.ToVector3(L, 7);
			float duration = (float)LuaDLL.luaL_checknumber(L, 8);
			int target = (int)LuaDLL.luaL_checknumber(L, 9);
			obj.PlayEffect(furniture, attachPoint, efxPath, pos, rot, scale, duration, target);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearEffect(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			QWPerformManager obj = (QWPerformManager)ToLua.CheckObject<QWPerformManager>(L, 1);
			QWorldMapEntity furniture = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 2);
			string attachPoint = ToLua.CheckString(L, 3);
			int target = (int)LuaDLL.luaL_checknumber(L, 4);
			obj.ClearEffect(furniture, attachPoint, target);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StartFurniturInteract(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			QWPerformManager obj = (QWPerformManager)ToLua.CheckObject<QWPerformManager>(L, 1);
			QWorldMapEntity furniture = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 2);
			Action complete = (Action)ToLua.CheckDelegate<Action>(L, 3);
			obj.StartFurniturInteract(furniture, complete);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EndFurniturInteract(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWPerformManager obj = (QWPerformManager)ToLua.CheckObject<QWPerformManager>(L, 1);
			QWorldMapEntity furniture = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 2);
			obj.EndFurniturInteract(furniture);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CheckFuniturePerformInterrupt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWPerformManager obj = (QWPerformManager)ToLua.CheckObject<QWPerformManager>(L, 1);
			QWorldMapEntity furniture = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 2);
			bool value = obj.CheckFuniturePerformInterrupt(furniture);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MarkFuniturePerformWaitInterrupt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			QWPerformManager obj = (QWPerformManager)ToLua.CheckObject<QWPerformManager>(L, 1);
			QWorldMapEntity furniture = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 2);
			obj.MarkFuniturePerformWaitInterrupt(furniture);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int AttachToEntity(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 3:
			{
				QWorldMapEntity furniture2 = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				int parent2 = (int)LuaDLL.luaL_checknumber(L, 2);
				string attachPoint2 = ToLua.CheckString(L, 3);
				QWPerformManager.AttachToEntity(furniture2, parent2, attachPoint2);
				return 0;
			}
			case 4:
			{
				QWorldMapEntity furniture = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				int parent = (int)LuaDLL.luaL_checknumber(L, 2);
				string attachPoint = ToLua.CheckString(L, 3);
				bool setAsChild = LuaDLL.luaL_checkboolean(L, 4);
				QWPerformManager.AttachToEntity(furniture, parent, attachPoint, setAsChild);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWPerformManager.AttachToEntity");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DeAttachFromEntity(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 2:
			{
				QWorldMapEntity furniture2 = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				int item2 = (int)LuaDLL.luaL_checknumber(L, 2);
				QWPerformManager.DeAttachFromEntity(furniture2, item2);
				return 0;
			}
			case 3:
			{
				QWorldMapEntity furniture = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
				int item = (int)LuaDLL.luaL_checknumber(L, 2);
				bool resetFaceDir = LuaDLL.luaL_checkboolean(L, 3);
				QWPerformManager.DeAttachFromEntity(furniture, item, resetFaceDir);
				return 0;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: QWPerformManager.DeAttachFromEntity");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GrabItemPart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			QWorldMapEntity furniture = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			int target = (int)LuaDLL.luaL_checknumber(L, 2);
			string itemPart = ToLua.CheckString(L, 3);
			string attachPoint = ToLua.CheckString(L, 4);
			QWPerformManager.GrabItemPart(furniture, target, itemPart, attachPoint);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetVisible(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			QWorldMapEntity furniture = (QWorldMapEntity)ToLua.CheckObject<QWorldMapEntity>(L, 1);
			int target = (int)LuaDLL.luaL_checknumber(L, 2);
			bool visible = LuaDLL.luaL_checkboolean(L, 3);
			QWPerformManager.SetVisible(furniture, target, visible);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_Instance(IntPtr L)
	{
		try
		{
			ToLua.PushObject(L, QWPerformManager.Instance);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_Instance(IntPtr L)
	{
		try
		{
			QWPerformManager.Instance = (QWPerformManager)ToLua.CheckObject<QWPerformManager>(L, 2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
