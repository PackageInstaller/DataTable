using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;

public class LuaHelperWrap
{
	public static void Register(LuaState L)
	{
		L.BeginStaticLibs("LuaHelper");
		L.RegFunction("SetLua", SetLua);
		L.RegFunction("IsLuaClientInited", IsLuaClientInited);
		L.RegFunction("CallFunction", CallFunction);
		L.RegFunction("EventTriggerAction1", EventTriggerAction1);
		L.RegFunction("EventTriggerAction2", EventTriggerAction2);
		L.RegFunction("EventTriggerAction3", EventTriggerAction3);
		L.RegFunction("VoidAction", VoidAction);
		L.RegFunction("FloatAction", FloatAction);
		L.RegFunction("StringAction", StringAction);
		L.RegFunction("CloneOb", CloneOb);
		L.RegFunction("IsUObject", IsUObject);
		L.RegFunction("UnityGC", UnityGC);
		L.RegFunction("SafeDelOb", SafeDelOb);
		L.RegFunction("ShowOb", ShowOb);
		L.RegFunction("GetPlatform", GetPlatform);
		L.RegFunction("ScreenToLocal", ScreenToLocal);
		L.RegFunction("SetTfLocalPosValue", SetTfLocalPosValue);
		L.RegFunction("SetRtfLocalPosValue", SetRtfLocalPosValue);
		L.RegFunction("SetTfWorldPosValue", SetTfWorldPosValue);
		L.RegFunction("SetTfLoalScaleValue", SetTfLoalScaleValue);
		L.RegFunction("SetRtfLocalScaleValue", SetRtfLocalScaleValue);
		L.RegFunction("SetTfLocalRotateValue", SetTfLocalRotateValue);
		L.RegFunction("SetRtfLocalRotateValue", SetRtfLocalRotateValue);
		L.RegFunction("SetGOParentGO", SetGOParentGO);
		L.RegFunction("SetGOParentTF", SetGOParentTF);
		L.RegFunction("CopyTransformInfoGO", CopyTransformInfoGO);
		L.RegFunction("CopyTransformInfoTF", CopyTransformInfoTF);
		L.RegFunction("SetTFChildActive", SetTFChildActive);
		L.RegFunction("ResetTF", ResetTF);
		L.RegFunction("ClearObject", ClearObject);
		L.RegFunction("SetSpColor", SetSpColor);
		L.RegFunction("SetRtfSize", SetRtfSize);
		L.RegFunction("StringToColor", StringToColor);
		L.RegFunction("GetTotalGCMemory", GetTotalGCMemory);
		L.RegFunction("GetAllocateMemoryFromCurrentThread", GetAllocateMemoryFromCurrentThread);
		L.RegFunction("GetLuaMemory", GetLuaMemory);
		L.RegFunction("LogLuaState", LogLuaState);
		L.RegFunction("SendOnBeginDragToHandler", SendOnBeginDragToHandler);
		L.RegFunction("SendOnDragToHandler", SendOnDragToHandler);
		L.RegFunction("SendOnEndDragToHandler", SendOnEndDragToHandler);
		L.RegFunction("Quit", Quit);
		L.EndStaticLibs();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetLua(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaHelper.SetLua((ILuaInterface)ToLua.CheckObject<ILuaInterface>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsLuaClientInited(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			bool value = LuaHelper.IsLuaClientInited();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CallFunction(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			string funcName = ToLua.CheckString(L, 1);
			object[] args = ToLua.ToParamsObject(L, 2, num - 1);
			object[] array = LuaHelper.CallFunction(funcName, args);
			ToLua.Push(L, array);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EventTriggerAction1(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaHelper.ETLCallBack1 ev = LuaHelper.EventTriggerAction1(ToLua.CheckLuaFunction(L, 1));
			ToLua.Push(L, ev);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EventTriggerAction2(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaHelper.ETLCallBack2 ev = LuaHelper.EventTriggerAction2(ToLua.CheckLuaFunction(L, 1));
			ToLua.Push(L, ev);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int EventTriggerAction3(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaHelper.ETLCallBack3 ev = LuaHelper.EventTriggerAction3(ToLua.CheckLuaFunction(L, 1));
			ToLua.Push(L, ev);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int VoidAction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Action ev = LuaHelper.VoidAction(ToLua.CheckLuaFunction(L, 1));
			ToLua.Push(L, ev);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int FloatAction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Action<float> ev = LuaHelper.FloatAction(ToLua.CheckLuaFunction(L, 1));
			ToLua.Push(L, ev);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StringAction(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Action<string> ev = LuaHelper.StringAction(ToLua.CheckLuaFunction(L, 1));
			ToLua.Push(L, ev);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CloneOb(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			object obj = LuaHelper.CloneOb((UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1));
			ToLua.Push(L, obj);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsUObject(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = LuaHelper.IsUObject(ToLua.ToVarObject(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnityGC(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaHelper.UnityGC();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SafeDelOb(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaHelper.SafeDelOb(ToLua.ToVarObject(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ShowOb(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string str = LuaHelper.ShowOb(ToLua.ToVarObject(L, 1));
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetPlatform(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			RuntimePlatform platform = LuaHelper.GetPlatform();
			ToLua.Push(L, platform);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ScreenToLocal(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RectTransform rtf = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			Vector2 scrPos = ToLua.ToVector2(L, 2);
			Camera cam = (Camera)ToLua.CheckObject(L, 3, typeof(Camera));
			Vector2 v = LuaHelper.ScreenToLocal(rtf, scrPos, cam);
			ToLua.Push(L, v);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTfLocalPosValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Transform tf = (Transform)ToLua.CheckObject<Transform>(L, 1);
			float v = (float)LuaDLL.luaL_checknumber(L, 2);
			float v2 = (float)LuaDLL.luaL_checknumber(L, 3);
			float v3 = (float)LuaDLL.luaL_checknumber(L, 4);
			LuaHelper.SetTfLocalPosValue(tf, v, v2, v3);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRtfLocalPosValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RectTransform tf = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float v = (float)LuaDLL.luaL_checknumber(L, 2);
			float v2 = (float)LuaDLL.luaL_checknumber(L, 3);
			float v3 = (float)LuaDLL.luaL_checknumber(L, 4);
			LuaHelper.SetRtfLocalPosValue(tf, v, v2, v3);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTfWorldPosValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Transform tf = (Transform)ToLua.CheckObject<Transform>(L, 1);
			float v = (float)LuaDLL.luaL_checknumber(L, 2);
			float v2 = (float)LuaDLL.luaL_checknumber(L, 3);
			float v3 = (float)LuaDLL.luaL_checknumber(L, 4);
			LuaHelper.SetTfWorldPosValue(tf, v, v2, v3);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTfLoalScaleValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Transform tf = (Transform)ToLua.CheckObject<Transform>(L, 1);
			float v = (float)LuaDLL.luaL_checknumber(L, 2);
			float v2 = (float)LuaDLL.luaL_checknumber(L, 3);
			float v3 = (float)LuaDLL.luaL_checknumber(L, 4);
			LuaHelper.SetTfLoalScaleValue(tf, v, v2, v3);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRtfLocalScaleValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RectTransform tf = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float v = (float)LuaDLL.luaL_checknumber(L, 2);
			float v2 = (float)LuaDLL.luaL_checknumber(L, 3);
			float v3 = (float)LuaDLL.luaL_checknumber(L, 4);
			LuaHelper.SetRtfLocalScaleValue(tf, v, v2, v3);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTfLocalRotateValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			Transform tf = (Transform)ToLua.CheckObject<Transform>(L, 1);
			float v = (float)LuaDLL.luaL_checknumber(L, 2);
			float v2 = (float)LuaDLL.luaL_checknumber(L, 3);
			float v3 = (float)LuaDLL.luaL_checknumber(L, 4);
			LuaHelper.SetTfLocalRotateValue(tf, v, v2, v3);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRtfLocalRotateValue(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 4);
			RectTransform tf = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float v = (float)LuaDLL.luaL_checknumber(L, 2);
			float v2 = (float)LuaDLL.luaL_checknumber(L, 3);
			float v3 = (float)LuaDLL.luaL_checknumber(L, 4);
			LuaHelper.SetRtfLocalRotateValue(tf, v, v2, v3);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGOParentGO(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject child = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			GameObject parent = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			bool keepPos = LuaDLL.luaL_checkboolean(L, 3);
			LuaHelper.SetGOParentGO(child, parent, keepPos);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetGOParentTF(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			GameObject child = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			Transform parent = (Transform)ToLua.CheckObject<Transform>(L, 2);
			bool keepPos = LuaDLL.luaL_checkboolean(L, 3);
			LuaHelper.SetGOParentTF(child, parent, keepPos);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CopyTransformInfoGO(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject ob = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			GameObject src = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			LuaHelper.CopyTransformInfoGO(ob, src);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CopyTransformInfoTF(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Transform tf = (Transform)ToLua.CheckObject<Transform>(L, 1);
			Transform src = (Transform)ToLua.CheckObject<Transform>(L, 2);
			LuaHelper.CopyTransformInfoTF(tf, src);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetTFChildActive(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			Transform tf = (Transform)ToLua.CheckObject<Transform>(L, 1);
			string childName = ToLua.CheckString(L, 2);
			bool active = LuaDLL.luaL_checkboolean(L, 3);
			LuaHelper.SetTFChildActive(tf, childName, active);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetTF(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Transform tf = (Transform)ToLua.CheckObject<Transform>(L, 1);
			bool active = LuaDLL.luaL_checkboolean(L, 2);
			LuaHelper.ResetTF(tf, active);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ClearObject(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			LuaHelper.ClearObject((UnityEngine.Object)ToLua.CheckObject<UnityEngine.Object>(L, 1));
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetSpColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 5);
			SpriteRenderer sp = (SpriteRenderer)ToLua.CheckObject(L, 1, typeof(SpriteRenderer));
			float r = (float)LuaDLL.luaL_checknumber(L, 2);
			float g = (float)LuaDLL.luaL_checknumber(L, 3);
			float b = (float)LuaDLL.luaL_checknumber(L, 4);
			float a = (float)LuaDLL.luaL_checknumber(L, 5);
			LuaHelper.SetSpColor(sp, r, g, b, a);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetRtfSize(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 3);
			RectTransform tf = (RectTransform)ToLua.CheckObject(L, 1, typeof(RectTransform));
			float v = (float)LuaDLL.luaL_checknumber(L, 2);
			float v2 = (float)LuaDLL.luaL_checknumber(L, 3);
			LuaHelper.SetRtfSize(tf, v, v2);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int StringToColor(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Color clr = LuaHelper.StringToColor(ToLua.CheckString(L, 1));
			ToLua.Push(L, clr);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetTotalGCMemory(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			string totalGCMemory = LuaHelper.GetTotalGCMemory(LuaDLL.luaL_checkboolean(L, 1));
			LuaDLL.lua_pushstring(L, totalGCMemory);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetAllocateMemoryFromCurrentThread(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string allocateMemoryFromCurrentThread = LuaHelper.GetAllocateMemoryFromCurrentThread();
			LuaDLL.lua_pushstring(L, allocateMemoryFromCurrentThread);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetLuaMemory(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string luaMemory = LuaHelper.GetLuaMemory();
			LuaDLL.lua_pushstring(L, luaMemory);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LogLuaState(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			string str = LuaHelper.LogLuaState();
			LuaDLL.lua_pushstring(L, str);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendOnBeginDragToHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IBeginDragHandler handler = (IBeginDragHandler)ToLua.CheckObject<IBeginDragHandler>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			LuaHelper.SendOnBeginDragToHandler(handler, eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendOnDragToHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IDragHandler handler = (IDragHandler)ToLua.CheckObject<IDragHandler>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			LuaHelper.SendOnDragToHandler(handler, eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SendOnEndDragToHandler(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			IEndDragHandler handler = (IEndDragHandler)ToLua.CheckObject<IEndDragHandler>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			LuaHelper.SendOnEndDragToHandler(handler, eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Quit(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			LuaHelper.Quit();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
