using System;
using LuaInterface;
using UnityEngine;

public class PaperCutManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(PaperCutManager), typeof(MonoBehaviour));
		L.RegFunction("GameStart", GameStart);
		L.RegFunction("GameOver", GameOver);
		L.RegFunction("IsClickOnUI", IsClickOnUI);
		L.RegFunction("IsPointerOverUIObject", IsPointerOverUIObject);
		L.RegFunction("DisplayResultImage", DisplayResultImage);
		L.RegFunction("CalculateScore", CalculateScore);
		L.RegFunction("SetOnComplete", SetOnComplete);
		L.RegFunction("SetOnStartDraw", SetOnStartDraw);
		L.RegFunction("SetCheckPanelTrans", SetCheckPanelTrans);
		L.RegFunction("SetResultUIImage", SetResultUIImage);
		L.RegFunction("SetCanvasScale", SetCanvasScale);
		L.RegFunction("SetCanvas", SetCanvas);
		L.RegFunction("InitialScene", InitialScene);
		L.RegFunction("ResetScene", ResetScene);
		L.RegFunction("LoadCheckPointPanel", LoadCheckPointPanel);
		L.RegFunction("__eq", op_Equality);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("checkRadius", get_checkRadius, set_checkRadius);
		L.RegVar("checkCloseRadius", get_checkCloseRadius, set_checkCloseRadius);
		L.RegVar("checkPointPanelParent", get_checkPointPanelParent, set_checkPointPanelParent);
		L.RegVar("checkPointRadius", get_checkPointRadius, set_checkPointRadius);
		L.RegVar("maxDrawPointStep", get_maxDrawPointStep, set_maxDrawPointStep);
		L.RegVar("BRUSH_SIZE", get_BRUSH_SIZE, set_BRUSH_SIZE);
		L.RegVar("brushMaterial", get_brushMaterial, set_brushMaterial);
		L.RegVar("_ResultMaterial", get__ResultMaterial, set__ResultMaterial);
		L.RegVar("resultSpriteRenderer", get_resultSpriteRenderer, set_resultSpriteRenderer);
		L.RegVar("tempTexture2D", get_tempTexture2D, set_tempTexture2D);
		L.RegVar("drawSpriteGo", get_drawSpriteGo, set_drawSpriteGo);
		L.RegVar("resultMeshFilter", get_resultMeshFilter, set_resultMeshFilter);
		L.RegVar("bgTexture", get_bgTexture, set_bgTexture);
		L.RegVar("bgRenderer", get_bgRenderer, set_bgRenderer);
		L.RegVar("cursorGo", get_cursorGo, set_cursorGo);
		L.RegVar("cueSheetName_loop", get_cueSheetName_loop, set_cueSheetName_loop);
		L.RegVar("cueName_loop", get_cueName_loop, set_cueName_loop);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GameStart(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1)).GameStart();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GameOver(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1)).GameOver();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsClickOnUI(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = ((PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1)).IsClickOnUI();
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int IsPointerOverUIObject(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PaperCutManager obj = (PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1);
			Vector2 screenPosition = ToLua.ToVector2(L, 2);
			bool value = obj.IsPointerOverUIObject(screenPosition);
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int DisplayResultImage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PaperCutManager obj = (PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1);
			PaperCutUIImage image = (PaperCutUIImage)ToLua.CheckObject<PaperCutUIImage>(L, 2);
			obj.DisplayResultImage(image);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CalculateScore(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			int n = ((PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1)).CalculateScore();
			LuaDLL.lua_pushinteger(L, n);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetOnComplete(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PaperCutManager obj = (PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1);
			Action onComplete = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.SetOnComplete(onComplete);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetOnStartDraw(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PaperCutManager obj = (PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1);
			Action onStartDraw = (Action)ToLua.CheckDelegate<Action>(L, 2);
			obj.SetOnStartDraw(onStartDraw);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCheckPanelTrans(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PaperCutManager obj = (PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1);
			Transform checkPanelTrans = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj.SetCheckPanelTrans(checkPanelTrans);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetResultUIImage(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PaperCutManager obj = (PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1);
			PaperCutUIImage resultUIImage = (PaperCutUIImage)ToLua.CheckObject<PaperCutUIImage>(L, 2);
			obj.SetResultUIImage(resultUIImage);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCanvasScale(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PaperCutManager obj = (PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1);
			Vector2 canvasScale = ToLua.ToVector2(L, 2);
			obj.SetCanvasScale(canvasScale);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetCanvas(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PaperCutManager obj = (PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1);
			GameObject canvas = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj.SetCanvas(canvas);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int InitialScene(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1)).InitialScene();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int ResetScene(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			((PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1)).ResetScene();
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadCheckPointPanel(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			PaperCutManager obj = (PaperCutManager)ToLua.CheckObject<PaperCutManager>(L, 1);
			int activityID = (int)LuaDLL.luaL_checknumber(L, 2);
			obj.LoadCheckPointPanel(activityID);
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
	private static int get_checkRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int checkRadius = ((PaperCutManager)obj).checkRadius;
			LuaDLL.lua_pushinteger(L, checkRadius);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index checkRadius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_checkCloseRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int checkCloseRadius = ((PaperCutManager)obj).checkCloseRadius;
			LuaDLL.lua_pushinteger(L, checkCloseRadius);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index checkCloseRadius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_checkPointPanelParent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Transform checkPointPanelParent = ((PaperCutManager)obj).checkPointPanelParent;
			ToLua.Push(L, checkPointPanelParent);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index checkPointPanelParent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_checkPointRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int checkPointRadius = ((PaperCutManager)obj).checkPointRadius;
			LuaDLL.lua_pushinteger(L, checkPointRadius);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index checkPointRadius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_maxDrawPointStep(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			int maxDrawPointStep = ((PaperCutManager)obj).maxDrawPointStep;
			LuaDLL.lua_pushinteger(L, maxDrawPointStep);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxDrawPointStep on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_BRUSH_SIZE(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			float bRUSH_SIZE = ((PaperCutManager)obj).BRUSH_SIZE;
			LuaDLL.lua_pushnumber(L, bRUSH_SIZE);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index BRUSH_SIZE on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_brushMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material brushMaterial = ((PaperCutManager)obj).brushMaterial;
			ToLua.Push(L, brushMaterial);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index brushMaterial on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get__ResultMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Material resultMaterial = ((PaperCutManager)obj)._ResultMaterial;
			ToLua.Push(L, resultMaterial);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _ResultMaterial on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resultSpriteRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer resultSpriteRenderer = ((PaperCutManager)obj).resultSpriteRenderer;
			ToLua.PushSealed(L, resultSpriteRenderer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultSpriteRenderer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_tempTexture2D(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture2D tempTexture2D = ((PaperCutManager)obj).tempTexture2D;
			ToLua.PushSealed(L, tempTexture2D);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tempTexture2D on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_drawSpriteGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject drawSpriteGo = ((PaperCutManager)obj).drawSpriteGo;
			ToLua.PushSealed(L, drawSpriteGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index drawSpriteGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_resultMeshFilter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			MeshFilter resultMeshFilter = ((PaperCutManager)obj).resultMeshFilter;
			ToLua.PushSealed(L, resultMeshFilter);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultMeshFilter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bgTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			Texture bgTexture = ((PaperCutManager)obj).bgTexture;
			ToLua.Push(L, bgTexture);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bgTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_bgRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			SpriteRenderer bgRenderer = ((PaperCutManager)obj).bgRenderer;
			ToLua.PushSealed(L, bgRenderer);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bgRenderer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cursorGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			GameObject cursorGo = ((PaperCutManager)obj).cursorGo;
			ToLua.PushSealed(L, cursorGo);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cursorGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cueSheetName_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string cueSheetName_loop = ((PaperCutManager)obj).cueSheetName_loop;
			LuaDLL.lua_pushstring(L, cueSheetName_loop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueSheetName_loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_cueName_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			string cueName_loop = ((PaperCutManager)obj).cueName_loop;
			LuaDLL.lua_pushstring(L, cueName_loop);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueName_loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_checkRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			int checkRadius = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.checkRadius = checkRadius;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index checkRadius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_checkCloseRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			int checkCloseRadius = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.checkCloseRadius = checkCloseRadius;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index checkCloseRadius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_checkPointPanelParent(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			Transform checkPointPanelParent = (Transform)ToLua.CheckObject<Transform>(L, 2);
			obj2.checkPointPanelParent = checkPointPanelParent;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index checkPointPanelParent on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_checkPointRadius(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			int checkPointRadius = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.checkPointRadius = checkPointRadius;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index checkPointRadius on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_maxDrawPointStep(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			int maxDrawPointStep = (int)LuaDLL.luaL_checknumber(L, 2);
			obj2.maxDrawPointStep = maxDrawPointStep;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index maxDrawPointStep on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_BRUSH_SIZE(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			float bRUSH_SIZE = (float)LuaDLL.luaL_checknumber(L, 2);
			obj2.BRUSH_SIZE = bRUSH_SIZE;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index BRUSH_SIZE on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_brushMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			Material brushMaterial = (Material)ToLua.CheckObject<Material>(L, 2);
			obj2.brushMaterial = brushMaterial;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index brushMaterial on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set__ResultMaterial(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			Material resultMaterial = (Material)ToLua.CheckObject<Material>(L, 2);
			obj2._ResultMaterial = resultMaterial;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index _ResultMaterial on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resultSpriteRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			SpriteRenderer resultSpriteRenderer = (SpriteRenderer)ToLua.CheckObject(L, 2, typeof(SpriteRenderer));
			obj2.resultSpriteRenderer = resultSpriteRenderer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultSpriteRenderer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_tempTexture2D(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			Texture2D tempTexture2D = (Texture2D)ToLua.CheckObject(L, 2, typeof(Texture2D));
			obj2.tempTexture2D = tempTexture2D;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index tempTexture2D on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_drawSpriteGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			GameObject drawSpriteGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.drawSpriteGo = drawSpriteGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index drawSpriteGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_resultMeshFilter(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			MeshFilter resultMeshFilter = (MeshFilter)ToLua.CheckObject(L, 2, typeof(MeshFilter));
			obj2.resultMeshFilter = resultMeshFilter;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index resultMeshFilter on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bgTexture(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			Texture bgTexture = (Texture)ToLua.CheckObject<Texture>(L, 2);
			obj2.bgTexture = bgTexture;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bgTexture on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_bgRenderer(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			SpriteRenderer bgRenderer = (SpriteRenderer)ToLua.CheckObject(L, 2, typeof(SpriteRenderer));
			obj2.bgRenderer = bgRenderer;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index bgRenderer on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cursorGo(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			GameObject cursorGo = (GameObject)ToLua.CheckObject(L, 2, typeof(GameObject));
			obj2.cursorGo = cursorGo;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cursorGo on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cueSheetName_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			string cueSheetName_loop = ToLua.CheckString(L, 2);
			obj2.cueSheetName_loop = cueSheetName_loop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueSheetName_loop on a nil value");
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_cueName_loop(IntPtr L)
	{
		object obj = null;
		try
		{
			obj = ToLua.ToObject(L, 1);
			PaperCutManager obj2 = (PaperCutManager)obj;
			string cueName_loop = ToLua.CheckString(L, 2);
			obj2.cueName_loop = cueName_loop;
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e, obj, "attempt to index cueName_loop on a nil value");
		}
	}
}
