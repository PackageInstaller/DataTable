using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Rendering;

namespace Ase;

public class GameEntry : MonoBehaviour
{
	public static Constant.LaunchType LaunchType;

	public static BaseComponent Base { get; private set; }

	public static ResourceComponent Resource { get; private set; }

	public static DataTableComponent DataTable { get; private set; }

	public static UIComponent UI { get; private set; }

	public static NetworkComponent Network { get; private set; }

	public static ObjectPoolComponent Pool { get; private set; }

	public static SoundComponent Sound { get; private set; }

	public static LocalizationComponent Localization { get; private set; }

	public static SceneComponent Scene { get; private set; }

	public static SettingComponent Setting { get; private set; }

	public static BindingComponent Binding { get; private set; }

	public static WebRequestComponent WebRequest { get; private set; }

	public static BuiltinDataComponent BuiltinData { get; private set; }

	public static CameraComponent Camera { get; private set; }

	public static CanvasComponent Canvas { get; private set; }

	public static AudioComponent Audio { get; private set; }

	public static UniWebComponent Web { get; private set; }

	private static void InitBuiltinComponents()
	{
		Base = GameEntryRuntime.GetComponent<BaseComponent>();
		Resource = GameEntryRuntime.GetComponent<ResourceComponent>();
		DataTable = GameEntryRuntime.GetComponent<DataTableComponent>();
		Localization = GameEntryRuntime.GetComponent<LocalizationComponent>();
		Network = GameEntryRuntime.GetComponent<NetworkComponent>();
		UI = GameEntryRuntime.GetComponent<UIComponent>();
		Pool = GameEntryRuntime.GetComponent<ObjectPoolComponent>();
		Scene = GameEntryRuntime.GetComponent<SceneComponent>();
		Setting = GameEntryRuntime.GetComponent<SettingComponent>();
		Binding = GameEntryRuntime.GetComponent<BindingComponent>();
		WebRequest = GameEntryRuntime.GetComponent<WebRequestComponent>();
		Base.Init();
		Resource.Init();
		DataTable.Init();
		Localization.Init();
		Network.Init();
		UI.Init();
		Pool.Init();
		Scene.Init();
		Setting.Init();
		Binding.Init();
		WebRequest.Init();
	}

	private void Start()
	{
		RuntimePlatform platform = Application.platform;
		if (platform == RuntimePlatform.Android || platform == RuntimePlatform.IPhonePlayer)
		{
			Resolution currentResolution = Screen.currentResolution;
			int num = Mathf.Min(1920, currentResolution.width);
			float num2 = (float)num * 1f / (float)currentResolution.width;
			Screen.SetResolution(num, (int)((float)currentResolution.height * num2), fullscreen: true, 60);
		}
		InitBuiltinComponents();
		InitCustomComponents();
		InitSDKCallback();
		Init();
		OpenStartForm();
	}

	private void Init()
	{
		DebugManager.instance.enableRuntimeUI = false;
		BuiltinData.InitBuildInfo();
		BuiltinData.InitCurrentVariant();
		BuiltinData.InitQualitySettings();
		BuiltinData.InitLanguageSettings();
		BuiltinData.InitDefaultDictionary();
		InitService();
	}

	private async void InitService()
	{
		Context.GetApplicationContext().GetContainer().Register((IMessenger)new Messenger());
		UI.AddUIGroup("DEFAULT");
		UI.AddUIGroup("LEVELlLOADBLACKSCREENGROUP");
		UI.AddUIGroup("POPUP");
		UI.AddUIGroup("GUIDE");
		UI.AddUIGroup("TIMELINE");
		UI.AddUIGroup("LOADING");
		UI.AddUIGroup("Tip");
		UI.AddUIGroup("Top");
	}

	private void InitSDKCallback()
	{
		GameObject obj = new GameObject("PerSDKCallback");
		Object.DontDestroyOnLoad(obj);
		obj.AddComponent<PerCallBack>();
	}

	private async Task OpenStartForm()
	{
		await UniTask.WaitUntil(() => KiifInterface._IsAgreePermission == "1");
		if (LaunchType == Constant.LaunchType.RepairRes)
		{
			UI.OpenResWindow("SplashWindow");
			return;
		}
		BuglyHandler.Initialize();
		UI.OpenResWindow("SplashWindow");
	}

	private void Update()
	{
		Game.Update();
	}

	private void FixedUpdate()
	{
		Game.FixedUpdate();
	}

	private void LateUpdate()
	{
		Game.LateUpdate();
	}

	private void OnDrawGizmos()
	{
		Game.OnDrawGizmos();
	}

	private void OnApplicationQuit()
	{
		Game.Close();
	}

	private void OnDestroy()
	{
		Context.GetApplicationContext().GetContainer().Unregister<IMessenger>();
		Game.Close();
	}

	public static void Restart()
	{
		KiifInterface.Instance.ExitGame();
	}

	private static void InitCustomComponents()
	{
		BuiltinData = GameEntryRuntime.GetComponent<BuiltinDataComponent>();
		Camera = GameEntryRuntime.GetComponent<CameraComponent>();
		Canvas = GameEntryRuntime.GetComponent<CanvasComponent>();
		Audio = GameEntryRuntime.GetComponent<AudioComponent>();
		Web = GameEntryRuntime.GetComponent<UniWebComponent>();
		BuiltinData?.Init();
		Camera?.Init();
		Canvas?.Init();
		Audio?.Init();
		Web?.Init();
	}
}
