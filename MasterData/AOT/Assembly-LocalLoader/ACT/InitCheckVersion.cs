using System;
using ACT.Error;
using ACT.LocalLoader;
using Newtonsoft.Json.Linq;
using UnityEngine;
using bamboosdk;

namespace ACT;

internal class InitCheckVersion : GameLoadingFlowBase
{
	private enum ChannelAppUpdateStatus
	{
		None,
		Pending,
		Cancel,
		Error,
		Success
	}

	private const string HykbForceUpdateUrl = "hykb://openTopic?type=gamedetail&gameId=145381";

	private MonoMessageBox m_messageBox;

	private VersionCheckOption m_versionCheckOption;

	private ChannelAppUpdateStatus m_channelAppUpdateStatus;

	private string m_channelAppUpdateCode = string.Empty;

	private string m_channelAppUpdateMessage = string.Empty;

	private const string IosForceUpdateUrl = "https://apps.apple.com/cn/app/id6791432398";

	internal override EGameLoadingStage Stage => EGameLoadingStage.CheckVersion;

	public InitCheckVersion(MonoMessageBox messageBox)
	{
		m_messageBox = messageBox;
	}

	internal override void Init(GameLoadingData data)
	{
		m_channelAppUpdateStatus = ChannelAppUpdateStatus.None;
		m_channelAppUpdateCode = string.Empty;
		m_channelAppUpdateMessage = string.Empty;
		_loadState = EGameLoadingState.Waiting;
		CheckVersion();
	}

	internal override void Update()
	{
		GameStart gameStart = LuminBambooBridgeListener.Default as GameStart;
		if (gameStart == null)
		{
			Debug.LogError("[InitCheckVersion] GameStart listener is null when waiting channelAppUpdate.");
			Application.Quit();
			_loadState = EGameLoadingState.Failed;
			return;
		}
		switch (m_channelAppUpdateStatus)
		{
		case ChannelAppUpdateStatus.None:
		case ChannelAppUpdateStatus.Pending:
		case ChannelAppUpdateStatus.Success:
			break;
		case ChannelAppUpdateStatus.Cancel:
			UnregisterChannelAppUpdateCallback(gameStart);
			_loadState = ((m_versionCheckOption.State == VersionCheckState.Full) ? EGameLoadingState.Failed : EGameLoadingState.Succeed);
			if (m_versionCheckOption.State == VersionCheckState.Full)
			{
				Application.Quit();
			}
			break;
		case ChannelAppUpdateStatus.Error:
			UnregisterChannelAppUpdateCallback(gameStart);
			Debug.LogError("[InitCheckVersion] channelAppUpdate error. code=" + m_channelAppUpdateCode + ", msg=" + m_channelAppUpdateMessage);
			Application.Quit();
			_loadState = EGameLoadingState.Failed;
			break;
		}
	}

	private void CheckVersion()
	{
		_loadState = EGameLoadingState.Succeed;
		m_versionCheckOption = VersionCheckUtil.CheckVersion();
		switch (m_versionCheckOption.State)
		{
		case VersionCheckState.RefreshFail:
			if (!LuminApplication.IsLocalVersion)
			{
				LuminErrorAOT.ReportGameLoadingError("C01-0201", "01", 0);
			}
			_loadState = EGameLoadingState.Failed;
			break;
		case VersionCheckState.Patch:
		case VersionCheckState.HotUpdateWithPatch:
			if (!TryStartChannelAppUpdate())
			{
				MonoMessageBox.Message uiViewData = new MonoMessageBox.Message
				{
					btn1Text = AOTStringDefine.Confirm,
					btn2Text = AOTStringDefine.Cancle,
					callBack2 = () =>
					{
						JObject jObject = new JObject
						{
							["type"] = 2,
							["result"] = 2
						};
						BamBooSdk.getInstance().taEvent("update_client_version", jObject.ToString());
						_loadState = EGameLoadingState.Succeed;
					},
					callBack = () =>
					{
						JObject jObject = new JObject
						{
							["type"] = 2,
							["result"] = 1
						};
						BamBooSdk.getInstance().taEvent("update_client_version", jObject.ToString());
						Application.OpenURL(LuminApplication.RemoteConfig.UpdateNoticeContent);
						Application.Quit();
					},
					titleText = AOTStringDefine.UpdateTipTitle,
					content = AOTStringDefine.OldVersion
				};
				m_messageBox.Init(uiViewData);
				_loadState = EGameLoadingState.Waiting;
			}
			break;
		case VersionCheckState.Full:
		{
			MonoMessageBox.Message uiViewData;
			if (IsTapTapChannel())
			{
				uiViewData = new MonoMessageBox.Message
				{
					btn1Text = AOTStringDefine.Confirm,
					btn2Text = AOTStringDefine.Return,
					callBack2 = () =>
					{
						JObject jObject = new JObject
						{
							["type"] = 1,
							["result"] = 2
						};
						BamBooSdk.getInstance().taEvent("update_client_version", jObject.ToString());
						Application.Quit();
					},
					callBack = () =>
					{
						JObject jObject = new JObject
						{
							["type"] = 1,
							["result"] = 1
						};
						BamBooSdk.getInstance().taEvent("update_client_version", jObject.ToString());
						TryStartChannelAppUpdate();
					},
					titleText = AOTStringDefine.UpdateTipTitle,
					content = AOTStringDefine.OldVersion
				};
				m_messageBox.Init(uiViewData);
				_loadState = EGameLoadingState.Waiting;
				break;
			}
			uiViewData = new MonoMessageBox.Message
			{
				btn1Text = AOTStringDefine.Confirm,
				btn2Text = AOTStringDefine.Return,
				titleText = AOTStringDefine.UpdateTipTitle,
				callBack2 = () =>
				{
					JObject jObject = new JObject
					{
						["type"] = 1,
						["result"] = 2
					};
					BamBooSdk.getInstance().taEvent("update_client_version", jObject.ToString());
					Application.Quit();
				},
				callBack = () =>
				{
					JObject jObject = new JObject
					{
						["type"] = 1,
						["result"] = 1
					};
					BamBooSdk.getInstance().taEvent("update_client_version", jObject.ToString());
					Application.OpenURL(GetForceUpdateUrl());
					Application.Quit();
				},
				content = AOTStringDefine.OldVersion
			};
			m_messageBox.Init(uiViewData);
			_loadState = EGameLoadingState.Failed;
			break;
		}
		case VersionCheckState.Forbidden:
		{
			MonoMessageBox.Message uiViewData = new MonoMessageBox.Message
			{
				btn1Text = AOTStringDefine.Confirm,
				callBack = Application.Quit,
				content = LuminApplication.RemoteConfig.UpdateNoticeContent,
				isShowSingle = true,
				titleText = AOTStringDefine.Prompt
			};
			m_messageBox.Init(uiViewData);
			_loadState = EGameLoadingState.Failed;
			break;
		}
		case VersionCheckState.None:
		case VersionCheckState.HotUpdate:
			break;
		}
	}

	private bool TryStartChannelAppUpdate()
	{
		if (!IsTapTapChannel())
		{
			return false;
		}
		GameStart gameStart = LuminBambooBridgeListener.Default as GameStart;
		if (gameStart == null)
		{
			Debug.LogError("[InitCheckVersion] GameStart listener is null, cannot request channelAppUpdate.");
			Application.Quit();
			_loadState = EGameLoadingState.Failed;
			return true;
		}
		RegisterChannelAppUpdateCallback(gameStart);
		m_channelAppUpdateStatus = ChannelAppUpdateStatus.Pending;
		m_channelAppUpdateCode = string.Empty;
		m_channelAppUpdateMessage = string.Empty;
		try
		{
			BamBooSdkNative.getInstance().getExtend("channelAppUpdate", null);
		}
		catch (Exception ex)
		{
			UnregisterChannelAppUpdateCallback(gameStart);
			Debug.LogError($"[InitCheckVersion] channelAppUpdate request failed: {ex}");
			m_channelAppUpdateStatus = ChannelAppUpdateStatus.Error;
			m_channelAppUpdateCode = string.Empty;
			m_channelAppUpdateMessage = ex.Message;
		}
		_loadState = EGameLoadingState.Loading;
		return true;
	}

	private bool IsTapTapChannel()
	{
		if (!string.IsNullOrEmpty(LuminApplication.AppChannel))
		{
			return string.Equals(LuminApplication.AppChannel, "zhuzi_taptap", StringComparison.OrdinalIgnoreCase);
		}
		return false;
	}

	private static bool IsHykbChannel()
	{
		return string.Equals(LuminApplication.AppCpsGroup, "hykb", StringComparison.OrdinalIgnoreCase);
	}

	private static string GetForceUpdateUrl()
	{
		return LuminApplication.RemoteConfig.UpdateNoticeContent;
	}

	private void RegisterChannelAppUpdateCallback(GameStart gameStart)
	{
		gameStart.ChannelAppUpdateCallback -= OnChannelAppUpdateCallback;
		gameStart.ChannelAppUpdateCallback += OnChannelAppUpdateCallback;
	}

	private void UnregisterChannelAppUpdateCallback(GameStart gameStart)
	{
		gameStart.ChannelAppUpdateCallback -= OnChannelAppUpdateCallback;
	}

	private void OnChannelAppUpdateCallback(string status, string code, string message)
	{
		m_channelAppUpdateCode = code ?? string.Empty;
		m_channelAppUpdateMessage = message ?? string.Empty;
		string text = status?.Trim().ToLowerInvariant() ?? string.Empty;
		if (!(text == "cancel"))
		{
			if (text == "error")
			{
				m_channelAppUpdateStatus = ChannelAppUpdateStatus.Error;
			}
			else
			{
				m_channelAppUpdateStatus = ChannelAppUpdateStatus.Success;
			}
		}
		else
		{
			m_channelAppUpdateStatus = ChannelAppUpdateStatus.Cancel;
		}
	}
}
