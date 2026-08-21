#define ENABLE_ERROR_LOG
using System.Collections.Generic;
using GameFramework;
using ThinkingData.Analytics;

namespace Ase;

public sealed class TDAAgent
{
	private static bool _debugMode = true;

	private static bool _isInitialized = false;

	public static bool IsInitialized => _isInitialized;

	public static void InitWithAppId(string appId, string serverIP)
	{
		if (IsInitialized)
		{
			DebugLog(null, "TDAAgent has already been initialized.");
		}
		else if (!string.IsNullOrEmpty(appId) && !string.IsNullOrEmpty(serverIP))
		{
			TDAnalytics.Init(appId, serverIP);
			_isInitialized = true;
		}
	}

	public static string GetDistinctId()
	{
		return TDAnalytics.GetDistinctId("");
	}

	public static object GetDeviceId()
	{
		return TDAnalytics.GetDeviceId();
	}

	public static void EnableAutoTrack(bool enable)
	{
		TDAnalytics.EnableAutoTrack((TDAutoTrackEventType)(enable ? 35 : 0), (Dictionary<string, object>)null, "");
	}

	public static void EnableLog(bool enable)
	{
		TDAnalytics.EnableLog(enable);
	}

	public static void SendUserSet(Dictionary<string, object> userPropertys, bool setOnce = false)
	{
		if (userPropertys == null)
		{
			DebugLog(null, "设置用户属性参数异常！");
		}
		else if (setOnce)
		{
			TDAnalytics.UserSetOnce(userPropertys, "");
		}
		else
		{
			TDAnalytics.UserSet(userPropertys, "");
		}
	}

	public static void SendUserTrack(string eventName, Dictionary<string, object> eventPropertys)
	{
		if (string.IsNullOrEmpty(eventName) || eventPropertys == null)
		{
			DebugLog(null, "发送事件参数异常！");
		}
		else
		{
			TDAnalytics.Track(eventName, eventPropertys, "");
		}
	}

	public static void SendUserTrackFirst(string eventName, Dictionary<string, object> eventPropertys)
	{
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Expected O, but got Unknown
		if (string.IsNullOrEmpty(eventName) || eventPropertys == null)
		{
			DebugLog(null, "发送事件参数异常！");
			return;
		}
		TDAnalytics.Track((TDEventModel)new TDFirstEventModel(eventName)
		{
			EventType = (TDEventType)0,
			Properties = eventPropertys
		}, "");
	}

	public void SendSuperProperty(Dictionary<string, object> superProperties)
	{
		if (superProperties == null)
		{
			DebugLog(null, "设置公共事件属性参数异常！");
		}
		else
		{
			TDAnalytics.SetSuperProperties(superProperties, "");
		}
	}

	public static void Login(string userId)
	{
		TDAnalytics.Login(userId, "");
	}

	public static void DebugLog(string tag, string format, params object[] args)
	{
		if (_debugMode && !string.IsNullOrEmpty(format))
		{
			Log.Error("[TDAAgent] <Debug> - {0} : {1}", tag, string.Format(format, args));
		}
	}
}
