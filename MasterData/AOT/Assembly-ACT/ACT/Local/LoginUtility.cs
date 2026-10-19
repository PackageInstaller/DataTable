using System;
using System.Text.RegularExpressions;
using ACT.Battle;
using ACT.Error;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Local.Login;
using ACT.LocalLoader;
using ACT.Model;
using ACT.Net;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf;
using Newtonsoft.Json.Linq;
using Pb;
using UnityEngine;
using UnityEngine.Device;
using bamboosdk;

namespace ACT.Local;

public static class LoginUtility
{
	public abstract class LoginSchema
	{
		public abstract LoginReq ProcessLoginReq();
	}

	public class BambooSDKSchema : LoginSchema
	{
		public override LoginReq ProcessLoginReq()
		{
			LoginReq loginReq = new LoginReq
			{
				OpenId = string.Empty,
				LoginTicket = EventTrackSolver.m_Token
			};
			SetOperationalInfo(loginReq);
			_ = LuminApplication.LogEnabled;
			return loginReq;
		}
	}

	public class AccountSchema : LoginSchema
	{
		public override LoginReq ProcessLoginReq()
		{
			if (EventTrackSolver.Instance.IsLogin)
			{
				if (!LuminBambooBridgeListener.TryLogoutAndQuitGameForWeGameAccountSwitch())
				{
					BamBooSdk.getInstance().logout(isShowWindow: true);
				}
				throw new LuminErrorException(CodeType.CLIENT, CodeModule.LOGIN, 1, null, "系统提示", "不可以在登录竹子SDK情况下使用OpenId登录！");
			}
			LoginReq loginReq = new LoginReq
			{
				OpenId = OpenId,
				AccountId = 0L,
				LoginTicket = string.Empty
			};
			SetOperationalInfo(loginReq);
			_ = LuminApplication.LogEnabled;
			return loginReq;
		}
	}

	public class UserIdSchema : LoginSchema
	{
		public override LoginReq ProcessLoginReq()
		{
			if (EventTrackSolver.Instance.IsLogin)
			{
				if (!LuminBambooBridgeListener.TryLogoutAndQuitGameForWeGameAccountSwitch())
				{
					BamBooSdk.getInstance().logout(isShowWindow: false);
				}
				throw new LuminErrorException(CodeType.CLIENT, CodeModule.LOGIN, 2, null, "系统提示", "不可以在登录竹子SDK情况下使用Uid登录！");
			}
			LoginReq loginReq = new LoginReq
			{
				OpenId = string.Empty,
				AccountId = AccountId,
				LoginTicket = string.Empty
			};
			SetOperationalInfo(loginReq);
			_ = LuminApplication.LogEnabled;
			return loginReq;
		}
	}

	private static readonly HttpLoginServerClient LoginServerClient = new HttpLoginServerClient();

	public static LoginAck LoginAck;

	public static EnterGameAck EnterGameAck;

	public static EnterGameLoadAck EnterGameLoadAck;

	public static ErrorAck ErrorAck;

	public static GameLoader.LoginSchema LoginSchemaEnum;

	public static string GameServerIP;

	public static string GameServerName;

	public static int GameServerPort;

	public static long SdkAid;

	public static long AccountId;

	public static string OpenId;

	public static string sessionID;

	public static Action ConnectFailAction;

	private const int LOGIN_SERVER_TIMEOUT_MILLISECONDS = 5000;

	private const int PrimaryGateConnectAttempts = 3;

	private const int BackupGateConnectAttempts = 2;

	public static byte[] AesKey;

	public static bool IsEncry;

	public static int FairTag;

	private static Regex gateAddrReg = new Regex("(.*):(.*)");

	public static string LoginServerUrl { get; private set; }

	public static long Uid => AccountId;

	private static LoginLoadProgressHandle LoginProgressHandle => Singleton<LoadManager>.instance.ActiveHandle as LoginLoadProgressHandle;

	public static RoleInfo RoleInfo { get; set; }

	public static void LogClientError(LuminErrorException exception)
	{
		if (exception != null)
		{
			LogClientErrorAsync(exception).Forget();
		}
	}

	private static async UniTaskVoid LogClientErrorAsync(LuminErrorException exception)
	{
		await UniTask.SwitchToMainThread();
		if (exception.CodeModule == CodeModule.NETWORK)
		{
			Debug.LogError($"[NetFailure] [NetConnection] client network error\n{exception}");
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogException(exception);
		}
		LuminError.Handle(exception);
	}

	public static async UniTask LoginGame(ServerConfig serverConfig)
	{
		VersionCheckOption option = VersionCheckUtil.CheckVersionWithUpdateConfig(MonoECS.instance);
		await option;
		if (!option.IsSuccess || option.State == VersionCheckState.RefreshFail)
		{
			throw CreateServerConfigError("无法正确解析服务器配置，请稍后重试。", null);
		}
		RuntimeVersionCheck.CheckVersion(option);
		if (!TryReadLoginServerUrl(serverConfig, out var loginServerUrl))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("无法正确解析服务器配置");
			}
			throw CreateServerConfigError("无法正确解析服务器配置，请稍后重试。", null);
		}
		sessionID = "";
		LoginServerUrl = loginServerUrl;
		Singleton<GameState>.instance.SetGameServerState(GameServerState.Connecting);
		Singleton<NetManager>.instance.UnInit();
		LoginAck loginAck = await ConnectLoginServer();
		LoginProgressHandle?.CompleteLoginServerStep();
		G.service = new NetGameService();
		G.service.SetNetState(IGameService.NetState.Connect);
		G.detailUserInfo = new DetailUserInfo();
		G.localPlayer = new Player();
		G.localPlayer.Inventory = new Inventory();
		GameServerName = serverConfig.name;
		EnterGameAck enterGameAck = await ConnectGameServerWithGateFallback(loginAck, serverConfig);
		G.detailUserInfo.Brief = enterGameAck.Info.Brief;
		RoleInfo = new RoleInfo
		{
			serverId = loginAck.ServerGroup,
			roleId = enterGameAck.Info.Brief.AccountId.ToString(),
			roleLevel = SystemUnlockManager.playerLevel.ToString(),
			roleName = enterGameAck.Info.Brief.Nickname
		};
		Singleton<NewUIManager>.instance.UidTxt.gainID();
		if (enterGameAck.IsNewUser)
		{
			TrackCreateEvt evt = EventTrackSolver.Instance.GetEvt<TrackCreateEvt>();
			evt.createData = serverConfig.name;
			EventTrackSolver.Instance.Dispatch(evt);
		}
		else
		{
			EnterGameLoadAck = await SyncUserInfo(new EnterGameLoadReq());
		}
		LoginProgressHandle?.CompleteSyncUserInfoStep();
		MonoECS.instance.AddNetworkdListener();
		Singleton<GameState>.instance.SetGameServerState(GameServerState.Connected);
		Singleton<NetManager>.instance.MarkOnline();
	}

	public static (string ip, int port) GetGameServiceIPAndPort(string gateAddr)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("Gate Address:" + gateAddr);
		}
		Match match = gateAddrReg.Match(gateAddr);
		if (!match.Success)
		{
			throw new LuminErrorException(CodeType.CLIENT, CodeModule.NETWORK, 6);
		}
		string item = match.Groups[1].Value.Trim();
		int item2 = int.Parse(match.Groups[2].Value);
		return (ip: item, port: item2);
	}

	public static async UniTask<LoginAck> ConnectLoginServer(bool preserveCachedPackets = false)
	{
		LoginReq request = null;
		switch (LoginSchemaEnum)
		{
		case GameLoader.LoginSchema.SDK:
			request = new BambooSDKSchema().ProcessLoginReq();
			break;
		}
		LuminApplication.InitializeGCMKey(isEncry: false, null);
		IMessage message;
		try
		{
			message = await LoginServerClient.LoginAsync(LoginServerUrl, request, Math.Max(1, (int)Math.Ceiling(5.0)));
		}
		catch (Exception ex) when (!(ex is LuminErrorException))
		{
			Debug.LogError($"[NetFailure] [LoginHttp] login server connection failed\n{ex}");
			throw new LuminErrorException(CodeType.CLIENT, CodeModule.NETWORK, 2);
		}
		if (!(message is LoginAck loginAck))
		{
			if (!(message is ErrorAck errorAck))
			{
				return null;
			}
			ErrorAck = errorAck;
			if (errorAck.CodeType == 1 && errorAck.CodeModule == 2 && errorAck.SubCode == 23)
			{
				JObject jObject = JObject.Parse(errorAck.Message);
				JToken? jToken = jObject["title"];
				string? titleOverride = ((jToken != null) ? jToken.Value<string>() : null);
				JToken? jToken2 = jObject["content"];
				throw new LuminErrorException(errorAck, titleOverride, (jToken2 != null) ? jToken2.Value<string>() : null, null, hideErrorCode: true);
			}
			throw new LuminErrorException(errorAck);
		}
		if (loginAck.Code == 103)
		{
			throw new LuminErrorException(CodeType.SERVER, CodeModule.LOGIN, 22);
		}
		LoginAck = loginAck;
		SdkAid = LoginAck.SdkAid;
		AccountId = LoginAck.AccountId;
		OpenId = LoginAck.OpenId;
		ByteString aesKey = LoginAck.AesKey;
		IsEncry = LoginAck.IsEncry;
		FairTag = LoginAck.FairTag;
		if (IsEncry)
		{
			byte[] aesGcmKey = LuminApplication.GetAesGcmKey(OpenId);
			AesKey = LuminApplication.NormalizeAesKeyBytes(LuminApplication.GcmDecryptWithKey(aesKey.ToByteArray(), aesGcmKey));
			LuminApplication.InitializeGCMKey(isEncry: true, AesKey);
		}
		else
		{
			LuminApplication.InitializeGCMKey(isEncry: false, null);
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"connect login server : SdkAid = {SdkAid} Uid = {AccountId}");
		}
		EventTrackSolver.Instance.UpdateFairTag(FairTag);
		return loginAck;
	}

	public static async UniTask<EnterGameAck> ConnectGameServerWithGateFallback(LoginAck la, ServerConfig serverConfig = default(ServerConfig))
	{
		LuminErrorException ex2;
		try
		{
			return await ConnectGameServerWithGateAddress(la, serverConfig, la.GateAddr, 3);
		}
		catch (LuminErrorException ex) when (IsGameGateConnectFailure(ex))
		{
			ex2 = ex;
		}
		if (!string.IsNullOrEmpty(la.GateAddrBackup))
		{
			return await ConnectGameServerWithGateAddress(la, serverConfig, la.GateAddrBackup, 2);
		}
		throw ex2;
	}

	private static async UniTask<EnterGameAck> ConnectGameServerWithGateAddress(LoginAck la, ServerConfig serverConfig, string gateAddr, int maxAttempts)
	{
		(string ip, int port) gameAddress = GetGameServiceIPAndPort(gateAddr);
		LuminErrorException ex = null;
		for (int i = 0; i < maxAttempts; i++)
		{
			(GameServerIP, GameServerPort) = gameAddress;
			try
			{
				return await ConnectGameServer(la, serverConfig);
			}
			catch (LuminErrorException ex2) when (IsGameGateConnectFailure(ex2))
			{
				ex = ex2;
				Debug.LogError($"[NetFailure] [NetConnection] connect game server failed, gateAddr={gateAddr}, attempt={i + 1}/{maxAttempts}\n{ex2}");
			}
		}
		throw ex;
	}

	private static bool IsGameGateConnectFailure(LuminErrorException ex)
	{
		if (ex != null && ex.CodeType == CodeType.CLIENT && ex.CodeModule == CodeModule.NETWORK)
		{
			return ex.SubCode == 4;
		}
		return false;
	}

	public static bool IsLastSessionExpiredError(LuminErrorException exception)
	{
		return exception?.Is(CodeType.CLIENT, CodeModule.LOGIN, 3) ?? false;
	}

	public static async UniTask<EnterGameAck> ConnectGameServer(LoginAck la, ServerConfig serverConfig = default(ServerConfig))
	{
		if (IsEncry)
		{
			LuminApplication.InitializeGCMKey(isEncry: true, AesKey);
		}
		else
		{
			LuminApplication.InitializeGCMKey(isEncry: false, null);
		}
		if (!(await Singleton<NetManager>.instance.ConnectAsync(GameServerIP, GameServerPort)))
		{
			throw new LuminErrorException(CodeType.CLIENT, CodeModule.NETWORK, 4);
		}
		EnterGameReq enterGameReq = new EnterGameReq();
		enterGameReq.OpenId = la.OpenId;
		enterGameReq.LoginKey = la.LoginKey;
		enterGameReq.AccountId = la.AccountId;
		enterGameReq.SdkAid = la.SdkAid;
		enterGameReq.SessionID = sessionID;
		enterGameReq.ClientVersion = LuminApplication.DisplayVersion;
		enterGameReq.IsEditor = Application.isEditor;
		BBPresetProperties bBPresetProperties = BamBooSdk.getInstance().getBBPresetProperties();
		enterGameReq.TdData = new TDClientData
		{
			OsVersion = bBPresetProperties.os_version,
			Os = bBPresetProperties.os,
			BundleId = bBPresetProperties.bundle_id,
			DeviceId = bBPresetProperties.device_id,
			DeviceModel = bBPresetProperties.device_model,
			ScreenHeight = bBPresetProperties.screen_height,
			ScreenWidth = bBPresetProperties.screen_width,
			SystemLan = bBPresetProperties.system_language,
			Cpu = UnityEngine.Device.SystemInfo.processorType,
			Gpu = UnityEngine.Device.SystemInfo.graphicsDeviceName,
			Cps = LuminApplication.AppCpsId,
			ChannelId = LuminApplication.AppChannel,
			Platform = LuminApplication.CurrentPlatformId
		};
		enterGameReq.DistinctID = BamBooSdk.getInstance().getBBPresetProperties().distinct_id;
		LoginProgressHandle?.BeginWaitGameServerData();
		IMessage message = await Singleton<NetManager>.instance.RequestConnectionAsync(enterGameReq);
		LoginProgressHandle?.CompleteWaitGameServerData();
		if (message is EnterGameAck enterGameAck)
		{
			if (enterGameAck.LastSessionExpired)
			{
				throw new LuminErrorException(CodeType.CLIENT, CodeModule.LOGIN, 3);
			}
			LuminApplication.APM.UpdateUserId($"{enterGameAck.Info.Brief.AccountId}");
			UrlUtility.SetUrls();
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("reset urls, feedback url : " + UrlUtility.FeedbackUrl + ", user center url : " + UrlUtility.UserCenterUrl);
			}
			DateTime toCheck = TimeManager.TimeStampToDateTime(enterGameAck.Ts, inMilli: true);
			EventTrackSolver.s_IsFirstLogin = !TimeManager.IsSameDay(TimeManager.TimeStampToDateTime(enterGameAck.LastEnterTime), toCheck);
			TimeManager.StartGame(enterGameAck.Ts);
			sessionID = enterGameAck.SessionID;
			EnterGameAck = enterGameAck;
			FacePushModel.NotifyLoginSessionStarted();
			Singleton<NetManager>.instance.MarkSynchronizing();
			BamBooSdk.getInstance().getExtend("init_share", "");
			return enterGameAck;
		}
		if (message is ErrorAck errorAck)
		{
			ErrorAck = message as ErrorAck;
			throw new LuminErrorException(errorAck);
		}
		throw new LuminErrorException(CodeType.CLIENT, CodeModule.NETWORK, 4);
	}

	public static async UniTask<EnterGameLoadAck> SyncUserInfo(EnterGameLoadReq req, Action callback = null)
	{
		IMessage message = await Singleton<NetManager>.instance.RequestConnectionAsync(req);
		if (message is EnterGameLoadAck enterGameLoadAck)
		{
			G.detailUserInfo = enterGameLoadAck.Info;
			G.localPlayer.Profile = enterGameLoadAck.Info.Profile;
			foreach (MissionState mission in G.localPlayer.Missions)
			{
				mission.isNew = false;
			}
			callback?.Invoke();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SyncGameInfo, null);
			EventTrackSolver.Instance.UpdateVipPoint(G.detailUserInfo.Attributes[100]);
			EventTrackSolver.Instance.UpdatePlayerLevel(G.detailUserInfo.Attributes[90]);
			return enterGameLoadAck;
		}
		if (message is ErrorAck errorAck)
		{
			ErrorAck = message as ErrorAck;
			throw new LuminErrorException(errorAck);
		}
		throw new LuminErrorException(CodeType.CLIENT, CodeModule.NETWORK, 4);
	}

	private static void SetOperationalInfo(LoginReq lr)
	{
		BBPresetProperties bBPresetProperties = BamBooSdk.getInstance().getBBPresetProperties();
		lr.TdData = new TDClientData
		{
			OsVersion = bBPresetProperties.os_version,
			Os = bBPresetProperties.os,
			BundleId = bBPresetProperties.bundle_id,
			DeviceId = bBPresetProperties.device_id,
			DeviceModel = bBPresetProperties.device_model,
			ScreenHeight = bBPresetProperties.screen_height,
			ScreenWidth = bBPresetProperties.screen_width,
			SystemLan = bBPresetProperties.system_language,
			Cpu = UnityEngine.Device.SystemInfo.processorType,
			Gpu = UnityEngine.Device.SystemInfo.graphicsDeviceName,
			Cps = LuminApplication.AppCpsId,
			ChannelId = LuminApplication.AppChannel,
			Platform = LuminApplication.CurrentPlatformId
		};
		lr.OperationalInfo = new OperationalInfo
		{
			Platform = LuminApplication.GetPlatformName,
			Device = UnityEngine.Device.SystemInfo.deviceModel,
			OperatingSystem = UnityEngine.Device.SystemInfo.operatingSystem,
			ClientVersion = LuminApplication.DisplayVersion,
			DeviceId = BamBooSdk.getInstance().getBBPresetProperties().device_id
		};
		lr.Env = LuminApplication.AppEnv;
		lr.DistinctID = BamBooSdk.getInstance().getBBPresetProperties().distinct_id;
		lr.IsEditor = false;
	}

	private static LuminErrorException CreateServerConfigError(string message, Exception innerException)
	{
		return new LuminErrorException(CodeType.CLIENT, CodeModule.NETWORK, 6, null, "系统提示", message, innerException);
	}

	private static bool TryReadLoginServerUrl(ServerConfig serverConfig, out string loginServerUrl)
	{
		loginServerUrl = null;
		loginServerUrl = LuminApplication.RemoteConfig?.ServerUrl;
		if (string.IsNullOrWhiteSpace(loginServerUrl))
		{
			loginServerUrl = serverConfig.loginUrl;
		}
		if (Uri.TryCreate(loginServerUrl, UriKind.Absolute, out var result))
		{
			if (!(result.Scheme == Uri.UriSchemeHttp))
			{
				return result.Scheme == Uri.UriSchemeHttps;
			}
			return true;
		}
		return false;
	}
}
