#define ENABLE_FATAL_AND_ABOVE_LOG
#define ENABLE_INFO_AND_ABOVE_LOG
#define ENABLE_WARNING_AND_ABOVE_LOG
using System;
using System.IO;
using Cysharp.Threading.Tasks;
using GameFramework.Localization;
using GameFramework.Resource;
using I2.Loc;
using UnityEngine;

namespace GameFramework.Runtime;

[DisallowMultipleComponent]
[AddComponentMenu("Game Framework/Localization")]
public sealed class LocalizationComponent : GameFrameworkComponent
{
	private const int DefaultPriority = 0;

	private ILocalizationManager m_LocalizationManager = null;

	[SerializeField]
	private string m_GlobalSourcePath;

	[SerializeField]
	private LanguageSource m_GlobalSource = null;

	[SerializeField]
	private LocalizationParamsManager m_LocalizationParamsManager = null;

	[SerializeField]
	private string m_LocalizationHelperTypeName = "UnityGameFramework.Runtime.DefaultLocalizationHelper";

	[SerializeField]
	private ILocalizationHelper m_CustomLocalizationHelper = null;

	private ResourceComponent resourceComponent;

	public Language Language
	{
		get
		{
			return m_LocalizationManager.Language;
		}
		set
		{
			m_LocalizationManager.Language = value;
		}
	}

	public Language SystemLanguage => m_LocalizationManager.SystemLanguage;

	public LanguageSource LanguageSource => m_GlobalSource;

	protected override void Awake()
	{
		base.Awake();
		m_LocalizationManager = GameFrameworkEntry.GetModule<ILocalizationManager>();
		if (m_LocalizationManager == null)
		{
			Log.Fatal("Localization manager is invalid.");
		}
	}

	public override void Init()
	{
		BaseComponent component = GameEntryRuntime.GetComponent<BaseComponent>();
		if (component == null)
		{
			Log.Fatal("Base component is invalid.");
			return;
		}
		resourceComponent = GameEntryRuntime.GetComponent<ResourceComponent>();
		m_LocalizationManager.SetResourceManager(GameFrameworkEntry.GetModule<IResourceManager>());
		Type type = Utility.Assembly.GetType(m_LocalizationHelperTypeName);
		if (type == null)
		{
			Log.Error("Can not find Localization helper type '{0}'.", m_LocalizationHelperTypeName);
			return;
		}
		m_CustomLocalizationHelper = (ILocalizationHelper)Activator.CreateInstance(type);
		if (m_CustomLocalizationHelper == null)
		{
			Log.Error("Can not create Localization helper instance '{0}'.", m_LocalizationHelperTypeName);
			return;
		}
		m_CustomLocalizationHelper.Init();
		m_LocalizationManager.SetLocalizationHelper(m_CustomLocalizationHelper);
	}

	public async UniTask UpdateGlobalSource()
	{
		TextAsset source = await resourceComponent.LoadAssetAsync<TextAsset>(AssetUtility.GetLanguageAsset("GlobalLocalization"));
		m_GlobalSource.SourceData.Import_CSV(string.Empty, source.text, (eSpreadsheetUpdateMode)1, ',');
		LocalizationManager.LocalizeAll(false);
	}

	public void ReplaceLanguageSourceData()
	{
		string combinePath = Utility.Path.GetCombinePath(Application.dataPath, m_GlobalSourcePath);
		string text = File.ReadAllText(combinePath);
		if (string.IsNullOrEmpty(text))
		{
			Debug.Log("读取资源文件出错.");
			return;
		}
		m_GlobalSource.SourceData.Import_CSV(string.Empty, text, (eSpreadsheetUpdateMode)1, ',');
		LocalizationManager.LocalizeAll(false);
		Debug.Log("语言源更新完成.");
	}

	public string GetString(string key)
	{
		return m_LocalizationManager.GetString(key);
	}

	public string GetString(string key, object arg0)
	{
		return m_LocalizationManager.GetString(key, arg0);
	}

	public string GetString(string key, object arg0, object arg1)
	{
		return m_LocalizationManager.GetString(key, arg0, arg1);
	}

	public string GetString(string key, object arg0, object arg1, object arg2)
	{
		return m_LocalizationManager.GetString(key, arg0, arg1, arg2);
	}

	public string GetString(string key, params object[] args)
	{
		return m_LocalizationManager.GetString(key, args);
	}

	public bool AddGlobalParam(string key, string value)
	{
		if ((UnityEngine.Object)(object)m_LocalizationParamsManager == null)
		{
			Log.Warning("没有找到本地化参数管理器.");
			return false;
		}
		m_LocalizationParamsManager.SetParameterValue(key, value, true);
		return true;
	}

	public string GetGlobalParam(string key)
	{
		if ((UnityEngine.Object)(object)m_LocalizationParamsManager == null)
		{
			Log.Warning("没有找到本地化参数管理器.");
			return string.Empty;
		}
		return m_LocalizationParamsManager.GetParameterValue(key);
	}
}
