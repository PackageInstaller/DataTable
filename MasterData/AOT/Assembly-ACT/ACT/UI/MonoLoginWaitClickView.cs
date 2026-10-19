using System;
using System.Collections.Generic;
using System.IO;
using System.Text.RegularExpressions;
using ACT.Battle;
using ACT.Error;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.Local;
using ACT.LocalLoader;
using ACT.LocalizationExtension;
using ACT.Net;
using ACT.UI.AOT;
using ACT.Utility;
using AOT.WhiteListCheck;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using Newtonsoft.Json.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.Localization.Components;
using UnityEngine.SceneManagement;
using UnityEngine.Serialization;
using UnityEngine.UI;
using bamboosdk;
using bamboosdk.BamBooSdkJson;

namespace ACT.UI;

public class MonoLoginWaitClickView : BaseUIView<LoginWaitClickViewInputController>
{
	[SerializeField]
	public List<ServerConfig> m_ServerConfigs = new List<ServerConfig>
	{
		new ServerConfig
		{
			name = "test",
			loginUrl = "http://10.17.12.29:7001"
		},
		new ServerConfig
		{
			name = "dispatch",
			loginUrl = "http://10.17.10.45:7001"
		},
		new ServerConfig
		{
			name = "weekly",
			loginUrl = "http://10.17.50.106:10001"
		},
		new ServerConfig
		{
			name = "huyanglian",
			loginUrl = "http://10.17.10.137:2301"
		}
	};

	public GameObject tip;

	public GameObject toolKit;

	private const int LoginInputHistoryLimit = 10;

	private const string OpenIdHistoryPrefsKey = "openIdHistory";

	private const string UidHistoryPrefsKey = "uidHistory";

	public LocalizeTMP_Dropdown serverConfigSelect;

	public InputField openId;

	public CanvasLayerTMPDropdown openIdHistoryDropdown;

	public InputField Uid;

	public CanvasLayerTMPDropdown UidHistoryDropdown;

	public Button newId;

	public Button loginBtn;

	public Button loginBtnWithUid;

	public Button localBtn;

	public Button localSaveBtn;

	[FormerlySerializedAs("soundBtn")]
	public Button settingBtn;

	public UpdateMenuBtnState loginAccountBtn;

	public UpdateMenuBtnState noticeBtn;

	public UpdateMenuBtnState scanQRBtn;

	[FormerlySerializedAs("quit")]
	public UpdateMenuBtnState quitBtn;

	public UpdateMenuBtnState localGameBtn;

	public UpdateMenuBtnState noSDKBtn;

	public UpdateMenuBtnState uidBtn;

	public GameObject localGameWindow;

	public GameObject noSDKWindow;

	public GameObject uidWindow;

	public GameObject frontMask;

	[SerializeField]
	private GameObject ageNoticeWindow;

	[FormerlySerializedAs("massagePanel")]
	[SerializeField]
	private MonoMessageBox messagePanel;

	public AnnouncementViewAOT announcementPanel;

	public GameObject announcementRedDot;

	public ActButton clickIntoBtn;

	public GameObject[] hideRoot;

	public LocalizeStringEvent loginInText;

	private GameLoader m_GameLoad;

	private bool m_IsCustomize;

	public GameObject control;

	[SerializeField]
	private GameObject login;

	[SerializeField]
	private GameObject preDownload;

	[SerializeField]
	private Slider preDownloadProgress;

	[SerializeField]
	private TextMeshProUGUI preDownloadPercentText;

	[SerializeField]
	private TextMeshProUGUI preDownloadSpeedText;

	[SerializeField]
	private GameObject preDownloadEntry;

	[SerializeField]
	private GameObject preDownloadFinishedIndicator;

	[SerializeField]
	private ActButton preDownloadEntryButton;

	[SerializeField]
	private ActButton preDownloadPauseButton;

	[SerializeField]
	private ActButton openNoticeButton;

	private const string PreDownloadCompletedVersionPrefsKey = "PreDownload.CompletedVersion";

	private const string RequestNotificationModName = "reqxNotification";

	private const string IsShowNotificationLogoModName = "isShowNotificationLogo";

	private DownloadData _preDownloadData;

	private UnityEngine.SceneManagement.Scene _gamStart;

	private MonoHotUpdate _hotUpdate;

	private LocalAudioManager _localAudioManager;

	private AsyncOperation unloadSceneOperation;

	private static readonly Regex NameRex = new Regex("(.*)\\(([0-9]*)\\)");

	private bool m_IsConnecting;

	private InputDevice _currentDevice;

	private ServerConfig ServerConfigSelected => m_ServerConfigs[serverConfigSelect.value];

	public MonoMessageBox MessagePanel => messagePanel;

	private bool QRBtnOpen
	{
		get
		{
			if (!string.Equals(LuminBambooBridgeListener.UserInfo?.accountType, "Phone"))
			{
				return string.Equals(LuminBambooBridgeListener.UserInfo?.accountType, "Phone_Quick");
			}
			return true;
		}
	}

	protected override void PlayOpenAnimation()
	{
		uiEffectAnimator.Play("LoginShow");
	}

	protected override void PlayCloseAnimation()
	{
		uiEffectAnimator.Play("LoginHide");
	}

	private void Awake()
	{
		clickIntoBtn.SetBtnClick(ClickEnterGame);
	}

	protected override void OnUnityDestroy()
	{
		EndPreDownloadDisplay();
		base.OnUnityDestroy();
	}

	public void BeginPreDownloadDisplay(DownloadData downloadData)
	{
		EndPreDownloadDisplay();
		if (login != null)
		{
			login.SetActive(value: false);
		}
		if (preDownload != null)
		{
			preDownload.SetActive(value: true);
		}
		if (preDownloadProgress != null)
		{
			preDownloadProgress.value = 0f;
		}
		if (preDownloadPercentText != null)
		{
			preDownloadPercentText.text = "0%";
		}
		if (preDownloadSpeedText != null)
		{
			preDownloadSpeedText.text = string.Empty;
		}
		SetNotificationButtonVisible(isVisible: false);
		_preDownloadData = downloadData;
		if (_preDownloadData != null)
		{
			DownloadData preDownloadData = _preDownloadData;
			preDownloadData.StageProgressChanged = (Action<ProgressStageType, StageProgressData>)Delegate.Combine(preDownloadData.StageProgressChanged, new Action<ProgressStageType, StageProgressData>(OnPreDownloadStageProgressChanged));
			UpdatePreDownloadProgress(_preDownloadData.GetStageProgressData(_preDownloadData.CurrentStage));
			QueryNotificationButtonVisibility();
		}
	}

	public void EndPreDownloadDisplay()
	{
		if (_preDownloadData != null)
		{
			DownloadData preDownloadData = _preDownloadData;
			preDownloadData.StageProgressChanged = (Action<ProgressStageType, StageProgressData>)Delegate.Remove(preDownloadData.StageProgressChanged, new Action<ProgressStageType, StageProgressData>(OnPreDownloadStageProgressChanged));
			_preDownloadData = null;
		}
		if (preDownload != null)
		{
			preDownload.SetActive(value: false);
		}
		SetNotificationButtonVisible(isVisible: false);
		if (login != null)
		{
			login.SetActive(value: true);
		}
	}

	private void QueryNotificationButtonVisibility()
	{
		if (!IsAndroidPlatform())
		{
			return;
		}
		SetNotificationButtonVisible(isVisible: false);
		try
		{
			BamBooSdk.getInstance().getExtend("isShowNotificationLogo", "");
		}
		catch (Exception ex)
		{
			Debug.LogError("[MonoLoginWaitClickView] 查询通知权限按钮显示状态失败: " + ex.Message);
		}
	}

	private void RequestNotificationPermission()
	{
		if (!IsAndroidPlatform())
		{
			return;
		}
		try
		{
			BamBooSdk.getInstance().getExtend("reqxNotification", "");
		}
		catch (Exception ex)
		{
			Debug.LogError("[MonoLoginWaitClickView] 请求通知权限失败: " + ex.Message);
		}
	}

	internal void OnNotificationExtendSucceeded(string modName, string jsonRes)
	{
		if ((!(modName != "reqxNotification") || !(modName != "isShowNotificationLogo")) && _preDownloadData != null && !(preDownload == null) && preDownload.activeSelf)
		{
			if (!TryParseNotificationVisibility(jsonRes, out var isShow))
			{
				Debug.LogWarning("[MonoLoginWaitClickView] 通知权限 SDK 回调缺少有效的 isShow 字段: modName=" + modName + ", jsonRes=" + jsonRes);
			}
			else
			{
				SetNotificationButtonVisible(isShow);
			}
		}
	}

	private void SetNotificationButtonVisible(bool isVisible)
	{
		if (!(openNoticeButton == null))
		{
			openNoticeButton.gameObject.SetActive(isVisible);
		}
	}

	private static bool TryParseNotificationVisibility(string jsonRes, out bool isShow)
	{
		isShow = false;
		try
		{
			string text = JSONNode.Parse(jsonRes).get_Item("isShow")?.Value;
			if (int.TryParse(text, out var result))
			{
				isShow = result != 0;
				return true;
			}
			if (bool.TryParse(text, out var result2))
			{
				isShow = result2;
				return true;
			}
		}
		catch (Exception ex)
		{
			Debug.LogError("[MonoLoginWaitClickView] 解析通知权限 SDK 回调失败: " + ex.Message);
		}
		return false;
	}

	private static bool IsAndroidPlatform()
	{
		return Application.platform == RuntimePlatform.Android;
	}

	public void MarkPreDownloadCompleted()
	{
		if (TryGetPreDownloadVersionKey(out var versionKey))
		{
			PlayerPrefs.SetString("PreDownload.CompletedVersion", versionKey);
			PlayerPrefs.Save();
			RefreshPreDownloadEntry();
		}
	}

	private static bool IsPCPlatform()
	{
		RuntimePlatform platform = Application.platform;
		return platform == RuntimePlatform.WindowsPlayer || platform == RuntimePlatform.WindowsEditor;
	}

	private void RefreshPreDownloadEntry()
	{
		bool flag = TryGetPreDownloadVersionKey(out var versionKey);
		if (IsPCPlatform())
		{
			flag = false;
		}
		if (preDownloadEntry != null)
		{
			preDownloadEntry.SetActive(flag);
		}
		if (preDownloadFinishedIndicator != null)
		{
			bool active = flag && IsPreDownloadCompleted(versionKey);
			preDownloadFinishedIndicator.SetActive(active);
		}
	}

	private static bool IsPreDownloadCompleted(string versionKey)
	{
		if (string.IsNullOrEmpty(versionKey))
		{
			return false;
		}
		string stagedPreDownloadVersionKey = GameStart.GetStagedPreDownloadVersionKey();
		if (string.IsNullOrEmpty(stagedPreDownloadVersionKey) || GameStart.ComparePreDownloadVersionKeys(stagedPreDownloadVersionKey, versionKey) < 0)
		{
			return false;
		}
		string text = PlayerPrefs.GetString("PreDownload.CompletedVersion", string.Empty);
		if (!string.IsNullOrEmpty(text))
		{
			return GameStart.ComparePreDownloadVersionKeys(text, versionKey) >= 0;
		}
		return false;
	}

	private static bool TryGetPreDownloadVersionKey(out string versionKey)
	{
		versionKey = null;
		RemoteConfigPreDownload remoteConfigPreDownload = LuminApplication.RemoteConfig?.PreDownload;
		if (remoteConfigPreDownload == null || !remoteConfigPreDownload.HasAnyDiffZipInfos())
		{
			return false;
		}
		versionKey = $"a{remoteConfigPreDownload.AssetsVersion}_cs{remoteConfigPreDownload.ClientStaticVersion}_d{remoteConfigPreDownload.DllVersion}_r{remoteConfigPreDownload.RawFileVersion}";
		return true;
	}

	private void OpenPreDownloadPrompt()
	{
		if (!IsPCPlatform())
		{
			RemoteConfigPreDownload remoteConfigPreDownload = LuminApplication.RemoteConfig?.PreDownload;
			if (remoteConfigPreDownload != null && remoteConfigPreDownload.HasAnyDiffZipInfos())
			{
				long preDownloadTotalBytes = GetPreDownloadTotalBytes(remoteConfigPreDownload);
				bool isPreDownloadCompleted = TryGetPreDownloadVersionKey(out var versionKey) && IsPreDownloadCompleted(versionKey);
				string stagedPreDownloadVersionKey = GameStart.GetStagedPreDownloadVersionKey();
				long downloadedBytes = (string.IsNullOrEmpty(stagedPreDownloadVersionKey) ? 0 : Math.Min(preDownloadTotalBytes, GameStart.GetPreDownloadedBytes(stagedPreDownloadVersionKey)));
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPPREDOWNLOADPROMPT, new PopupPreDownloadPromptViewData
				{
					downloadedBytes = downloadedBytes,
					totalBytes = preDownloadTotalBytes,
					isPreDownloadCompleted = isPreDownloadCompleted
				}).Forget();
			}
		}
	}

	private void OpenPreDownloadPauseConfirmation()
	{
		if (PreDownloadAssetRunner.IsRunning)
		{
			if (Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_POPUPPREDOWNLOADPROMPT) is PopupPreDownloadPromptView popupPreDownloadPromptView)
			{
				popupPreDownloadPromptView.ShowPauseConfirmation(CancelPreDownloadAndReturnToLogin);
				return;
			}
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_POPUPPREDOWNLOADPROMPT, new PopupPreDownloadPromptViewData
			{
				showPauseConfirmation = true,
				onPauseConfirm = CancelPreDownloadAndReturnToLogin
			}).Forget();
		}
	}

	private void CancelPreDownloadAndReturnToLogin()
	{
		PreDownloadAssetRunner.CancelPreDownload();
	}

	private static long GetPreDownloadTotalBytes(RemoteConfigPreDownload preDownload)
	{
		return GetZipInfosSize(preDownload.DiffAssetInfos) + GetZipInfosSize(preDownload.DiffClientStaticInfos) + GetZipInfosSize(preDownload.DiffDllInfos) + GetZipInfosSize(preDownload.DiffRawFileInfos);
	}

	private static long GetZipInfosSize(ZipInfo[] zipInfos)
	{
		if (zipInfos == null)
		{
			return 0L;
		}
		long num = 0L;
		foreach (ZipInfo zipInfo in zipInfos)
		{
			if (zipInfo != null && long.TryParse(zipInfo.size, out var result))
			{
				num += Math.Max(0L, result);
			}
		}
		return num;
	}

	private void OnPreDownloadStageProgressChanged(ProgressStageType _, StageProgressData data)
	{
		UpdatePreDownloadProgress(data);
	}

	private void UpdatePreDownloadProgress(StageProgressData data)
	{
		if (data != null)
		{
			float num = Mathf.Clamp01(data.Percent);
			if (preDownloadProgress != null)
			{
				preDownloadProgress.value = num;
			}
			if (preDownloadPercentText != null)
			{
				preDownloadPercentText.text = $"{num * 100f:0}%";
			}
			if (preDownloadSpeedText != null)
			{
				preDownloadSpeedText.text = FormatDownloadDetail(data);
			}
		}
	}

	private static string FormatDownloadDetail(StageProgressData data)
	{
		if (data.TotalBytes <= 0)
		{
			return string.Empty;
		}
		string text = FormatByteSize(data.CurrentBytes) + "/" + FormatByteSize(data.TotalBytes);
		if (data.SpeedBytesPerSecond <= 0)
		{
			return text;
		}
		return text + "(" + FormatByteSize(data.SpeedBytesPerSecond) + "/s)";
	}

	private static string FormatByteSize(long byteSize)
	{
		float num = Mathf.Max(0f, byteSize);
		if (num < 1024f)
		{
			return num.ToString("0.#") + "B";
		}
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString("0.#") + "K";
		}
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString("0.#") + "M";
		}
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString("0.#") + "G";
		}
		return (num / 1024f).ToString("0.#") + "T";
	}

	internal async void OnLoginStateChanged(string propertyName, bool value)
	{
		if (!propertyName.Equals("IsLogin"))
		{
			return;
		}
		if (value && !(await WhiteListCheckUtil.CheckWhiteListFunc()))
		{
			MonoMessageBox.Message message = new MonoMessageBox.Message
			{
				btn1Text = "确认",
				btn1MiniText = "QUEREN",
				titleText = "",
				isShowSingle = true,
				callBack = () =>
				{
					if (!LuminBambooBridgeListener.TryLogoutAndQuitGameForWeGameAccountSwitch())
					{
						BamBooSdk.getInstance().logout(isShowWindow: false);
					}
				},
				content = "很抱歉，您的账号暂无测试资格\n敬请留意官方公告获取后续机会"
			};
			Singleton<NewUIManager>.instance.ShowMessage(message);
		}
		else
		{
			loginAccountBtn.isOpen = LuminBambooBridgeListener.Default.IsLogin;
			scanQRBtn.gameObject.SetActive(!LuminApplication.IsWeGameChannel && QRBtnOpen);
			if (LuminBambooBridgeListener.UserInfo != null)
			{
				Debug.Log(JObject.FromObject(LuminBambooBridgeListener.UserInfo));
			}
		}
	}

	internal void HandlePageStateChanged(string propertyName, bool value)
	{
		if (!propertyName.Equals("IsInAgreementPage") && !propertyName.Equals("IsInLoginPage"))
		{
			propertyName.Equals("IsInLogoutPage");
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		LoginUtility.ConnectFailAction = (Action)Delegate.Remove(LoginUtility.ConnectFailAction, new Action(OnConnectFail));
		if (GameStart.IsGameStart)
		{
			GameStart.IsGameStart = false;
		}
		else
		{
			AssetStationManager.RequestUnloadUnusedUnityAssets();
		}
		GameStart.ReleaseEnterGameSpin();
		if (_localAudioManager != null && _localAudioManager.enabled)
		{
			_localAudioManager.enabled = false;
		}
		Singleton<GameInputActionManager>.instance.SetGameInputState(GameInputState.Login, active: false);
	}

	protected override void Init()
	{
		base.Init();
		RefreshPreDownloadEntry();
		preDownloadEntryButton.SetBtnClick(OpenPreDownloadPrompt);
		preDownloadPauseButton.SetBtnClick(OpenPreDownloadPauseConfirmation);
		if (openNoticeButton != null)
		{
			openNoticeButton.SetBtnClick(RequestNotificationPermission);
			SetNotificationButtonVisible(isVisible: false);
		}
		try
		{
			LuminApplication.APM.AnalyserTag("GameStart_Start");
			LuminApplication.APM.AnalyserDump();
		}
		catch
		{
		}
		LuminApplication.APM.GPM.ChangeScene("GameStart");
		LoginUtility.ConnectFailAction = (Action)Delegate.Combine(LoginUtility.ConnectFailAction, new Action(OnConnectFail));
		m_GameLoad = UnityEngine.Object.FindObjectOfType<GameLoader>();
		_localAudioManager = UnityEngine.Object.FindObjectOfType<LocalAudioManager>(includeInactive: true);
		if (_localAudioManager != null && !_localAudioManager.enabled)
		{
			_localAudioManager.enabled = true;
		}
		frontMask.SetActive(value: false);
		HideWeGameAccountEntries();
		if (uiViewData == null || !(bool)uiViewData)
		{
			tip.SetActive(value: true);
			return;
		}
		quitBtn.gameObject.SetActive(!Application.isMobilePlatform);
		loginInText.StringReference.TableEntryReference = 41000014L;
		ChangeButtonShow();
		serverConfigSelect.ClearOptions();
		List<LocalizeTMP_Dropdown.OptionData> list = new List<LocalizeTMP_Dropdown.OptionData>();
		for (int i = 0; i < m_ServerConfigs.Count; i++)
		{
			list.Add(new LocalizeTMP_Dropdown.OptionData(m_ServerConfigs[i].name + "|" + m_ServerConfigs[i].loginUrl));
		}
		serverConfigSelect.AddOptions(list);
		openId.text = PlayerPrefs.GetString("openId");
		openId.onValueChanged.RemoveAllListeners();
		openId.onValueChanged.AddListener((string v) =>
		{
			PlayerPrefs.SetString("openId", v);
		});
		Uid.text = PlayerPrefs.GetString("uid");
		Uid.onValueChanged.RemoveAllListeners();
		Uid.onValueChanged.AddListener((string v) =>
		{
			PlayerPrefs.SetString("uid", v);
		});
		InitLoginInputHistory();
		newId.onClick.RemoveAllListeners();
		newId.onClick.AddListener(NewId);
		AddLoginBtnListener();
		localBtn.onClick.RemoveAllListeners();
		localBtn.onClick.AddListener(() =>
		{
			m_GameLoad.mode = GameLoader.GameMode.Local;
			LocalLoginSaveGame().Forget();
		});
		TryLoginBambooAccount();
		tip.SetActive(LuminBambooBridgeListener.Default.IsLogin);
		uiViewData = null;
		Singleton<NetManager>.CreateInstance();
		if (!File.Exists(Application.persistentDataPath + "/PlayerDatas.data"))
		{
			localSaveBtn.GetComponent<CanvasGroup>().alpha = 0.5f;
		}
		else
		{
			localSaveBtn.GetComponent<CanvasGroup>().alpha = 1f;
			localSaveBtn.onClick.RemoveAllListeners();
			localSaveBtn.onClick.AddListener(() =>
			{
				m_GameLoad.mode = GameLoader.GameMode.ConfigSave;
				LocalLogin().Forget();
			});
		}
		InitBtn();
		GameStart.LoadEnterGameSpin();
		if (GameStart.EnterGameSpinInstance != null)
		{
			GameStart.EnterGameSpinInstance.GetComponent<StratificationComponent>()?.InitializeSystem();
			Canvas component = GameStart.EnterGameSpinInstance.GetComponent<Canvas>();
			if (component != null)
			{
				component.renderMode = RenderMode.ScreenSpaceCamera;
				component.worldCamera = GameUtility.uiCamera;
			}
		}
		else
		{
			Debug.LogError("[MonoLoginWaitClickView] EnterGameSpine is unavailable while returning to the login screen.");
		}
		UpdateAnnouncementRedDot();
		Singleton<GameInputActionManager>.instance.SetGameInputState(GameInputState.Login, active: true);
	}

	private void AddLoginBtnListener()
	{
		loginBtn.onClick.RemoveAllListeners();
		loginBtnWithUid.onClick.RemoveAllListeners();
		loginBtn.onClick.AddListener(() =>
		{
			ExecuteLogin(openId.text, GameLoader.LoginSchema.Account);
		});
		loginBtnWithUid.onClick.AddListener(() =>
		{
			ExecuteLogin(Uid.text, GameLoader.LoginSchema.Uid);
		});
	}

	private void InitLoginInputHistory()
	{
		SetupLoginInputHistory(openId, openIdHistoryDropdown, "openIdHistory");
		SetupLoginInputHistory(Uid, UidHistoryDropdown, "uidHistory");
	}

	private void SetupLoginInputHistory(InputField inputField, TMP_Dropdown dropdown, string prefsKey)
	{
		if (!(inputField == null))
		{
			RefreshLoginInputHistoryDropdown(dropdown, prefsKey, inputField);
		}
	}

	private void RefreshLoginInputHistoryDropdown(TMP_Dropdown dropdown, string prefsKey, InputField targetInputField)
	{
		if (dropdown == null)
		{
			return;
		}
		dropdown.onValueChanged.RemoveAllListeners();
		dropdown.ClearOptions();
		List<string> loginInputHistory = GetLoginInputHistory(prefsKey);
		List<TMP_Dropdown.OptionData> list = new List<TMP_Dropdown.OptionData>();
		for (int i = 0; i < loginInputHistory.Count; i++)
		{
			list.Add(new TMP_Dropdown.OptionData(loginInputHistory[i]));
		}
		dropdown.AddOptions(list);
		dropdown.SetValueWithoutNotify(0);
		dropdown.RefreshShownValue();
		dropdown.onValueChanged.AddListener((int index) =>
		{
			List<string> loginInputHistory2 = GetLoginInputHistory(prefsKey);
			if (index >= 0 && index < loginInputHistory2.Count && !(targetInputField == null))
			{
				targetInputField.text = loginInputHistory2[index];
			}
		});
	}

	private void SaveLoginInputHistory(string prefsKey, string value, TMP_Dropdown dropdown)
	{
		value = value?.Trim();
		if (!string.IsNullOrEmpty(value))
		{
			List<string> loginInputHistory = GetLoginInputHistory(prefsKey);
			loginInputHistory.RemoveAll((string history) => string.Equals(history, value, StringComparison.Ordinal));
			loginInputHistory.Insert(0, value);
			if (loginInputHistory.Count > 10)
			{
				loginInputHistory.RemoveRange(10, loginInputHistory.Count - 10);
			}
			PlayerPrefs.SetString(prefsKey, string.Join("\n", loginInputHistory));
			RefreshLoginInputHistoryDropdown(dropdown, prefsKey, (prefsKey == "openIdHistory") ? openId : Uid);
		}
	}

	private List<string> GetLoginInputHistory(string prefsKey)
	{
		List<string> list = new List<string>();
		string text = PlayerPrefs.GetString(prefsKey);
		if (string.IsNullOrEmpty(text))
		{
			return list;
		}
		string[] array = text.Split(new char[1] { '\n' }, StringSplitOptions.RemoveEmptyEntries);
		for (int i = 0; i < array.Length; i++)
		{
			if (list.Count >= 10)
			{
				break;
			}
			string text2 = array[i].Trim();
			if (!string.IsNullOrEmpty(text2) && !list.Contains(text2))
			{
				list.Add(text2);
			}
		}
		return list;
	}

	internal void ExecuteLogin(string idStr, GameLoader.LoginSchema schema)
	{
		m_GameLoad.mode = GameLoader.GameMode.Network;
		switch (schema)
		{
		case GameLoader.LoginSchema.Account:
			LoginUtility.OpenId = idStr;
			SaveLoginInputHistory("openIdHistory", idStr, openIdHistoryDropdown);
			break;
		case GameLoader.LoginSchema.Uid:
			LoginUtility.AccountId = long.Parse(idStr);
			SaveLoginInputHistory("uidHistory", idStr, UidHistoryDropdown);
			break;
		}
		LoginUtility.LoginSchemaEnum = schema;
		ExecuteLogin(m_IsCustomize);
	}

	internal void ExecuteLogin(bool customize = false)
	{
		Login(customize).Forget();
	}

	protected override void AddEventListener()
	{
		base.AddEventListener();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnBambooSdkLogin, OnBambooLoginStateChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnBambooSdkLogout, OnBambooLoginStateChanged);
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnBambooSdkLogin, OnBambooLoginStateChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnBambooSdkLogout, OnBambooLoginStateChanged);
	}

	private void OnBambooLoginStateChanged(BaseEventContent obj)
	{
		tip.SetActive(LuminBambooBridgeListener.Default.IsLogin);
	}

	private void InitBtn()
	{
		settingBtn.onClick.AddListener(OnClickSettingBtn);
		noticeBtn.Init(ShowAnnouncement);
		bool flag = !LuminApplication.IsWeGameChannel;
		loginAccountBtn.gameObject.SetActive(flag);
		if (flag)
		{
			loginAccountBtn.Init(LoginOrOut, LuminBambooBridgeListener.Default.IsLogin);
		}
		quitBtn.Init(ExitGame);
		localGameBtn.Init(() =>
		{
			localGameWindow.SetActive(value: true);
		});
		noSDKBtn.Init(() =>
		{
			noSDKWindow.SetActive(value: true);
			SetCustomize(isCustomize: false);
		});
		uidBtn.Init(() =>
		{
			uidWindow.SetActive(value: true);
			SetCustomize(isCustomize: false);
		});
		scanQRBtn.gameObject.SetActive(flag && QRBtnOpen);
		if (flag)
		{
			scanQRBtn.Init(QRBtn);
		}
	}

	private void HideWeGameAccountEntries()
	{
		if (LuminApplication.IsWeGameChannel)
		{
			loginAccountBtn.gameObject.SetActive(value: false);
			scanQRBtn.gameObject.SetActive(value: false);
			noSDKBtn.gameObject.SetActive(value: false);
			uidBtn.gameObject.SetActive(value: false);
			noSDKWindow.SetActive(value: false);
			uidWindow.SetActive(value: false);
		}
	}

	public bool CouldEnterGame()
	{
		bool flag = Singleton<GameState>.instance.RunningState == GameRunningState.Login;
		bool flag2 = false;
		LuminBambooBridgeListener luminBambooBridgeListener = LuminBambooBridgeListener.Default;
		flag2 = luminBambooBridgeListener.IsInLoginPage || luminBambooBridgeListener.IsInLogoutPage;
		bool activeInHierarchy = ageNoticeWindow.activeInHierarchy;
		bool activeInHierarchy2 = messagePanel.gameObject.activeInHierarchy;
		bool activeInHierarchy3 = announcementPanel.gameObject.activeInHierarchy;
		bool flag3 = Singleton<NewUIManager>.instance.GetTopActiveUI().UIType == UI_TYPE.UI_SETTINGS;
		Debug.Log("[MonoLoginWaitClickView] CouldEnterCheck => " + $"inLoginState:{flag}, " + $"inSdkLoginView:{flag2}, " + $"ageNoticeIsOpen:{activeInHierarchy}, " + $"messagePanelIsOpen:{activeInHierarchy2}, " + $"isConnection:{m_IsConnecting}, " + $"announcementPanelIsOpen:{activeInHierarchy3}, ");
		if (((!flag | flag2 | activeInHierarchy | activeInHierarchy2) || m_IsConnecting) | activeInHierarchy3 | flag3)
		{
			return false;
		}
		return true;
	}

	public bool ShowAgeNotice(bool show)
	{
		_localAudioManager.PlayOptionBtnClickSound();
		if (show)
		{
			if (CouldEnterGame())
			{
				ageNoticeWindow.SetActive(value: true);
				return true;
			}
		}
		else if (ageNoticeWindow.activeInHierarchy)
		{
			ageNoticeWindow.SetActive(value: false);
			return true;
		}
		return false;
	}

	private MonoHotUpdate FindMonoHotUpdateInChildren(GameObject gameObject)
	{
		if (gameObject.TryGetComponent<MonoHotUpdate>(out _hotUpdate))
		{
			return _hotUpdate;
		}
		for (int i = 0; i < gameObject.transform.childCount; i++)
		{
			GameObject gameObject2 = gameObject.transform.GetChild(i).gameObject;
			_hotUpdate = FindMonoHotUpdateInChildren(gameObject2);
			if (_hotUpdate != null)
			{
				return _hotUpdate;
			}
		}
		return null;
	}

	private void NewId()
	{
		string text = openId.text;
		Match match = NameRex.Match(text);
		if (match.Success)
		{
			openId.text = $"{match.Groups[1].Value}({int.Parse(match.Groups[2].Value) + 1})";
		}
		else
		{
			openId.text += " (1)";
		}
	}

	private async UniTask Login(bool isCustomize = false)
	{
		try
		{
			if (m_IsConnecting || Singleton<NetManager>.instance.IsConnected)
			{
				return;
			}
			m_IsConnecting = true;
			m_GameLoad.mode = GameLoader.GameMode.Network;
			m_GameLoad.IsCustomize = isCustomize;
			Singleton<LoadManager>.instance.StartLoading(null, isBlack: false, null, new LoginLoadProgressHandle());
			await LoginUtility.LoginGame(ServerConfigSelected);
			control.SetActive(value: false);
			if (LoginUtility.EnterGameAck.IsNewUser)
			{
				await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_CREATECHARACTER, new CreateCharacterViewData
				{
					info = LoginUtility.RoleInfo,
					eTs = LoginUtility.EnterGameAck.Ts
				});
				Singleton<LoadManager>.instance.FinishLoading();
				Close();
			}
			else
			{
				Singleton<LoadManager>.instance.HandoffPhase();
				Singleton<LoadManager>.instance.StartLoading();
				m_GameLoad.GameStartWithOutUI();
				Singleton<LoadManager>.instance.AddLoadingViewOpenCompleteListener(EnterGame);
				m_IsConnecting = false;
			}
		}
		catch (Exception ex)
		{
			Singleton<LoadManager>.instance.FinishLoading();
			ResetLoginRetryState();
			LuminErrorException errorException = ex as LuminErrorException;
			if (errorException != null)
			{
				if (LoginUtility.IsLastSessionExpiredError(errorException))
				{
					LuminError.Handle(errorException, new ErrorHandleOptions(ErrorPresentation.None));
					await Reload();
					return;
				}
				Action onConfirm = ((!RuntimeVersionCheck.IsVersionError(errorException)) ? ((Action)(async () =>
				{
					if (errorException.Is(CodeType.SERVER, CodeModule.LOGIN, 1))
					{
						if (LuminBambooBridgeListener.TryLogoutAndQuitGameForWeGameAccountSwitch())
						{
							return;
						}
						BamBooSdk.getInstance().getExtend("logoutAndCleanData");
					}
					await Reload();
				})) : new Action(RuntimeVersionCheck.RestartGame));
				ErrorParam param = errorException.Param;
				string text = ((param != null && param.BanEndTimestamp > 0) ? TimeManager.GetDateTimeString(errorException.Param.BanEndTimestamp, "yyyy/MM/dd  HH:mm:ss") : null);
				LuminError.Handle(errorException, new ErrorHandleOptions(ErrorPresentation.Configured, new object[2]
				{
					errorException.Param?.Uid.FastToString(),
					text
				}, null, null, onConfirm));
			}
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(ex);
			}
		}
	}

	private UniTask LocalLogin()
	{
		localBtn.onClick.RemoveAllListeners();
		m_GameLoad.mode = GameLoader.GameMode.Local;
		StartCoroutine(m_GameLoad.CoModeSelection());
		EnterGame();
		return UniTask.CompletedTask;
	}

	private UniTask LocalLoginSaveGame()
	{
		localSaveBtn.onClick.RemoveAllListeners();
		m_GameLoad.mode = GameLoader.GameMode.ConfigSave;
		StartCoroutine(m_GameLoad.CoModeSelection());
		EnterGame();
		return UniTask.CompletedTask;
	}

	internal void LoginOrOut()
	{
		_localAudioManager.PlayOptionBtnClickSound();
		if (CouldEnterGame())
		{
			if (LuminBambooBridgeListener.Default.IsLogin)
			{
				TryLogoutBambooAccount();
			}
			else
			{
				TryLoginBambooAccount();
			}
		}
	}

	public void TryLogoutBambooAccount()
	{
		if (!LuminBambooBridgeListener.TryLogoutAndQuitGameForWeGameAccountSwitch() && LuminBambooBridgeListener.Default.IsLogin)
		{
			LuminBambooBridgeListener.Default.OpenLogoutPage();
		}
	}

	public async void TryLoginBambooAccount()
	{
		if (!LuminBambooBridgeListener.Default.IsLogin)
		{
			await UniTask.WaitUntil(() => !Singleton<LoadManager>.instance.InLoading);
			LuminBambooBridgeListener.Default.OpenLoginPage();
		}
	}

	private bool InLoginView()
	{
		LuminBambooBridgeListener luminBambooBridgeListener = LuminBambooBridgeListener.Default;
		if (!luminBambooBridgeListener.IsInLoginPage)
		{
			return luminBambooBridgeListener.IsInLogoutPage;
		}
		return true;
	}

	public void ClickEnterGame()
	{
		_localAudioManager.PlayLoginSound();
		if (!CouldEnterGame())
		{
			return;
		}
		switch (m_GameLoad.mode)
		{
		case GameLoader.GameMode.Local:
			LocalLogin().Forget();
			break;
		case GameLoader.GameMode.Network:
		case GameLoader.GameMode.Selection:
			if (!LuminBambooBridgeListener.Default.IsLogin)
			{
				TryLoginBambooAccount();
			}
			else
			{
				SDKLogin();
			}
			break;
		case GameLoader.GameMode.ConfigSave:
			LocalLoginSaveGame().Forget();
			break;
		}
	}

	private async void DontSDKLogin()
	{
	}

	private void SDKLogin()
	{
		LoginUtility.LoginSchemaEnum = GameLoader.LoginSchema.SDK;
		ExecuteLogin();
	}

	private void EnterGame()
	{
		Singleton<LoadManager>.instance.RemoveLoadingViewOpenCompleteListener(EnterGame);
		TrackLoginEvt evt = EventTrackSolver.Instance.GetEvt<TrackLoginEvt>();
		EventTrackSolver.Instance.Dispatch(evt);
		TimeManager.ServerTime.SetEnterGameStamp();
		Close();
	}

	public void QRBtn()
	{
		LuminBambooBridgeListener.Default.OpenQRPage();
	}

	public void ExitGame()
	{
		if (quitBtn.isActiveAndEnabled)
		{
			ShowExitGameConfirm();
		}
	}

	internal bool ShowExitGameConfirm()
	{
		_localAudioManager.PlayOptionBtnClickSound();
		if (!CouldEnterGame())
		{
			return false;
		}
		MonoMessageBox.Message message = new MonoMessageBox.Message
		{
			btn1Text = "取消",
			btn1MiniText = "QUXIAO",
			btn2Text = "确认",
			btn2MiniText = "QUEREN",
			titleText = "",
			callBack2 = () =>
			{
			},
			callBack = GameUtility.QuitGame,
			content = "是否退出游戏？"
		};
		messagePanel.Init(message);
		return true;
	}

	internal bool HideExitGameConfirm()
	{
		if (!messagePanel.isActiveAndEnabled)
		{
			return false;
		}
		messagePanel.gameObject.SetActive(value: false);
		return true;
	}

	private void ChangeButtonShow()
	{
		ChangeButtonShow(showLocal: false, showNotSDK: false, showUID: false);
		serverConfigSelect.gameObject.SetActive(value: false);
	}

	private void ChangeButtonShow(bool showLocal, bool showNotSDK, bool showUID)
	{
		localGameBtn.gameObject.SetActive(showLocal);
		noSDKBtn.gameObject.SetActive(showNotSDK);
		uidBtn.gameObject.SetActive(showUID);
	}

	public void SetCustomize(bool isCustomize)
	{
		m_IsCustomize = isCustomize;
	}

	public void OnClickSettingBtn()
	{
		if (CouldEnterGame())
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SETTINGS, new SettingsViewData
			{
				IsFromLogin = true
			});
			SystemOpen evt = EventTrackSolver.Instance.GetEvt<SystemOpen>();
			evt.id = 1035;
			evt.type = 2;
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	public void HideItem()
	{
		GameObject[] array = hideRoot;
		if (array != null && array.Length > 0)
		{
			array = hideRoot;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].SetActive(value: false);
			}
		}
	}

	public async void ShowAnnouncement()
	{
		if (CouldEnterGame())
		{
			await announcementPanel.UpdateData();
			announcementPanel.gameObject.SetActive(value: true);
			_localAudioManager.PlayWindowSound();
			tip.SetActive(value: false);
			toolKit.SetActive(value: false);
		}
	}

	public void CloseAnnouncement()
	{
		_localAudioManager.PlayWindowCloseSound();
		CloseAnnouncementSafe();
	}

	internal bool CloseAnnouncementSafe()
	{
		if (announcementPanel.gameObject.activeInHierarchy)
		{
			announcementPanel.gameObject.SetActive(value: false);
			tip.SetActive(value: true);
			toolKit.SetActive(value: true);
			UpdateAnnouncementRedDot();
			return true;
		}
		return false;
	}

	public void UpdateAnnouncementRedDot()
	{
		announcementRedDot.SetActive(!AnnouncementRedDot.IsAllRead(includeGame: true, includeActivity: false, includeTimeline: false, AnnouncementPlace.AOT));
	}

	private void OnConnectFail()
	{
		ResetLoginRetryState();
		LuminError.Handle(new LuminErrorException(CodeType.SERVER, CodeModule.LOGIN, 15, null, "系统提示", "数据更新失败"), new ErrorHandleOptions(ErrorPresentation.Configured, null, null, null, async () =>
		{
			await Reload();
		}));
	}

	private async UniTask Reload()
	{
		if (unloadSceneOperation != null)
		{
			await unloadSceneOperation;
		}
		unloadSceneOperation = null;
		ResetLoginRetryState();
	}

	private void ResetLoginRetryState()
	{
		m_IsConnecting = false;
		frontMask.SetActive(value: false);
		if (Singleton<NetManager>.HasInstance() && Singleton<NetManager>.instance.IsConnected)
		{
			Singleton<NetManager>.instance.Disconnect();
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		_currentDevice = MonoECS.instance.activeInputDevice;
		messagePanel.btnSelector.UpdateDevice(_currentDevice);
	}
}
