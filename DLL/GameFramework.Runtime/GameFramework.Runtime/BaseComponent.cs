#define ENABLE_INFO_AND_ABOVE_LOG
using System;
using GameFramework.Localization;
using UnityEngine;

namespace GameFramework.Runtime;

[DisallowMultipleComponent]
[AddComponentMenu("Game Framework/Base")]
public sealed class BaseComponent : GameFrameworkComponent
{
	private const int DefaultDpi = 96;

	[SerializeField]
	private bool m_EditorResourceMode = true;

	[SerializeField]
	private Language m_EditorLanguage = Language.Unspecified;

	private float m_GameSpeedBeforePause = 1f;

	[SerializeField]
	private string m_TextHelperTypeName = "UnityGameFramework.Runtime.DefaultTextHelper";

	[SerializeField]
	private string m_VersionHelperTypeName = "UnityGameFramework.Runtime.DefaultVersionHelper";

	[SerializeField]
	private string m_LogHelperTypeName = "UnityGameFramework.Runtime.DefaultLogHelper";

	[SerializeField]
	private string m_CompressionHelperTypeName = "UnityGameFramework.Runtime.DefaultCompressionHelper";

	[SerializeField]
	private string m_JsonHelperTypeName = "UnityGameFramework.Runtime.DefaultJsonHelper";

	[SerializeField]
	private int m_FrameRate = 30;

	[SerializeField]
	private float m_GameSpeed = 1f;

	[SerializeField]
	private bool m_RunInBackground = true;

	[SerializeField]
	private bool m_NeverSleep = true;

	private GameConfig gameconfig;

	private ApplicationContext context;

	public bool EditorResourceMode
	{
		get
		{
			return m_EditorResourceMode;
		}
		set
		{
			m_EditorResourceMode = value;
		}
	}

	public Language EditorLanguage
	{
		get
		{
			return m_EditorLanguage;
		}
		set
		{
			m_EditorLanguage = value;
		}
	}

	public int FrameRate
	{
		get
		{
			return m_FrameRate;
		}
		set
		{
			Application.targetFrameRate = (m_FrameRate = value);
		}
	}

	public float GameSpeed
	{
		get
		{
			return m_GameSpeed;
		}
		set
		{
			Time.timeScale = (m_GameSpeed = ((value >= 0f) ? value : 0f));
		}
	}

	public bool IsGamePaused => m_GameSpeed <= 0f;

	public bool IsNormalGameSpeed => m_GameSpeed == 1f;

	public bool RunInBackground
	{
		get
		{
			return m_RunInBackground;
		}
		set
		{
			Application.runInBackground = (m_RunInBackground = value);
		}
	}

	public bool NeverSleep
	{
		get
		{
			return m_NeverSleep;
		}
		set
		{
			m_NeverSleep = value;
			Screen.sleepTimeout = (value ? (-1) : (-2));
		}
	}

	public GameConfig GameConfig
	{
		get
		{
			return gameconfig;
		}
		set
		{
			gameconfig = value;
		}
	}

	public ApplicationContext ApplicationContext => context;

	public IServiceContainer ApplicationServiceContainer => context.GetContainer();

	protected override void Awake()
	{
		base.Awake();
		InitTextHelper();
		InitLogHelper();
		InitCompressionHelper();
		InitJsonHelper();
		Utility.Converter.ScreenDpi = Screen.dpi;
		if (Utility.Converter.ScreenDpi <= 0f)
		{
			Utility.Converter.ScreenDpi = 96f;
		}
		Application.targetFrameRate = m_FrameRate;
		Time.timeScale = m_GameSpeed;
		Application.runInBackground = m_RunInBackground;
		Screen.sleepTimeout = (m_NeverSleep ? (-1) : (-2));
		context = Context.GetApplicationContext();
		Application.lowMemory += OnLowMemory;
	}

	private void Start()
	{
	}

	private void Update()
	{
		GameFrameworkEntry.Update(Time.deltaTime, Time.unscaledDeltaTime);
	}

	private void OnApplicationQuit()
	{
		Application.lowMemory -= OnLowMemory;
		StopAllCoroutines();
	}

	private void OnDestroy()
	{
		GameFrameworkEntry.Shutdown();
	}

	public void PauseGame()
	{
		if (!IsGamePaused)
		{
			m_GameSpeedBeforePause = GameSpeed;
			GameSpeed = 0f;
		}
	}

	public void ResumeGame()
	{
		if (IsGamePaused)
		{
			GameSpeed = m_GameSpeedBeforePause;
		}
	}

	public void ResetNormalGameSpeed()
	{
		if (!IsNormalGameSpeed)
		{
			GameSpeed = 1f;
		}
	}

	public override void Shutdown()
	{
		UnityEngine.Object.Destroy(base.gameObject);
	}

	private void InitTextHelper()
	{
		if (string.IsNullOrEmpty(m_TextHelperTypeName))
		{
			return;
		}
		Type type = Utility.Assembly.GetType(m_TextHelperTypeName);
		if (type == null)
		{
			Log.Error("Can not find text helper type '{0}'.", m_TextHelperTypeName);
			return;
		}
		Utility.Text.ITextHelper textHelper = (Utility.Text.ITextHelper)Activator.CreateInstance(type);
		if (textHelper == null)
		{
			Log.Error("Can not create text helper instance '{0}'.", m_TextHelperTypeName);
		}
		else
		{
			Utility.Text.SetTextHelper(textHelper);
		}
	}

	private void InitLogHelper()
	{
		if (!string.IsNullOrEmpty(m_LogHelperTypeName))
		{
			Type type = Utility.Assembly.GetType(m_LogHelperTypeName);
			if (type == null)
			{
				throw new GameFrameworkException(Utility.Text.Format("Can not find log helper type '{0}'.", m_LogHelperTypeName));
			}
			GameFrameworkLog.ILogHelper logHelper = (GameFrameworkLog.ILogHelper)Activator.CreateInstance(type);
			if (logHelper == null)
			{
				throw new GameFrameworkException(Utility.Text.Format("Can not create log helper instance '{0}'.", m_LogHelperTypeName));
			}
			GameFrameworkLog.SetLogHelper(logHelper);
		}
	}

	private void InitCompressionHelper()
	{
		if (string.IsNullOrEmpty(m_CompressionHelperTypeName))
		{
			return;
		}
		Type type = Utility.Assembly.GetType(m_CompressionHelperTypeName);
		if (type == null)
		{
			Log.Error("Can not find compression helper type '{0}'.", m_CompressionHelperTypeName);
			return;
		}
		Utility.Compression.ICompressionHelper compressionHelper = (Utility.Compression.ICompressionHelper)Activator.CreateInstance(type);
		if (compressionHelper == null)
		{
			Log.Error("Can not create compression helper instance '{0}'.", m_CompressionHelperTypeName);
		}
		else
		{
			Utility.Compression.SetCompressionHelper(compressionHelper);
		}
	}

	private void InitJsonHelper()
	{
		if (string.IsNullOrEmpty(m_JsonHelperTypeName))
		{
			return;
		}
		Type type = Utility.Assembly.GetType(m_JsonHelperTypeName);
		if (type == null)
		{
			Log.Error("Can not find JSON helper type '{0}'.", m_JsonHelperTypeName);
			return;
		}
		Utility.Json.IJsonHelper jsonHelper = (Utility.Json.IJsonHelper)Activator.CreateInstance(type);
		if (jsonHelper == null)
		{
			Log.Error("Can not create JSON helper instance '{0}'.", m_JsonHelperTypeName);
		}
		else
		{
			Utility.Json.SetJsonHelper(jsonHelper);
		}
	}

	private void OnLowMemory()
	{
		ResourceComponent component = GameEntryRuntime.GetComponent<ResourceComponent>();
		if (component != null)
		{
			component.ForceUnloadUnusedAssets(performGCCollect: true);
		}
	}
}
