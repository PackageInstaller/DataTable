using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using ACT.Error;
using ACT.UI.AOT;
using Cysharp.Threading.Tasks;
using Newtonsoft.Json.Linq;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Serialization;
using UnityEngine.UI;
using bamboosdk;

namespace ACT.LocalLoader;

public class MonoHotUpdate : MonoBehaviour
{
	[Flags]
	private enum UpdateState
	{
		None = 0,
		PreUpdated = 2,
		HotUpdated = 8
	}

	public Button clickArea;

	public GameObject raycastBlock;

	public CanvasGroup canvasGroup;

	public Slider progress;

	public TextMeshProUGUI percentText;

	public TextMeshProUGUI progressText;

	public TextMeshProUGUI progressNum;

	public GameObject loadingPercentage;

	public GameObject downloadTipBlock;

	public TextMeshProUGUI downloadTip;

	public GameStartMessageBtnSelector downloadBtnSelector;

	public Button confirmDownloadBtn;

	[FormerlySerializedAs("cancleDownloadBtn")]
	public Button cancelDownloadBtn;

	public UpdatePanelMenuBtn quitBtn;

	public UpdatePanelMenuBtn loginBtn;

	public UpdatePanelMenuBtn announcementBtn;

	public AnnouncementViewAOT announcement;

	public GameObject announcementRedDot;

	public GameObject ageNotice;

	public Button openNoticeBtn;

	public StratificationComponent stratificationComponent;

	public GameStart gameStart;

	public UnityEvent OnSplashScreenCallBack;

	[Tooltip("不要热更")]
	public bool dontHotUpdate;

	public Action OnOpenAnnouncement;

	public Action OnCloseAnnouncement;

	public LocalAudioManager audioManager;

	private List<string> m_PreLabels = new List<string>();

	private string[] formatter1 = new string[4] { "0", "0", "0.0", "0.0" };

	private string[] formatter2 = new string[4] { "0.0", "0.0", "0.0", "0.0" };

	protected StringBuilder m_StringBuilder;

	private DownloadData _downloadData;

	private ProgressStageType _currentStage;

	private const string RequestNotificationModName = "reqxNotification";

	private const string ShowNotificationLogoModName = "isShowNotificationLogo";

	private const float NotificationRecheckInterval = 2f;

	private const int NotificationRecheckMaxTimes = 15;

	private int m_NotificationRecheckTimes;

	private bool m_NoticePermissionNeeded;

	private bool m_NoticePermissionUnavailable;

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

	private void Awake()
	{
		if ((bool)clickArea)
		{
			clickArea.gameObject.SetActive(value: true);
			clickArea.onClick.AddListener(SDKLoginOrOutBtn);
		}
		raycastBlock.SetActive(value: false);
		LuminBambooBridgeListener.OnSDKStateChanged = (Action<string, bool>)Delegate.Combine(LuminBambooBridgeListener.OnSDKStateChanged, new Action<string, bool>(OnSDKStateChanged));
		LuminBambooBridgeListener.ExtendSucceeded += OnNotificationExtendSucceeded;
	}

	private void OnDestroy()
	{
		if (_downloadData != null)
		{
			DownloadData downloadData = _downloadData;
			downloadData.StageProgressChanged = (Action<ProgressStageType, StageProgressData>)Delegate.Remove(downloadData.StageProgressChanged, new Action<ProgressStageType, StageProgressData>(OnStageProgressDataChanged));
			DownloadData downloadData2 = _downloadData;
			downloadData2.StageChanged = (Action<ProgressStageType>)Delegate.Remove(downloadData2.StageChanged, new Action<ProgressStageType>(OnStageChanged));
		}
		if ((bool)clickArea)
		{
			clickArea.gameObject.SetActive(value: false);
			clickArea.onClick.RemoveListener(SDKLoginOrOutBtn);
		}
		LuminBambooBridgeListener.OnSDKStateChanged = (Action<string, bool>)Delegate.Remove(LuminBambooBridgeListener.OnSDKStateChanged, new Action<string, bool>(OnSDKStateChanged));
		LuminBambooBridgeListener.ExtendSucceeded -= OnNotificationExtendSucceeded;
		StopNotificationRecheck();
	}

	public void Init(DownloadData downloadData)
	{
		if (_downloadData != null)
		{
			DownloadData downloadData2 = _downloadData;
			downloadData2.StageProgressChanged = (Action<ProgressStageType, StageProgressData>)Delegate.Remove(downloadData2.StageProgressChanged, new Action<ProgressStageType, StageProgressData>(OnStageProgressDataChanged));
			DownloadData downloadData3 = _downloadData;
			downloadData3.StageChanged = (Action<ProgressStageType>)Delegate.Remove(downloadData3.StageChanged, new Action<ProgressStageType>(OnStageChanged));
		}
		_downloadData = downloadData;
		if (_downloadData != null)
		{
			DownloadData downloadData4 = _downloadData;
			downloadData4.StageProgressChanged = (Action<ProgressStageType, StageProgressData>)Delegate.Combine(downloadData4.StageProgressChanged, new Action<ProgressStageType, StageProgressData>(OnStageProgressDataChanged));
			DownloadData downloadData5 = _downloadData;
			downloadData5.StageChanged = (Action<ProgressStageType>)Delegate.Combine(downloadData5.StageChanged, new Action<ProgressStageType>(OnStageChanged));
			_currentStage = _downloadData.CurrentStage;
		}
		DownloadData downloadData6 = _downloadData;
		downloadData6.CalSizeDone = (Action)Delegate.Combine(downloadData6.CalSizeDone, new Action(StartUpdate));
		DownloadData downloadData7 = _downloadData;
		downloadData7.CheckState = (Action<string, float>)Delegate.Combine(downloadData7.CheckState, new Action<string, float>(CheckStep));
		gameStart?.BorderAdjustLocal();
		m_StringBuilder = new StringBuilder();
		confirmDownloadBtn.onClick.RemoveAllListeners();
		confirmDownloadBtn.onClick.AddListener(ConfirmUpdate);
		cancelDownloadBtn.onClick.RemoveAllListeners();
		cancelDownloadBtn.onClick.AddListener(() =>
		{
			downloadTipBlock.SetActive(value: false);
			MonoMessageBox.Message uiViewData = new MonoMessageBox.Message
			{
				btn1Text = "确认",
				btn1MiniText = "QUEREN",
				btn2Text = "取消",
				btn2MiniText = "QUXIAO",
				titleText = "",
				callBack2 = () =>
				{
					downloadTipBlock.SetActive(value: true);
				},
				callBack = Application.Quit,
				content = "是否退出游戏？"
			};
			gameStart.messageBox.Init(uiViewData);
		});
		quitBtn.gameObject.SetActive(!Application.isMobilePlatform);
		if (!Application.isMobilePlatform)
		{
			quitBtn.Init(QuitGameBtn);
		}
		if (LuminApplication.IsWeGameChannel)
		{
			loginBtn.gameObject.SetActive(value: false);
		}
		else
		{
			loginBtn.Init(SDKLoginOrOutBtn, openState: false);
		}
		announcementBtn.Init(NoticeBtn);
		if (openNoticeBtn != null)
		{
			openNoticeBtn.onClick.RemoveAllListeners();
			openNoticeBtn.onClick.AddListener(RequestNotificationPermission);
			SetNoticePermissionBtnVisible(isVisible: false);
		}
		GameStart.LoadEnterGameSpin();
		stratificationComponent = GameStart.EnterGameSpinInstance.GetComponent<StratificationComponent>();
		stratificationComponent.InitializeSystem();
	}

	public void InitPersistentAudio()
	{
		audioManager.enabled = true;
	}

	public void StartUpdate()
	{
		UpdateResource();
	}

	public void CheckStep(string name, float percent)
	{
		SetCanvasActive(active: true);
		SetProgressBarActive(active: true);
		progressText.text = name;
		progressNum.gameObject.SetActive(value: false);
		percentText.text = ToPercentage(percent, 2);
		progress.value = percent;
	}

	public async Task UpdateResource()
	{
		if (dontHotUpdate)
		{
			EndUpdate();
			return;
		}
		try
		{
			await PrepareDownloadResource();
			EndUpdate();
		}
		catch (Exception e)
		{
			DownloadFail(e);
		}
		void DownloadFail(Exception ex)
		{
			_downloadData.RetryCount++;
			if (_downloadData.RetryCount > 3)
			{
				LuminErrorAOT.ReportGameLoadingError("C01-9903", "01", 0);
			}
			else
			{
				LuminErrorAOT.ReportGameLoadingError(_downloadData.ErrorCode, _downloadData.SystemModule, 0, _downloadData.Message, retry: true, () =>
				{
					_downloadData.DownloadFail = false;
					_downloadData.CanRetry = true;
					_downloadData.Retry?.Invoke();
				});
			}
		}
		async Task PrepareDownloadResource()
		{
			long num = _downloadData.MaxDownloadBytes - _downloadData.CurDownloadBytes;
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"[HotUpdate] PrepareDownloadResource: max={_downloadData.MaxDownloadBytes}, " + $"cur={_downloadData.CurDownloadBytes}, remain={num}, " + $"acceptUpdate={_downloadData.AcceptUpdate}, complete={_downloadData.DownloadComplete}, " + ((num > 0) ? "将显示进度条。" : "无可下载差量，不显示进度条。"));
			}
			if (num > 0 && !_downloadData.AcceptUpdate)
			{
				SetCanvasActive(active: false);
				SetProgressBarActive(active: false);
				downloadTipBlock.gameObject.SetActive(value: true);
				if (Application.internetReachability == NetworkReachability.NotReachable)
				{
					GameStart gameStart = UnityEngine.Object.FindObjectOfType<GameStart>();
					MonoMessageBox.Message uiViewData = new MonoMessageBox.Message
					{
						btn1Text = "确认",
						callBack = Application.Quit,
						isShowSingle = true,
						content = "下载失败\n请检查网络后重启游戏\ncode：C03-0002",
						titleText = "系统提示"
					};
					gameStart.messageBox.Init(uiViewData);
				}
				else
				{
					if (Application.internetReachability == NetworkReachability.ReachableViaLocalAreaNetwork)
					{
						if (LuminApplication.LogEnabled)
						{
							Debug.Log("wifi/网线——环境");
						}
						string text = ((GameLoadingData.CurStage == EGameLoadingStage.CheckResourceIntegrity) ? AOTStringDefine.MissingNetWifiState : AOTStringDefine.NetWifiState);
						downloadTip.text = text.Replace("{0}", ByteConverter(num, formatter1));
					}
					if (Application.internetReachability == NetworkReachability.ReachableViaCarrierDataNetwork)
					{
						if (LuminApplication.LogEnabled)
						{
							Debug.Log("运营商数据网络——环境");
						}
						string text2 = ((GameLoadingData.CurStage == EGameLoadingStage.CheckResourceIntegrity) ? AOTStringDefine.MissingNetCarrierState : AOTStringDefine.NetCarrierState);
						downloadTip.text = text2.Replace("{0}", ByteConverter(num, formatter1));
					}
					await UniTask.WaitUntil(() => _downloadData.AcceptUpdate);
					downloadTipBlock.gameObject.SetActive(value: false);
					SetCanvasActive(active: true);
					SetProgressBarActive(active: true);
					await UpdateResourceProgress();
				}
			}
			else if (num > 0 && _downloadData.AcceptUpdate)
			{
				SetCanvasActive(active: true);
				SetProgressBarActive(active: true);
				await UpdateResourceProgress();
			}
			else if (_downloadData.MaxDownloadBytes > 0 && num <= 0 && !_downloadData.AcceptUpdate)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.Log("[HotUpdate] 无可下载差量，UI 代用户放行(AcceptUpdate=true)并等待下载流程结束。");
				}
				_downloadData.AcceptUpdate = true;
				SetCanvasActive(active: true);
				SetProgressBarActive(active: true);
				await UpdateResourceProgress();
			}
		}
		async Task UpdateResourceProgress()
		{
			if (_downloadData != null)
			{
				while (!_downloadData.DownloadComplete)
				{
					if (_downloadData.DownloadFail)
					{
						DownloadFail(new Exception("Download Failed."));
						break;
					}
					await UniTask.Yield();
				}
			}
		}
	}

	private void EndUpdate()
	{
		progress.value = 1f;
		percentText.SetText(ToPercentage(1f, 0));
	}

	private void ConfirmUpdate()
	{
		_downloadData.AcceptUpdate = true;
		downloadTipBlock.SetActive(value: false);
	}

	public void OnSplashScreenFinished()
	{
		OnSplashScreenCallBack?.Invoke();
	}

	public void SetCanvasActive(bool active)
	{
		canvasGroup.alpha = (active ? 1 : 0);
	}

	private string ByteConverter(long byteSize, string[] formatters)
	{
		float num = byteSize;
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString(formatters[0]) + "KB";
		}
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString(formatters[1]) + "MB";
		}
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString(formatters[2]) + "GB";
		}
		num /= 1024f;
		if (num < 1024f)
		{
			return num.ToString(formatters[3]) + "TB";
		}
		return string.Empty;
	}

	public static string ToPercentage(float p, int num)
	{
		return p.ToString($"p{num}");
	}

	public void FakeProgress(int duration)
	{
		m_StringBuilder.Clear();
		m_StringBuilder.Append(duration.ToString());
		m_StringBuilder.Append("%");
		percentText.SetText(m_StringBuilder);
	}

	private void OnStageProgressDataChanged(ProgressStageType stageType, StageProgressData data)
	{
		if (data == null)
		{
			return;
		}
		if (stageType != _currentStage)
		{
			if (data.IsActive)
			{
				OnStageChanged(stageType);
			}
		}
		else
		{
			UpdateStageProgressUI(data);
		}
	}

	private void OnStageChanged(ProgressStageType stageType)
	{
		_currentStage = stageType;
		SetCanvasActive(active: true);
		SetProgressBarActive(active: true);
		StageProgressData stageProgressData = _downloadData?.GetStageProgressData(stageType);
		if (stageProgressData != null)
		{
			UpdateStageProgressUI(stageProgressData);
		}
	}

	private void UpdateStageProgressUI(StageProgressData data)
	{
		if (data != null)
		{
			switch (_currentStage)
			{
			case ProgressStageType.Download:
			case ProgressStageType.CheckIntegrity:
				progressNum.gameObject.SetActive(value: true);
				UpdateDownloadStageUI(data);
				break;
			case ProgressStageType.Extract:
				progressNum.gameObject.SetActive(value: false);
				UpdateSharedStageUI(data);
				break;
			}
		}
	}

	private void UpdateDownloadStageUI(StageProgressData data)
	{
		if (data != null && !(progress == null))
		{
			float num = Mathf.Clamp01(data.Percent);
			progress.value = num;
			if ((bool)progressText && !string.IsNullOrEmpty(data.StageName))
			{
				progressText.text = data.StageName;
			}
			if ((bool)percentText)
			{
				percentText.SetText(ToPercentage(num, 2));
			}
			if ((bool)progressNum)
			{
				progressNum.SetText(data.IsActive ? FormatDownloadDetail(data) : string.Empty);
			}
		}
	}

	private void UpdateSharedStageUI(StageProgressData data)
	{
		if (!(progress == null))
		{
			float num = Mathf.Clamp01(data.Percent);
			progress.value = num;
			if ((bool)progressText && !string.IsNullOrEmpty(data.StageName))
			{
				progressText.text = data.StageName;
			}
			if ((bool)percentText)
			{
				percentText.SetText(ToPercentage(num, 1));
			}
			if ((bool)progressNum)
			{
				progressNum.SetText(FormatStageDetail(data));
			}
		}
	}

	private string FormatDownloadDetail(StageProgressData data)
	{
		if (data == null || data.TotalBytes <= 0)
		{
			return string.Empty;
		}
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("(").Append(ByteConverter(data.CurrentBytes, formatter1)).Append("/")
			.Append(ByteConverter(data.TotalBytes, formatter1))
			.Append(")");
		if (data.SpeedBytesPerSecond > 0)
		{
			stringBuilder.Append(ByteConverter(data.SpeedBytesPerSecond, formatter2)).Append("/S");
		}
		return stringBuilder.ToString();
	}

	private string FormatStageDetail(StageProgressData data)
	{
		if (data.TotalCount > 0)
		{
			return $"({data.CurrentCount}/{data.TotalCount})";
		}
		return string.Empty;
	}

	private bool IsWeGameAccountChannel()
	{
		if (LuminApplication.IsWeGameChannel)
		{
			return true;
		}
		return false;
	}

	public void SDKLoginOrOutBtn()
	{
		if (IsWeGameAccountChannel())
		{
			return;
		}
		audioManager.PlayOptionBtnClickSound();
		LuminBambooBridgeListener luminBambooBridgeListener = LuminBambooBridgeListener.Default;
		if (this.gameStart == null || !luminBambooBridgeListener || !luminBambooBridgeListener.IsSDKInitialized)
		{
			Debug.LogWarning("[MonoHotUpdate] SDKLoginOrOutBtn ignored: " + $"gameStartValid={this.gameStart != null}, " + $"sdkBridgeValid={luminBambooBridgeListener != null}, " + $"sdkInitialized={luminBambooBridgeListener != null && luminBambooBridgeListener.IsSDKInitialized}");
		}
		else if (luminBambooBridgeListener.IsLogin)
		{
			GameStart gameStart = UnityEngine.Object.FindObjectOfType<GameStart>();
			MonoMessageBox.Message uiViewData = new MonoMessageBox.Message
			{
				btn2Text = "取消",
				btn1Text = "确认",
				callBack = () =>
				{
					if (!LuminBambooBridgeListener.TryLogoutAndQuitGameForWeGameAccountSwitch())
					{
						BamBooSdk.getInstance().logout(isShowWindow: false);
					}
				},
				callBack2 = () =>
				{
				},
				content = "确认切换账号吗？",
				titleText = ""
			};
			gameStart.messageBox.Init(uiViewData);
		}
		else
		{
			luminBambooBridgeListener.OpenLoginPage();
		}
	}

	public void QuitGameBtn()
	{
		audioManager.PlayOptionBtnClickSound();
		MonoMessageBox.Message uiViewData = new MonoMessageBox.Message
		{
			btn1Text = "确认",
			btn1MiniText = "QUXIAO",
			btn2Text = "取消",
			btn2MiniText = "QUEREN",
			titleText = "",
			callBack2 = () =>
			{
				JObject jObject = new JObject { ["type"] = 1 };
				BamBooSdk.getInstance().taEvent("quit_game_choice", jObject.ToString());
			},
			callBack = () =>
			{
				JObject jObject = new JObject { ["type"] = 3 };
				BamBooSdk.getInstance().taEvent("quit_game_choice", jObject.ToString());
				Application.Quit(0);
			},
			content = "是否退出游戏？"
		};
		gameStart.messageBox.Init(uiViewData);
	}

	public async void NoticeBtn()
	{
		await announcement.UpdateData();
		announcement.gameObject.SetActive(value: true);
		audioManager.PlayWindowSound();
		UpdateNoticeRedDot();
		OnOpenAnnouncement?.Invoke();
	}

	public void AgeNoticeBtn()
	{
		audioManager.PlayOptionBtnClickSound();
		ageNotice.gameObject.SetActive(value: true);
	}

	public void CloseAgeNotice()
	{
		audioManager.PlayOptionBtnClickSound();
		ageNotice.gameObject.SetActive(value: false);
	}

	public void QRBtn()
	{
		audioManager.PlayOptionBtnClickSound();
		LuminBambooBridgeListener.Default.OpenQRPage();
	}

	public void CloseNotice()
	{
		audioManager.PlayWindowCloseSound();
		announcement.gameObject.SetActive(value: false);
		UpdateNoticeRedDot();
		OnCloseAnnouncement?.Invoke();
	}

	public bool IsNoticeOpened()
	{
		return announcement.gameObject.activeSelf;
	}

	public void UpdateNoticeRedDot()
	{
		announcementRedDot.SetActive(!AnnouncementRedDot.IsAllRead(includeGame: true, includeActivity: false, includeTimeline: false, AnnouncementPlace.AOT));
	}

	private void OnSDKStateChanged(string s, bool b)
	{
		if (!s.Equals("IsInAgreementPage") && !s.Equals("IsInLoginPage"))
		{
			s.Equals("IsInLogoutPage");
		}
		if (s.Equals("IsLogin"))
		{
			loginBtn.isOpen = b;
			clickArea.gameObject.SetActive(!b);
			loginBtn.gameObject.SetActive(!LuminApplication.IsWeGameChannel && !b);
		}
	}

	private void Update()
	{
		if (m_NoticePermissionNeeded)
		{
			bool flag = IsNoticePermissionBtnUnavailable();
			if (flag != m_NoticePermissionUnavailable)
			{
				m_NoticePermissionUnavailable = flag;
				ApplyNoticePermissionBtnVisible();
			}
		}
	}

	private bool IsNoticePermissionBtnUnavailable()
	{
		if (IsActiveInHierarchy(downloadTipBlock) || IsActiveInHierarchy(ageNotice) || IsActiveInHierarchy(raycastBlock) || IsActiveInHierarchy((announcement != null) ? announcement.gameObject : null))
		{
			return true;
		}
		if (gameStart != null && gameStart.messageBox != null)
		{
			return gameStart.messageBox.gameObject.activeInHierarchy;
		}
		return false;
	}

	private static bool IsActiveInHierarchy(GameObject go)
	{
		if (go != null)
		{
			return go.activeInHierarchy;
		}
		return false;
	}

	public void StartNotificationPermissionCheck()
	{
		StartNotificationRecheck(hideButtonFirst: true);
	}

	private void StartNotificationRecheck(bool hideButtonFirst)
	{
		if (IsAndroidPlatform())
		{
			if (hideButtonFirst)
			{
				SetNoticePermissionBtnVisible(isVisible: false);
			}
			m_NotificationRecheckTimes = 0;
			StopNotificationRecheck();
			InvokeRepeating("QueryNotificationPermission", 0f, 2f);
		}
	}

	private void StopNotificationRecheck()
	{
		CancelInvoke("QueryNotificationPermission");
	}

	private void QueryNotificationPermission()
	{
		if (!IsAndroidPlatform() || m_NotificationRecheckTimes >= 15)
		{
			StopNotificationRecheck();
			return;
		}
		m_NotificationRecheckTimes++;
		try
		{
			BamBooSdk.getInstance().getExtend("isShowNotificationLogo", "");
		}
		catch (Exception ex)
		{
			Debug.LogError("[MonoHotUpdate] 查询通知栏权限按钮显示状态失败: " + ex.Message);
		}
	}

	private void RequestNotificationPermission()
	{
		if (!IsAndroidPlatform())
		{
			return;
		}
		StartNotificationRecheck(hideButtonFirst: false);
		try
		{
			BamBooSdk.getInstance().getExtend("reqxNotification", "");
		}
		catch (Exception ex)
		{
			Debug.LogError("[MonoHotUpdate] 申请通知栏权限失败: " + ex.Message);
		}
	}

	private void OnNotificationExtendSucceeded(string modName, string jsonRes)
	{
		if (modName != "reqxNotification" && modName != "isShowNotificationLogo")
		{
			return;
		}
		if (!TryParseNotificationVisible(jsonRes, out var isShow))
		{
			Debug.LogWarning("[MonoHotUpdate] 通知栏权限 SDK 回调缺少有效的 isShow 字段: modName=" + modName + ", jsonRes=" + jsonRes);
			return;
		}
		SetNoticePermissionBtnVisible(isShow);
		if (!isShow)
		{
			StopNotificationRecheck();
		}
	}

	private void SetNoticePermissionBtnVisible(bool isVisible)
	{
		m_NoticePermissionNeeded = isVisible;
		m_NoticePermissionUnavailable = IsNoticePermissionBtnUnavailable();
		ApplyNoticePermissionBtnVisible();
	}

	private void ApplyNoticePermissionBtnVisible()
	{
		if (openNoticeBtn != null)
		{
			openNoticeBtn.gameObject.SetActive(m_NoticePermissionNeeded && !m_NoticePermissionUnavailable);
		}
	}

	private static bool TryParseNotificationVisible(string jsonRes, out bool isShow)
	{
		isShow = false;
		try
		{
			string text = JObject.Parse(jsonRes)["isShow"]?.ToString();
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
			Debug.LogError("[MonoHotUpdate] 解析通知栏权限 SDK 回调失败: " + ex.Message);
		}
		return false;
	}

	private static bool IsAndroidPlatform()
	{
		return Application.platform == RuntimePlatform.Android;
	}

	public void StopSoundSlowly()
	{
		audioManager.enabled = false;
	}

	public void SetProgressBarActive(bool active)
	{
		progress.gameObject.SetActive(active);
	}

	public void RemoveMenuBtnEventOnEnterGame()
	{
		quitBtn.RemoveListeners();
		loginBtn.RemoveListeners();
		announcementBtn.RemoveListeners();
	}
}
