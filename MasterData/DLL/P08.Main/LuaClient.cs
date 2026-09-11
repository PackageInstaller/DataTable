using System;
using System.IO;
using HybridCLR;
using LuaInterface;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LuaClient : MonoBehaviour, ILuaInterface
{
	protected LuaLooper loop;

	protected LuaFunction levelLoaded;

	protected bool openLuaSocket;

	protected bool beZbStart;

	private LuaTable profiler;

	public static LuaClient Instance { get; protected set; }

	[HideInInspector]
	public LuaState luaState { get; set; }

	protected virtual LuaFileUtils InitLoader()
	{
		return LuaFileUtils.Instance;
	}

	protected virtual void LoadLuaFiles()
	{
		OnLoadFinished();
	}

	protected virtual void OpenLibs()
	{
		luaState.OpenLibs(LuaDLL.luaopen_pb);
		luaState.OpenLibs(LuaDLL.luaopen_struct);
		luaState.OpenLibs(LuaDLL.luaopen_lpeg);
		if (LuaConst.openLuaSocket)
		{
			OpenLuaSocket();
		}
		if (LuaConst.openLuaDebugger)
		{
			OpenZbsDebugger();
		}
		RegistMyChange();
	}

	public void OpenZbsDebugger(string ip = "localhost")
	{
		if (!Directory.Exists(LuaConst.zbsDir))
		{
			Debugger.LogWarning("ZeroBraneStudio not install or LuaConst.zbsDir not right");
			return;
		}
		if (!LuaConst.openLuaSocket)
		{
			OpenLuaSocket();
		}
		if (!string.IsNullOrEmpty(LuaConst.zbsDir))
		{
			luaState.AddSearchPath(LuaConst.zbsDir);
		}
		luaState.LuaDoString($"DebugServerIp = '{ip}'", "@LuaClient.cs");
	}

	[ReversePInvokeWrapperGeneration(1000)]
	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_Socket_Core(IntPtr L)
	{
		return LuaDLL.luaopen_socket_core(L);
	}

	[MonoPInvokeCallback(typeof(LuaCSFunction))]
	private static int LuaOpen_Mime_Core(IntPtr L)
	{
		return LuaDLL.luaopen_mime_core(L);
	}

	protected void OpenLuaSocket()
	{
		LuaConst.openLuaSocket = true;
		luaState.BeginPreLoad();
		luaState.RegFunction("socket.core", LuaOpen_Socket_Core);
		luaState.RegFunction("mime.core", LuaOpen_Mime_Core);
		luaState.EndPreLoad();
	}

	protected void OpenCJson()
	{
		luaState.LuaGetField(LuaIndexes.LUA_REGISTRYINDEX, "_LOADED");
		luaState.OpenLibs(LuaDLL.luaopen_cjson);
		luaState.LuaSetField(-2, "cjson");
		luaState.OpenLibs(LuaDLL.luaopen_cjson_safe);
		luaState.LuaSetField(-2, "cjson.safe");
	}

	protected virtual void CallMain()
	{
	}

	protected virtual void StartMain()
	{
		luaState.DoFile("main.lua");
		levelLoaded = luaState.GetFunction("OnLevelWasLoaded");
		CallMain();
	}

	protected void StartLooper()
	{
		loop = base.gameObject.AddComponent<LuaLooper>();
		loop.luaState = luaState;
	}

	protected virtual void Bind()
	{
		LuaBinder.Bind(luaState);
		DelegateFactory.Init();
		LuaCoroutine.Register(luaState, this);
	}

	protected void Init()
	{
		InitLoader();
		luaState = new LuaState();
		OpenLibs();
		luaState.LuaSetTop(0);
		Bind();
		LoadLuaFiles();
	}

	protected void Awake()
	{
		Instance = this;
		Init();
		SceneManager.sceneLoaded += OnSceneLoaded;
	}

	protected virtual void OnLoadFinished()
	{
		luaState.Start();
		StartLooper();
		StartMain();
	}

	private void OnLevelLoaded(int level)
	{
		if (levelLoaded != null)
		{
			levelLoaded.BeginPCall();
			levelLoaded.Push(level);
			levelLoaded.PCall();
			levelLoaded.EndPCall();
		}
		if (luaState != null)
		{
			luaState.RefreshDelegateMap();
		}
	}

	private void OnSceneLoaded(Scene scene, LoadSceneMode mode)
	{
		OnLevelLoaded(scene.buildIndex);
	}

	public virtual void Destroy()
	{
		if (luaState != null)
		{
			SceneManager.sceneLoaded -= OnSceneLoaded;
			luaState.Call("OnApplicationQuit", beLogMiss: false);
			DetachProfiler();
			LuaState obj = luaState;
			luaState = null;
			if (levelLoaded != null)
			{
				levelLoaded.Dispose();
				levelLoaded = null;
			}
			if (loop != null)
			{
				loop.Destroy();
				loop = null;
			}
			obj.Dispose();
			Instance = null;
		}
	}

	protected void OnDestroy()
	{
		Destroy();
	}

	protected void OnApplicationQuit()
	{
		Destroy();
	}

	protected void OnApplicationFocus(bool hasFocus)
	{
		LuaHelper.CallFunction("OnApplicationFocus", hasFocus);
	}

	protected void OnApplicationPause(bool pauseStatus)
	{
		LuaHelper.CallFunction("OnApplicationPause", pauseStatus);
	}

	public static LuaState GetMainState()
	{
		return Instance.luaState;
	}

	public LuaLooper GetLooper()
	{
		return loop;
	}

	public void AttachProfiler()
	{
		if (profiler == null)
		{
			profiler = luaState.Require<LuaTable>("UnityEngine.Profiler");
			profiler.Call("start", profiler);
		}
	}

	public void DetachProfiler()
	{
		if (profiler != null)
		{
			profiler.Call("stop", profiler);
			profiler.Dispose();
			LuaProfiler.Clear();
		}
	}

	public void RegistMyChange()
	{
		OpenCJson();
		InitLuaState();
		BindLuaState(luaState);
	}

	public LuaState InitLuaState()
	{
		LuaHelper.SetLua(this);
		return luaState;
	}

	public void BindLuaState(LuaState luaState)
	{
		DelegateFactory.Init();
		DelegateFactoryEx.Register();
	}
}
