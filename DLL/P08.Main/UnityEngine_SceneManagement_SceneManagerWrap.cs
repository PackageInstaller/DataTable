using System;
using LuaInterface;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.SceneManagement;

public class UnityEngine_SceneManagement_SceneManagerWrap
{
	public static void Register(LuaState L)
	{
		L.BeginClass(typeof(SceneManager), typeof(object));
		L.RegFunction("GetActiveScene", GetActiveScene);
		L.RegFunction("SetActiveScene", SetActiveScene);
		L.RegFunction("GetSceneByPath", GetSceneByPath);
		L.RegFunction("GetSceneByName", GetSceneByName);
		L.RegFunction("GetSceneByBuildIndex", GetSceneByBuildIndex);
		L.RegFunction("GetSceneAt", GetSceneAt);
		L.RegFunction("CreateScene", CreateScene);
		L.RegFunction("MergeScenes", MergeScenes);
		L.RegFunction("MoveGameObjectToScene", MoveGameObjectToScene);
		L.RegFunction("LoadScene", LoadScene);
		L.RegFunction("LoadSceneAsync", LoadSceneAsync);
		L.RegFunction("UnloadSceneAsync", UnloadSceneAsync);
		L.RegFunction("New", _CreateUnityEngine_SceneManagement_SceneManager);
		L.RegFunction("__tostring", ToLua.op_ToString);
		L.RegVar("sceneCount", get_sceneCount, null);
		L.RegVar("sceneCountInBuildSettings", get_sceneCountInBuildSettings, null);
		L.RegVar("sceneLoaded", get_sceneLoaded, set_sceneLoaded);
		L.RegVar("sceneUnloaded", get_sceneUnloaded, set_sceneUnloaded);
		L.RegVar("activeSceneChanged", get_activeSceneChanged, set_activeSceneChanged);
		L.EndClass();
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int _CreateUnityEngine_SceneManagement_SceneManager(IntPtr L)
	{
		try
		{
			if (LuaDLL.lua_gettop(L) == 0)
			{
				SceneManager o = new SceneManager();
				ToLua.PushObject(L, o);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to ctor method: UnityEngine.SceneManagement.SceneManager.New");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetActiveScene(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 0);
			Scene activeScene = SceneManager.GetActiveScene();
			ToLua.PushValue(L, activeScene);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int SetActiveScene(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			bool value = SceneManager.SetActiveScene(StackTraits<Scene>.Check(L, 1));
			LuaDLL.lua_pushboolean(L, value);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSceneByPath(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Scene sceneByPath = SceneManager.GetSceneByPath(ToLua.CheckString(L, 1));
			ToLua.PushValue(L, sceneByPath);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSceneByName(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Scene sceneByName = SceneManager.GetSceneByName(ToLua.CheckString(L, 1));
			ToLua.PushValue(L, sceneByName);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSceneByBuildIndex(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Scene sceneByBuildIndex = SceneManager.GetSceneByBuildIndex((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.PushValue(L, sceneByBuildIndex);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int GetSceneAt(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 1);
			Scene sceneAt = SceneManager.GetSceneAt((int)LuaDLL.luaL_checknumber(L, 1));
			ToLua.PushValue(L, sceneAt);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int CreateScene(IntPtr L)
	{
		try
		{
			switch (LuaDLL.lua_gettop(L))
			{
			case 1:
			{
				Scene v2 = SceneManager.CreateScene(ToLua.CheckString(L, 1));
				ToLua.PushValue(L, v2);
				return 1;
			}
			case 2:
			{
				string sceneName = ToLua.CheckString(L, 1);
				CreateSceneParameters parameters = StackTraits<CreateSceneParameters>.Check(L, 2);
				Scene v = SceneManager.CreateScene(sceneName, parameters);
				ToLua.PushValue(L, v);
				return 1;
			}
			default:
				return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.SceneManagement.SceneManager.CreateScene");
			}
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MergeScenes(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			Scene sourceScene = StackTraits<Scene>.Check(L, 1);
			Scene destinationScene = StackTraits<Scene>.Check(L, 2);
			SceneManager.MergeScenes(sourceScene, destinationScene);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int MoveGameObjectToScene(IntPtr L)
	{
		try
		{
			ToLua.CheckArgsCount(L, 2);
			GameObject go = (GameObject)ToLua.CheckObject(L, 1, typeof(GameObject));
			Scene scene = StackTraits<Scene>.Check(L, 2);
			SceneManager.MoveGameObjectToScene(go, scene);
			return 0;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadScene(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				SceneManager.LoadScene((int)LuaDLL.lua_tonumber(L, 1));
				return 0;
			}
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				SceneManager.LoadScene(ToLua.ToString(L, 1));
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, LoadSceneParameters>(L, 1))
			{
				int sceneBuildIndex = (int)LuaDLL.lua_tonumber(L, 1);
				LoadSceneParameters parameters = StackTraits<LoadSceneParameters>.To(L, 2);
				Scene v = SceneManager.LoadScene(sceneBuildIndex, parameters);
				ToLua.PushValue(L, v);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, LoadSceneMode>(L, 1))
			{
				int sceneBuildIndex2 = (int)LuaDLL.lua_tonumber(L, 1);
				LoadSceneMode mode = (LoadSceneMode)ToLua.ToObject(L, 2);
				SceneManager.LoadScene(sceneBuildIndex2, mode);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, LoadSceneMode>(L, 1))
			{
				string sceneName = ToLua.ToString(L, 1);
				LoadSceneMode mode2 = (LoadSceneMode)ToLua.ToObject(L, 2);
				SceneManager.LoadScene(sceneName, mode2);
				return 0;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, LoadSceneParameters>(L, 1))
			{
				string sceneName2 = ToLua.ToString(L, 1);
				LoadSceneParameters parameters2 = StackTraits<LoadSceneParameters>.To(L, 2);
				Scene v2 = SceneManager.LoadScene(sceneName2, parameters2);
				ToLua.PushValue(L, v2);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.SceneManagement.SceneManager.LoadScene");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LoadSceneAsync(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				AsyncOperation o = SceneManager.LoadSceneAsync(ToLua.ToString(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				AsyncOperation o2 = SceneManager.LoadSceneAsync((int)LuaDLL.lua_tonumber(L, 1));
				ToLua.PushObject(L, o2);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, LoadSceneParameters>(L, 1))
			{
				string sceneName = ToLua.ToString(L, 1);
				LoadSceneParameters parameters = StackTraits<LoadSceneParameters>.To(L, 2);
				AsyncOperation o3 = SceneManager.LoadSceneAsync(sceneName, parameters);
				ToLua.PushObject(L, o3);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<string, LoadSceneMode>(L, 1))
			{
				string sceneName2 = ToLua.ToString(L, 1);
				LoadSceneMode mode = (LoadSceneMode)ToLua.ToObject(L, 2);
				AsyncOperation o4 = SceneManager.LoadSceneAsync(sceneName2, mode);
				ToLua.PushObject(L, o4);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, LoadSceneMode>(L, 1))
			{
				int sceneBuildIndex = (int)LuaDLL.lua_tonumber(L, 1);
				LoadSceneMode mode2 = (LoadSceneMode)ToLua.ToObject(L, 2);
				AsyncOperation o5 = SceneManager.LoadSceneAsync(sceneBuildIndex, mode2);
				ToLua.PushObject(L, o5);
				return 1;
			}
			if (num == 2 && TypeChecker.CheckTypes<int, LoadSceneParameters>(L, 1))
			{
				int sceneBuildIndex2 = (int)LuaDLL.lua_tonumber(L, 1);
				LoadSceneParameters parameters2 = StackTraits<LoadSceneParameters>.To(L, 2);
				AsyncOperation o6 = SceneManager.LoadSceneAsync(sceneBuildIndex2, parameters2);
				ToLua.PushObject(L, o6);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.SceneManagement.SceneManager.LoadSceneAsync");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int UnloadSceneAsync(IntPtr L)
	{
		try
		{
			int num = LuaDLL.lua_gettop(L);
			if (num == 1 && TypeChecker.CheckTypes<Scene>(L, 1))
			{
				AsyncOperation o = SceneManager.UnloadSceneAsync(StackTraits<Scene>.To(L, 1));
				ToLua.PushObject(L, o);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<string>(L, 1))
			{
				AsyncOperation o2 = SceneManager.UnloadSceneAsync(ToLua.ToString(L, 1));
				ToLua.PushObject(L, o2);
				return 1;
			}
			if (num == 1 && TypeChecker.CheckTypes<int>(L, 1))
			{
				AsyncOperation o3 = SceneManager.UnloadSceneAsync((int)LuaDLL.lua_tonumber(L, 1));
				ToLua.PushObject(L, o3);
				return 1;
			}
			return LuaDLL.luaL_throw(L, "invalid arguments to method: UnityEngine.SceneManagement.SceneManager.UnloadSceneAsync");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sceneCount(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SceneManager.sceneCount);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sceneCountInBuildSettings(IntPtr L)
	{
		try
		{
			LuaDLL.lua_pushinteger(L, SceneManager.sceneCountInBuildSettings);
			return 1;
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sceneLoaded(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(UnityAction<Scene, LoadSceneMode>)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_sceneUnloaded(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(UnityAction<Scene>)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int get_activeSceneChanged(IntPtr L)
	{
		ToLua.Push(L, new EventObject(typeof(UnityAction<Scene, Scene>)));
		return 1;
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sceneLoaded(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					SceneManager.sceneLoaded += (UnityAction<Scene, LoadSceneMode>)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					SceneManager.sceneLoaded -= (UnityAction<Scene, LoadSceneMode>)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.SceneManagement.SceneManager.sceneLoaded' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.SceneManagement.SceneManager'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_sceneUnloaded(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					SceneManager.sceneUnloaded += (UnityAction<Scene>)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					SceneManager.sceneUnloaded -= (UnityAction<Scene>)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.SceneManagement.SceneManager.sceneUnloaded' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.SceneManagement.SceneManager'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int set_activeSceneChanged(IntPtr L)
	{
		try
		{
			EventObject eventObject = null;
			if (LuaDLL.lua_isuserdata(L, 2) != 0)
			{
				eventObject = (EventObject)ToLua.ToObject(L, 2);
				if (eventObject.op == EventOp.Add)
				{
					SceneManager.activeSceneChanged += (UnityAction<Scene, Scene>)eventObject.func;
				}
				else if (eventObject.op == EventOp.Sub)
				{
					SceneManager.activeSceneChanged -= (UnityAction<Scene, Scene>)eventObject.func;
				}
				return 0;
			}
			return LuaDLL.luaL_throw(L, "The event 'UnityEngine.SceneManagement.SceneManager.activeSceneChanged' can only appear on the left hand side of += or -= when used outside of the type 'UnityEngine.SceneManagement.SceneManager'");
		}
		catch (Exception e)
		{
			return LuaDLL.toluaL_exception(L, e);
		}
	}
}
