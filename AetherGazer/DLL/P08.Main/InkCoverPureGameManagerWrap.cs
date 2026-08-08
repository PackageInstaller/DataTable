using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class InkCoverPureGameManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(InkCoverPureGameManager), typeof(MonoBehaviour));
		L.RegFunction("Reset", Reset);
		L.RegFunction("OnPointerDown", OnPointerDown);
		L.RegFunction("OnPointerUp", OnPointerUp);
		L.RegFunction("OnDrag", OnDrag);
		L.RegFunction("Update", Update);
		L.RegFunction("GenerateFeatheredBrush", GenerateFeatheredBrush);
		L.RegFunction("IsCompleted", IsCompleted);
		L.RegFunction("GetCurrentProgress", GetCurrentProgress);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("brushSize", get_brushSize, set_brushSize);
		L.RegVar("brushHardness", get_brushHardness, set_brushHardness);
		L.RegVar("eraseShader", get_eraseShader, set_eraseShader);
		L.RegVar("spacingFactor", get_spacingFactor, set_spacingFactor);
		L.RegVar("requiredEraseRatio", get_requiredEraseRatio, set_requiredEraseRatio);
		L.RegVar("inkImage", get_inkImage, set_inkImage);
		L.RegVar("OnBeginDragFun", get_OnBeginDragFun, set_OnBeginDragFun);
		L.RegVar("OnDragFun", get_OnDragFun, set_OnDragFun);
		L.RegVar("OnEndDragFun", get_OnEndDragFun, set_OnEndDragFun);
		L.RegVar("OnCompletedFun", get_OnCompletedFun, set_OnCompletedFun);
		L.RegVar("OnValueChangedFun", get_OnValueChangedFun, set_OnValueChangedFun);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int Reset(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((InkCoverPureGameManager)ToLua.CheckObject<InkCoverPureGameManager>(L, 1)).Reset();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerDown(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InkCoverPureGameManager obj = (InkCoverPureGameManager)ToLua.CheckObject<InkCoverPureGameManager>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerDown(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnPointerUp(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InkCoverPureGameManager obj = (InkCoverPureGameManager)ToLua.CheckObject<InkCoverPureGameManager>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnPointerUp(eventData);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int OnDrag(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			InkCoverPureGameManager obj = (InkCoverPureGameManager)ToLua.CheckObject<InkCoverPureGameManager>(L, 1);
			PointerEventData eventData = (PointerEventData)ToLua.CheckObject<PointerEventData>(L, 2);
			obj.OnDrag(eventData);
			return 0;
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
			ToLua.CheckArgsCount(L, 1);
			((InkCoverPureGameManager)ToLua.CheckObject<InkCoverPureGameManager>(L, 1)).Update();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GenerateFeatheredBrush(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Texture2D o2 = InkCoverPureGameManager.GenerateFeatheredBrush((int)LuaDLL.luaL_checknumber(L, 1));
				ToLua.PushSealed(L, o2);
				return 1;
			}
			case 2:
			{
				int size = (int)LuaDLL.luaL_checknumber(L, 1);
				float hardness = (float)LuaDLL.luaL_checknumber(L, 2);
				Texture2D o = InkCoverPureGameManager.GenerateFeatheredBrush(size, hardness);
				ToLua.PushSealed(L, o);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: InkCoverPureGameManager.GenerateFeatheredBrush");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsCompleted(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((InkCoverPureGameManager)ToLua.CheckObject<InkCoverPureGameManager>(L, 1)).IsCompleted();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetCurrentProgress(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			float currentProgress = ((InkCoverPureGameManager)ToLua.CheckObject<InkCoverPureGameManager>(L, 1)).GetCurrentProgress();
			LuaDLL.lua_pushnumber(L, currentProgress);
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
	private static int get_brushSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int brushSize = ((InkCoverPureGameManager)obj).brushSize;
			LuaDLL.lua_pushinteger(L, brushSize);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index brushSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_brushHardness(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float brushHardness = ((InkCoverPureGameManager)obj).brushHardness;
			LuaDLL.lua_pushnumber(L, brushHardness);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index brushHardness on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_eraseShader(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Shader eraseShader = ((InkCoverPureGameManager)obj).eraseShader;
			ToLua.PushSealed(L, eraseShader);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eraseShader on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_spacingFactor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float spacingFactor = ((InkCoverPureGameManager)obj).spacingFactor;
			LuaDLL.lua_pushnumber(L, spacingFactor);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spacingFactor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_requiredEraseRatio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float requiredEraseRatio = ((InkCoverPureGameManager)obj).requiredEraseRatio;
			LuaDLL.lua_pushnumber(L, requiredEraseRatio);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index requiredEraseRatio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_inkImage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			RawImage inkImage = ((InkCoverPureGameManager)obj).inkImage;
			ToLua.Push(L, inkImage);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inkImage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnBeginDragFun(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action onBeginDragFun = ((InkCoverPureGameManager)obj).OnBeginDragFun;
			ToLua.Push(L, onBeginDragFun);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnBeginDragFun on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnDragFun(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action onDragFun = ((InkCoverPureGameManager)obj).OnDragFun;
			ToLua.Push(L, onDragFun);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnDragFun on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnEndDragFun(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action onEndDragFun = ((InkCoverPureGameManager)obj).OnEndDragFun;
			ToLua.Push(L, onEndDragFun);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnEndDragFun on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnCompletedFun(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action onCompletedFun = ((InkCoverPureGameManager)obj).OnCompletedFun;
			ToLua.Push(L, onCompletedFun);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnCompletedFun on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_OnValueChangedFun(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Action<bool> onValueChangedFun = ((InkCoverPureGameManager)obj).OnValueChangedFun;
			ToLua.Push(L, onValueChangedFun);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnValueChangedFun on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_brushSize(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InkCoverPureGameManager obj2 = (InkCoverPureGameManager)obj;
			int brushSize = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.brushSize = brushSize;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index brushSize on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_brushHardness(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InkCoverPureGameManager obj2 = (InkCoverPureGameManager)obj;
			float brushHardness = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.brushHardness = brushHardness;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index brushHardness on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_eraseShader(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InkCoverPureGameManager obj2 = (InkCoverPureGameManager)obj;
			Shader eraseShader = (Shader)ToLua.CheckObject(L, 2, typeof(Shader));
			obj2.eraseShader = eraseShader;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index eraseShader on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_spacingFactor(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InkCoverPureGameManager obj2 = (InkCoverPureGameManager)obj;
			float spacingFactor = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.spacingFactor = spacingFactor;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index spacingFactor on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_requiredEraseRatio(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InkCoverPureGameManager obj2 = (InkCoverPureGameManager)obj;
			float requiredEraseRatio = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.requiredEraseRatio = requiredEraseRatio;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index requiredEraseRatio on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_inkImage(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InkCoverPureGameManager obj2 = (InkCoverPureGameManager)obj;
			RawImage inkImage = (RawImage)ToLua.CheckObject<RawImage>(L, 2);
			obj2.inkImage = inkImage;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index inkImage on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnBeginDragFun(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InkCoverPureGameManager obj2 = (InkCoverPureGameManager)obj;
			Action onBeginDragFun = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.OnBeginDragFun = onBeginDragFun;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnBeginDragFun on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnDragFun(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InkCoverPureGameManager obj2 = (InkCoverPureGameManager)obj;
			Action onDragFun = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.OnDragFun = onDragFun;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnDragFun on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnEndDragFun(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InkCoverPureGameManager obj2 = (InkCoverPureGameManager)obj;
			Action onEndDragFun = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.OnEndDragFun = onEndDragFun;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnEndDragFun on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnCompletedFun(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InkCoverPureGameManager obj2 = (InkCoverPureGameManager)obj;
			Action onCompletedFun = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj2.OnCompletedFun = onCompletedFun;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnCompletedFun on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_OnValueChangedFun(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			InkCoverPureGameManager obj2 = (InkCoverPureGameManager)obj;
			Action<bool> onValueChangedFun = (Action<bool>)ToLua.CheckDelegate<Action<bool>>(L, 2);
			obj2.OnValueChangedFun = onValueChangedFun;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index OnValueChangedFun on a nil value");
		}
	}
}
