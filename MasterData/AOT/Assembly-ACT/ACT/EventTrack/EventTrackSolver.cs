using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Event;
using ACT.LocalLoader;
using Fundamental;
using Newtonsoft.Json.Linq;
using UnityEngine;
using bamboosdk;

namespace ACT.EventTrack;

public class EventTrackSolver : LuminBambooBridgeListener
{
	public static bool s_IsFirstLogin;

	private bool m_IsInitialized;

	public static Dictionary<Type, ObjectPool> EvtsPool;

	public static ObjectPool<JObject> JObjectPool = new ObjectPool<JObject>(null, (JObject x) =>
	{
		x?.RemoveAll();
		x = null;
	});

	private const string BatteryModeName = "battery_power";

	private const string CPUTemperature = "cpu_temperature";

	private const string ShareModName = "share_platform";

	public static EventTrackSolver Instance
	{
		get
		{
			if (LuminBambooBridgeListener.Default is EventTrackSolver result)
			{
				return result;
			}
			return (EventTrackSolver)(LuminBambooBridgeListener.Default = UnityEngine.Object.FindObjectOfType<EventTrackSolver>());
		}
	}

	public static string m_Token { get; private set; }

	public void Init()
	{
		if (!m_IsInitialized)
		{
			LuminBambooBridgeListener.Default = this;
			EnsureInitBambooSDK();
			EvtsPool = new Dictionary<Type, ObjectPool>();
			m_IsInitialized = true;
			if ((bool)UnityEngine.Object.FindObjectOfType<GameStart>())
			{
				m_Token = LuminBambooBridgeListener.UserInfo?.token;
			}
			else
			{
				SetBBSuperProperties(AotConstValues.TaPublicProperties);
			}
		}
	}

	public void UpdateVipPoint(long vipPoint)
	{
		JObject jObject = AotConstValues.TaPublicProperties.FirstOrDefault();
		if (jObject != null)
		{
			jObject["vip_point"] = vipPoint;
		}
		SetBBSuperProperties(AotConstValues.TaPublicProperties);
	}

	public void UpdatePlayerLevel(long playerLevel)
	{
		JObject jObject = AotConstValues.TaPublicProperties.FirstOrDefault();
		if (jObject != null)
		{
			jObject["player_level"] = playerLevel;
		}
		SetBBSuperProperties(AotConstValues.TaPublicProperties);
	}

	public void UpdateFairTag(int fireTag)
	{
		JObject jObject = AotConstValues.TaPublicProperties.FirstOrDefault();
		if (jObject != null)
		{
			jObject["fair_tag"] = fireTag;
		}
		SetBBSuperProperties(AotConstValues.TaPublicProperties);
	}

	private void OnDestroy()
	{
		if (m_IsInitialized)
		{
			EvtsPool = null;
		}
	}

	private void OnApplicationQuit()
	{
	}

	public void Dispatch<T>(TrackBaseEvt<T> trackBaseEvt) where T : TrackBaseEvt<T>, new()
	{
		if (trackBaseEvt == null)
		{
			return;
		}
		try
		{
			if (enabled && m_IsInitialized && (MonoECS.instance.isStartWorld || !trackBaseEvt.SkipIfWorldNotStart))
			{
				trackBaseEvt.OnDispatch();
			}
		}
		finally
		{
			trackBaseEvt.ReleaseEvt();
		}
	}

	public T GetEvt<T>() where T : TrackBaseEvt<T>, new()
	{
		if (EvtsPool == null)
		{
			return null;
		}
		Type typeFromHandle = typeof(T);
		if (!EvtsPool.TryGetValue(typeFromHandle, out var value))
		{
			value = new ObjectPool<T>();
			EvtsPool.Add(typeFromHandle, value);
		}
		return ((ObjectPool<T>)value).Get();
	}

	public override void onInitSuccess()
	{
		base.onInitSuccess();
		_ = LuminApplication.LogEnabled;
	}

	public override void onInitFailed(ErrorMsg message)
	{
		base.onInitFailed(message);
		_ = LuminApplication.LogEnabled;
	}

	public override void onLoginSuccess(UserInfo userInfo)
	{
		base.onLoginSuccess(userInfo);
		_ = (JObject)JToken.FromObject(userInfo);
		_ = LuminApplication.LogEnabled;
		m_Token = userInfo.token;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnBambooSdkLogin, null);
	}

	public override void onLoginFailed(ErrorMsg errMsg)
	{
		base.onLoginFailed(errMsg);
		new Exception("onLoginFailed! => " + errMsg);
		_ = LuminApplication.LogEnabled;
	}

	public override void onLoginCancel(ErrorMsg errMsg)
	{
		base.onLoginCancel(errMsg);
		_ = LuminApplication.LogEnabled;
	}

	public override void onSwitchAccountSuccess(UserInfo userInfo)
	{
		_ = LuminApplication.LogEnabled;
		if (LuminBambooBridgeListener.TryLogoutAndQuitGameForWeGameAccountSwitch())
		{
			_ = LuminApplication.LogEnabled;
		}
	}

	public override void onSwitchAccountFailed(ErrorMsg errMsg)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onSwitchAccountCancel()
	{
		_ = LuminApplication.LogEnabled;
	}

	protected override void OnLogoutSuccessAfterStateChanged()
	{
		_ = LuminApplication.LogEnabled;
		TrackLogoutEvt evt = GetEvt<TrackLogoutEvt>();
		evt.logoutType = -1;
		Dispatch(evt);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnBambooSdkLogout, null);
	}

	public override void onLogoutFailed()
	{
		base.onLogoutFailed();
		_ = LuminApplication.LogEnabled;
	}

	public override void onOpenPageSuccess()
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onOpenPageComplete(PageResult pageResult)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onOpenPageFailed(ErrorMsg errMsg)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onGuestUpgradeSuccess()
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onGuestUpgradeFailed(ErrorMsg errMsg)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onBackDownSuccess()
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onSucceed(string infos)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onFailed(string message)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onPaySuccess(PayResult payResult)
	{
		_ = LuminApplication.LogEnabled;
		PayEvent evt = Singleton<EventManager>.instance.GetEvt<PayEvent>();
		evt.orderID = payResult.cpOrderId;
		evt.message = payResult.message;
		evt.isSuccess = true;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Pay, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public override void onPayFailed(PayResult payResult)
	{
		_ = LuminApplication.LogEnabled;
		PayEvent evt = Singleton<EventManager>.instance.GetEvt<PayEvent>();
		evt.orderID = payResult.cpOrderId;
		evt.message = payResult.message;
		evt.isFail = true;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Pay, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public override void onPayFailedAndTryAgain(OrderInfo orderInfo)
	{
		_ = LuminApplication.LogEnabled;
		PayEvent evt = Singleton<EventManager>.instance.GetEvt<PayEvent>();
		evt.orderID = orderInfo.cpOrderId;
		evt.message = orderInfo.ToString();
		evt.isRetry = true;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Pay, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public override void onPayCancel(PayResult payResult)
	{
		_ = LuminApplication.LogEnabled;
		PayEvent evt = Singleton<EventManager>.instance.GetEvt<PayEvent>();
		evt.orderID = payResult.cpOrderId;
		evt.message = payResult.message;
		evt.isCancel = true;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Pay, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public override void onNotch(NotchResult notchResult)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onExtendSuccess(string modName, string jsonRes)
	{
		_ = LuminApplication.LogEnabled;
		if (modName == "backgroundDownload")
		{
			GameStart.HandleBackgroundDownloadSuccess(jsonRes);
		}
		LuminBambooBridgeListener.RaiseExtendSucceeded(modName, jsonRes);
		JObject jObject = JObject.Parse(jsonRes);
		if (!(modName == "battery_power"))
		{
			if (!(modName == "cpu_temperature"))
			{
				_ = modName == "share_platform";
				return;
			}
			CPUStatsEvt evt = Singleton<EventManager>.instance.GetEvt<CPUStatsEvt>();
			evt.cpuTemperature = (jObject["cpu_temperature"] ?? ((JToken)0)).Value<int>();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Device_CPUTemperature, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		else
		{
			BatterStatusEvt evt2 = Singleton<EventManager>.instance.GetEvt<BatterStatusEvt>();
			evt2.power = (jObject["battery_power"] ?? ((JToken)100)).Value<int>();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Device_Battery, evt2);
			Singleton<EventManager>.instance.ReleaseEvt(evt2);
		}
	}

	public override void onExtendFailed(string modName, ErrorMsg errMsg)
	{
		_ = LuminApplication.LogEnabled;
		if (modName == "backgroundDownload")
		{
			GameStart.HandleBackgroundDownloadFailure(string.IsNullOrEmpty($"{errMsg}") ? "backgroundDownload failed" : $"{errMsg}");
		}
		LuminBambooBridgeListener.RaiseExtendFailed(modName, errMsg);
	}

	public override void onStorageSuccess(string value)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onStorageFailed(ErrorMsg errMsg)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onSkuQueryDetailSuccess(string value)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onSkuQueryDetailFailed(ErrorMsg errMsg)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onExitSuccess()
	{
		base.onExitSuccess();
		_ = LuminApplication.LogEnabled;
	}

	public override void onExitFailed()
	{
		base.onExitFailed();
		_ = LuminApplication.LogEnabled;
	}

	public override void onSharedSuccess()
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onSharedCancel()
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onSharedFail(int code, string msg)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onReferrer(string referrer)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onLocalNotificationClickSuccess(string notifyData)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onAcceptAgreement(bool isAgree)
	{
		base.onAcceptAgreement(isAgree);
		_ = LuminApplication.LogEnabled;
		if (!isAgree)
		{
			Application.Quit();
		}
	}

	public override void onAcceptAgreement(string isAgree)
	{
		onAcceptAgreement(bool.Parse(isAgree));
	}

	public override void onIsSupportRewardedVideoAd(int status)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onRewardedVideoAdShow(string type, int status)
	{
		_ = LuminApplication.LogEnabled;
	}

	public override void onShareQuery(string openId, string serverId, string roleId)
	{
		throw new NotImplementedException();
	}

	public override void onMsgSecCheck(string content, string suggest, int label)
	{
		_ = LuminApplication.LogEnabled;
	}
}
