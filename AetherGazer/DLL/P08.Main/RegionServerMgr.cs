using System;
using System.Collections.Generic;
using LitJson;
using UnityEngine;
using YSGMCore;

public class RegionServerMgr : MonoBehaviour
{
	private static RegionServerMgr m_instance;

	private Action<bool, string> action;

	private List<RegionServerInfo> regionServerInfoList;

	public static RegionServerMgr instance
	{
		get
		{
			if (m_instance == null)
			{
				m_instance = new GameObject("RegionServerMgr").AddComponent<RegionServerMgr>();
			}
			return m_instance;
		}
	}

	private void Awake()
	{
		regionServerInfoList = new List<RegionServerInfo>();
		YsGMEvent.Instance.ServerInfoResultEvent = ServerInfoCallback;
	}

	public List<RegionServerInfo> GetRegionServerInfoList()
	{
		return regionServerInfoList;
	}

	public RegionServerInfo GetRegionServerInfo(string serverId)
	{
		foreach (RegionServerInfo regionServerInfo in regionServerInfoList)
		{
			if (regionServerInfo.serverId == serverId)
			{
				return regionServerInfo;
			}
		}
		return null;
	}

	public void UpdateRegionServerInfo(string token, Action<bool, string> callback)
	{
		Debug.Log("Region server UpdateRegionServerInfo");
		TextAsset textAsset = Resources.Load<TextAsset>("ClientVersion");
		bool flag = null != textAsset;
		if (GameToSDK.CURRENT_SDK_ID == 0 || !flag)
		{
			callback(arg1: false, string.Empty);
			return;
		}
		int num = JsonMapper.ToObject<ClientVersionStatus>(textAsset.text)?.version ?? 100;
		if (LuaForSplash.gateWayUrl.IsNotNullOrEmpty())
		{
			action = callback;
			string text = "?action=server";
			text = text + "&version=" + num;
			if (!string.IsNullOrEmpty(token))
			{
				text = text + "&mixId=" + token;
			}
			string text2 = LuaForSplash.gateWayUrl + text;
			Debug.Log("Region server UpdateRegionServerInfo url" + text2);
			YsGMSDKN.Instance.GetServerInfo(this, text2);
		}
		else
		{
			Debug.Log("Region server error with empty gateWayUrl");
			callback(arg1: false, string.Empty);
		}
	}

	public void ServerInfoCallback(int errorCode, string errorMsg, List<GateWayInfo> infoList)
	{
		Debug.Log($"Region server ServerInfoCallback by errorCode: {errorCode} ; errorMsg:{errorMsg};");
		if (errorCode == 0)
		{
			regionServerInfoList = new List<RegionServerInfo>();
			foreach (GateWayInfo info in infoList)
			{
				Dictionary<string, string> dictionary = new Dictionary<string, string>();
				for (int i = 0; i < info.config.Count; i++)
				{
					dictionary.TryAdd(info.config[i].key, info.config[i].value);
				}
				List<RegionServerUserInfo> list = new List<RegionServerUserInfo>();
				if (info.gameUserInfoList != null)
				{
					foreach (GameUserInfo gameUserInfo in info.gameUserInfoList)
					{
						list.Add(new RegionServerUserInfo
						{
							uid = gameUserInfo.uid,
							currentLevel = gameUserInfo.currentLevel,
							nickName = gameUserInfo.nickName,
							lastLoginTime = gameUserInfo.lastLoginTime
						});
					}
				}
				RegionServerInfo item = new RegionServerInfo
				{
					serverId = info.serverId,
					serverName = info.serverName,
					ip = info.ip,
					port = info.port,
					newServerFlag = info.newServerFlag,
					env = info.env,
					maintain = info.maintain,
					maintainReason = info.maintainReason,
					configS = dictionary,
					gameUserInfoList = list
				};
				regionServerInfoList.Add(item);
			}
			if (action != null)
			{
				action(arg1: true, errorMsg);
			}
		}
		else if (action != null)
		{
			action(arg1: false, errorMsg);
		}
	}

	public void UpdateClintConfigs(string serverId)
	{
		RegionServerInfo regionServerInfo = GetRegionServerInfo(serverId);
		if (regionServerInfo == null || GameToSDK.clientInfo == null)
		{
			Debug.LogError("UpdateClintConfigs fail");
			return;
		}
		GameToSDK.clientInfo.configS = regionServerInfo.configS;
		Debug.LogError("UpdateClintConfigs success");
	}

	private void OnDestroy()
	{
		YsGMEvent.Instance.ServerInfoResultEvent = null;
	}
}
