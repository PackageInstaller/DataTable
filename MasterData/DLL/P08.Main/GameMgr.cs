using System;
using System.IO;
using LuaInterface;
using P08.Gamepad;
using UnityEngine;

public class GameMgr : MonoBehaviour
{
	public static GameMgr _inst;

	private static UnityEngine.Object _lock = new UnityEngine.Object();

	public static void Init()
	{
		if (!(_inst == null))
		{
			return;
		}
		lock (_lock)
		{
			_inst = UnityEngine.Object.FindObjectOfType(typeof(GameMgr)) as GameMgr;
			if (_inst == null)
			{
				GameInit();
			}
		}
	}

	private static void GameInit()
	{
		GameObject gameObject = new GameObject("GameManager");
		_inst = gameObject.AddComponent<GameMgr>();
		if (Application.isPlaying)
		{
			UnityEngine.Object.DontDestroyOnLoad(gameObject);
		}
		Debugger.useLog = true;
		PathManager.inst.Init();
		gameObject.AddComponent<BulletinBoardMgr>();
		NScene.RegSceneName<BattleScene>("BattleScene");
		NScene.RegSceneName<MainScene>("MainScene");
		Debugger.Log("use lua bundle");
		string arch = "";
		arch = ((IntPtr.Size == 4) ? "x86" : "x64");
		LuaFileUtils.Instance.useBundle = true;
		LuaFileUtils.Instance.bundleLoader = delegate(string filename)
		{
			if (GameToSDK.CURRENT_SDK_ID == 0)
			{
				string text = Path.Combine(Application.persistentDataPath, Path.GetFileName(filename) + ".lua");
				if (File.Exists(text))
				{
					Debug.Log("load local lua file : " + text);
					return File.ReadAllBytes(text);
				}
			}
			string text2 = null;
			switch (Application.platform)
			{
			case RuntimePlatform.WindowsPlayer:
			case RuntimePlatform.WindowsEditor:
			case RuntimePlatform.Android:
				text2 = "assets/luabuilds/luajit2.0/" + arch + "/";
				break;
			case RuntimePlatform.IPhonePlayer:
				text2 = "assets/luabuilds/luajit2.1/" + arch + "/";
				break;
			case RuntimePlatform.OSXEditor:
			case RuntimePlatform.OSXPlayer:
				text2 = "assets/luabuilds/luavm/" + arch + "/";
				break;
			default:
				throw new Exception("Do not support this platform.");
			}
			text2 += filename.Replace(".lua", "").Replace(".", "/").ToLower(StringTools.sCultureInfo);
			text2 += ".lua.bytes";
			TextAsset textAsset = AssetManager.Load<TextAsset>(PathManager.inst.GetLuaBundle(), text2);
			if (textAsset == null)
			{
				Debugger.LogWarning("could not found: " + text2 + " at bundle.");
			}
			if (textAsset != null)
			{
				byte[] bytes = textAsset.bytes;
				Resources.UnloadAsset(textAsset);
				return bytes;
			}
			return (byte[])null;
		};
		gameObject.AddComponent<LuaClient>();
		_inst.RegisterExitHandler();
		_inst.CheckReporter();
	}

	private void RegisterExitHandler()
	{
		InputAction inputAction = InputManager.system?.GetPageInputActionMap("Global")?.GetInputAction("Back");
		if (inputAction == null)
		{
			Debug.LogError("could not get Global->Back InputAction!");
			return;
		}
		inputAction.performed += delegate
		{
			OnExitInput();
		};
	}

	private void OnExitInput()
	{
		LuaHelper.CallFunction("OnExitInput");
	}

	private void CheckReporter()
	{
		string[] lst = new string[6] { "aud", "dev", "qa_pat", "qa_rel", "spe", "pre" };
		if (GameToSDK.CURRENT_SDK_ID == 0 || lst.contains(GameToSDK.clientInfo.env))
		{
			Debug.Log("Init Reporter");
			GameObject obj = new GameObject("Reporter");
			obj.AddComponent<ReporterListener>();
			UnityEngine.Object.DontDestroyOnLoad(obj);
		}
	}
}
