using UnityEngine;

namespace Ase;

public class BuglyHandler : MonoBehaviour
{
	private const string pluginName = "com.kiif.bugly.MyPlugin";

	private static BuglyHandler _instance;

	private const string BuglyAppId = "8a3c96acdd";

	private const string BuglyAppKey = "7759ac9f-a799-4de0-a6f5-6665ad1f2f80";

	private bool isOpenBugly = true;

	public static BuglyHandler Current
	{
		get
		{
			if (_instance == null)
			{
				Initialize();
			}
			return _instance;
		}
	}

	public static void Initialize()
	{
		if (_instance == null)
		{
			_instance = new GameObject("BuglyHandler").AddComponent<BuglyHandler>();
			_instance.Init();
			Object.DontDestroyOnLoad(_instance);
		}
	}

	private void Init()
	{
		BuglyAgent.DebugLog("BuglyHandler.Init()", "Screen: {0} x {1}", Screen.width, Screen.height);
		BuglyAgent.InitWithAppId("8a3c96acdd", "7759ac9f-a799-4de0-a6f5-6665ad1f2f80");
		BuglyAgent.EnableExceptionHandler();
	}
}
