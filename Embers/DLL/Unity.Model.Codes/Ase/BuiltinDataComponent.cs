#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Text;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Localization;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;

namespace Ase;

public class BuiltinDataComponent : GameFrameworkComponent
{
	[SerializeField]
	private TextAsset m_BuildInfoTextAsset;

	private BuildInfo m_BuildInfo;

	private string versionInfo;

	private bool preServiceStatus;

	private GameVersion gameVersion;

	private Dictionary<string, List<string>> activeResourceVersions;

	public string secret = "";

	public string versionCheckUrl = "";

	public string VersionInfo => versionInfo;

	public bool PreServiceStatus => preServiceStatus;

	public string AppVersion => m_BuildInfo.GameVersion;

	public string Channel
	{
		get
		{
			if (PreServiceStatus)
			{
				return m_BuildInfo.Channel + "_PRECEDE";
			}
			return m_BuildInfo.Channel;
		}
	}

	public long SubChannel => m_BuildInfo.SubChannel;

	public bool IsFirstResourceUpdate => PlayerPrefs.GetInt("FirstResourceUpdate", 0) == 1;

	public GameVersion GameVersion => gameVersion;

	public int DeviceTier => gameVersion.deviceTier;

	public string OssPath => gameVersion.cdn_url;

	public string OssPath_Fallback => gameVersion.cdn_url_fallback;

	public List<ServerInfo> ServerList => gameVersion.server_list;

	public string DeviceId => SystemInfo.deviceUniqueIdentifier;

	public bool LoginVideo => gameVersion.login_video;

	public string PlatformUrl => gameVersion.platform_url;

	public long LoginOpenTime => gameVersion.login_open_time;

	public string LoginOpenTip => gameVersion.login_open_tip;

	public bool OpenTestFlight => gameVersion.app_testflight;

	public Dictionary<string, List<string>> ActiveResourceVersions => activeResourceVersions;

	public void InitBuildInfo()
	{
		if (!(m_BuildInfoTextAsset == null) && !string.IsNullOrEmpty(m_BuildInfoTextAsset.text))
		{
			m_BuildInfo = Utility.Json.ToObject<BuildInfo>(m_BuildInfoTextAsset.text);
			if (m_BuildInfo != null)
			{
				versionInfo = GameEntry.Setting.GetString("版本信息", string.Format("v{0}({1} {2} {3} {4})", m_BuildInfo.GameVersion, m_BuildInfo.InternalResourceVersion, m_BuildInfo.InternalCodeVersion, m_BuildInfo.InternalDataTableVersion, m_BuildInfo.InternalParadoxVersion, m_BuildInfo.InternalStoryVersion, m_BuildInfo.InternalScenesVersion));
				preServiceStatus = GameEntry.Setting.GetBool("先行服资格", defaultValue: false);
			}
		}
	}

	public void InitDefaultDictionary()
	{
	}

	public void InitLanguageSettings()
	{
		if (GameEntry.Base.EditorResourceMode && GameEntry.Base.EditorLanguage != Language.Unspecified)
		{
			GameEntry.Localization.Language = GameEntry.Base.EditorLanguage;
			return;
		}
		Language language = GameEntry.Localization.Language;
		if (GameEntry.Setting.HasSetting("语言"))
		{
			try
			{
				language = (Language)GameEntry.Setting.GetInt("语言");
			}
			catch
			{
			}
		}
		if (language != Language.English && language != Language.ChineseSimplified)
		{
			language = Language.ChineseSimplified;
			GameEntry.Setting.SetInt("语言", (int)language);
			GameEntry.Setting.Save();
		}
		GameEntry.Localization.Language = language;
	}

	public void InitCurrentVariant()
	{
	}

	public void InitQualitySettings()
	{
	}

	public void InitSoundSettings()
	{
	}

	public void SaveVersionInfo()
	{
		versionInfo = $"v{gameVersion.app_version}({gameVersion.resource_version_internal} {gameVersion.code_version_internal} {gameVersion.dataTable_version_internal} {gameVersion.paradox_version_internal})";
		GameEntry.Setting.SetString("版本信息", versionInfo);
		GameEntry.Setting.Save();
	}

	public void RecordFirstResourceUpdaterStatus(int value)
	{
		PlayerPrefs.SetInt("FirstResourceUpdate", value);
	}

	public async UniTask<GameVersion> RequestVersion()
	{
		string platformPath = ResourcesExtension.GetPlatformPath(Application.platform);
		string channel = Channel;
		string deviceId = DeviceId;
		string text = ((int)DateTimeOffset.UtcNow.ToUnixTimeSeconds()).ToString();
		string signature = EncryptUtility.SHA256(platformPath + channel + text + deviceId + secret);
		string s = JsonConvert.SerializeObject(new
		{
			platform = platformPath,
			channel = channel,
			timestamp = text,
			deviceId = deviceId,
			deviceModel = SystemInfo.deviceModel.Split(" ")[1],
			signature = signature
		});
		byte[] bytes = Encoding.UTF8.GetBytes(s);
		(GameVersion, string) responseDataNoBom = (await GameEntry.WebRequest.AddWebRequest(versionCheckUrl, bytes, bodyDataSet: true, "Content-Type", "application/json")).GetResponseDataNoBom<GameVersion>();
		if (responseDataNoBom.Item1 == null)
		{
			Log.Error(responseDataNoBom.Item2);
			return null;
		}
		(gameVersion, _) = responseDataNoBom;
		if (gameVersion != null && !string.IsNullOrEmpty(gameVersion.active_resource_versions))
		{
			activeResourceVersions = Utility.Json.ToObject<Dictionary<string, List<string>>>(gameVersion.active_resource_versions);
		}
		return gameVersion;
	}

	public void SetPreServiceStatus(bool value)
	{
		if (preServiceStatus != value)
		{
			GameEntry.Setting.SetBool("先行服资格", value);
			GameEntry.Setting.Save();
			GameEntry.Restart();
		}
	}

	public override void Shutdown()
	{
	}
}
