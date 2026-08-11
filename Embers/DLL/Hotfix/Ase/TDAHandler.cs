using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class TDAHandler : MonoBehaviour
{
	private static TDAHandler _instance;

	private const string serverIP = "https://teup.kiifstudio.com";

	private Dictionary<int, long> viewCache;

	public static TDAHandler Instance
	{
		get
		{
			if (_instance == null)
			{
				Initialize();
			}
			return _instance;
		}
	}

	private string TDAAppId
	{
		get
		{
			if (GameEntry.BuiltinData.PreServiceStatus)
			{
				return "b146bfe708ed4495aad95450546f8f6f";
			}
			return "2ebf8e076242450480374cf64c909cda";
		}
	}

	public static void Initialize()
	{
		if (_instance == null)
		{
			_instance = new GameObject("TDAHandler").AddComponent<TDAHandler>();
			_instance.Init();
			UnityEngine.Object.DontDestroyOnLoad(_instance);
		}
	}

	private void Init()
	{
		TDAAgent.EnableLog(enable: true);
		TDAAgent.EnableAutoTrack(enable: true);
		TDAAgent.InitWithAppId(TDAAppId, "https://teup.kiifstudio.com");
		SendDeviceInfo();
	}

	public string GetDistinctId()
	{
		return TDAAgent.GetDistinctId();
	}

	public void SendDeviceId(string val)
	{
		SendUserProperty("device_id", val, setOnce: true);
	}

	public void SendUserProperty(string propertyName, object val, bool setOnce = false)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add(propertyName, val);
		TDAAgent.SendUserSet(dictionary, setOnce);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public void SendUserProperty(Dictionary<string, object> properties, bool setOnce = false)
	{
		TDAAgent.SendUserSet(properties, setOnce);
	}

	public void SendUserEvent(string eventName, Dictionary<string, object> eventPropertys)
	{
		AddUserAccount(eventPropertys);
		TDAAgent.SendUserTrack(eventName, eventPropertys);
	}

	private void SendUserEventFirst(string eventName, Dictionary<string, object> eventPropertys)
	{
		TDAAgent.SendUserTrackFirst(eventName, eventPropertys);
	}

	private void AddUserAccount(Dictionary<string, object> eventPropertys)
	{
		if (eventPropertys != null)
		{
			if (!eventPropertys.ContainsKey("account_id"))
			{
				eventPropertys.Add("account_id", (Singleton<ServiceSystem>.Instance?.GetService<IRoleService>()?.GetRoleData()?.PlayerInfo?.Uid).GetValueOrDefault());
			}
			if (!eventPropertys.ContainsKey("distinct_id"))
			{
				eventPropertys.Add("distinct_id", GetDistinctId());
			}
		}
	}

	private void SendDeviceInfo()
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		SendUserEventFirst("first_device_add", dictionary);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public void SendViewStart(int pageId, string pageType, string entrance)
	{
		if (viewCache == null)
		{
			viewCache = new Dictionary<int, long>();
			viewCache.Clear();
		}
		long value = (long)(DateTime.Now - new DateTime(1970, 1, 1)).TotalSeconds;
		if (viewCache.ContainsKey(pageId))
		{
			viewCache[pageId] = value;
		}
		else
		{
			viewCache.Add(pageId, value);
		}
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("page_id", $"{pageId}");
		dictionary.Add("page_type", pageType);
		dictionary.Add("entrance", entrance);
		SendUserEvent("page_view_start", dictionary);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public void SendViewEnd(int pageId, string pageType, string entrance)
	{
		long num = 0L;
		if (viewCache != null && viewCache.ContainsKey(pageId))
		{
			num = (long)(DateTime.Now - new DateTime(1970, 1, 1)).TotalSeconds - viewCache[pageId];
			viewCache.Remove(pageId);
		}
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("page_id", $"{pageId}");
		dictionary.Add("page_type", pageType);
		dictionary.Add("entrance", entrance);
		dictionary.Add("duration", num);
		SendUserEvent("page_view_end", dictionary);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public void SendReport(int type, long uid, long reportUid, int content, string remark)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("type", type);
		dictionary.Add("uid", uid);
		dictionary.Add("report_uid", reportUid);
		dictionary.Add("content", content);
		dictionary.Add("remark", remark);
		SendUserEvent("report", dictionary);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public void SendLevelActiveBorn(int levelId, int bornId)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("battle_type", "关卡");
		dictionary.Add("battle_id", levelId);
		dictionary.Add("transferpoint_id", bornId);
		SendUserEvent("transferpoint_activate", dictionary);
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public void TransPointInteract(int levelId, int selectIndex, Dictionary<string, object> dictionary)
	{
		dictionary.Add("battle_type", "关卡");
		dictionary.Add("battle_id", levelId);
		switch (selectIndex)
		{
		case 0:
			dictionary.Add("transferpointmenu_type", "休息");
			break;
		case 1:
			dictionary.Add("transferpointmenu_type", "更换阵容");
			break;
		case 2:
			dictionary.Add("transferpointmenu_type", "强化");
			break;
		}
		SendUserEvent("transferpointmenu_interaction", dictionary);
	}

	public void ForceBattleStart(int levelId, int monsterUID, int areaId, Dictionary<string, object> dictionary)
	{
		dictionary.Add("battle_type", "关卡");
		dictionary.Add("battle_id", levelId);
		dictionary.Add("monstergroup_uid", monsterUID);
		dictionary.Add("monstergroup_area", areaId);
		SendUserEvent("levelbattle_start", dictionary);
	}

	public void ForceBattleEnd(int levelId, int monsterUid, int areaId, Dictionary<string, object> dictionary, float battleDura, string reason)
	{
		dictionary.Add("battle_type", "关卡");
		dictionary.Add("battle_id", levelId);
		dictionary.Add("monstergroup_uid", monsterUid);
		dictionary.Add("monstergroup_area", areaId);
		dictionary.Add("duration", battleDura.ToString("F2"));
		dictionary.Add("reason", reason);
		SendUserEvent("levelbattle_end", dictionary);
	}

	public void EnterLevel(int levelId, string borinPoint, Dictionary<string, object> dictionary)
	{
		dictionary.Add("battle_type", "关卡");
		dictionary.Add("battle_id", levelId);
		dictionary.Add("transferpoint_id", borinPoint);
		SendUserEvent("level_start", dictionary);
	}

	public void ExitLevel(int levelId, Dictionary<string, object> dictionary, float duration, int openChestNum, int killMonsterCount, int killBossNum)
	{
		dictionary.Add("battle_type", "关卡");
		dictionary.Add("battle_id", levelId);
		dictionary.Add("duration", duration.ToString("F2"));
		dictionary.Add("chest_num", openChestNum);
		dictionary.Add("monster_kill", killMonsterCount);
		dictionary.Add("bossr_num", killBossNum);
		SendUserEvent("level_quit", dictionary);
	}

	public void OpenChestReport(int levelId, int uid, int levelAreaAreaId)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("battle_type", "关卡");
		dictionary.Add("battle_id", levelId);
		dictionary.Add("treasurebox_uid", uid);
		dictionary.Add("treasurebox_area", levelAreaAreaId);
		SendUserEvent("treasurebox_open", dictionary);
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public void OuterGuideStepReport(float time, int stepId)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("guide_name", "抽卡引导");
		dictionary.Add("guide_steps", stepId);
		dictionary.Add("duration", time.ToString("F2"));
		SendUserEvent("guide_step_finish", dictionary);
	}

	public void LevelGuideStepReport(float time, int stepId)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("guide_name", "作战引导");
		dictionary.Add("guide_steps", stepId);
		dictionary.Add("duration", time.ToString("F2"));
		SendUserEvent("guide_step_finish", dictionary);
	}

	public void Login(string userId)
	{
		TDAAgent.Login(userId);
		Singleton<ServiceSystem>.Instance.GetService<ISDKService>()?.OnSetAccountId(userId);
		SendUserProperty("account_id", userId);
	}

	public void LevelPlayStory(int id, float duratiom, bool skip)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("plot_id", id);
		dictionary.Add("is_skip", skip);
		dictionary.Add("duration", duratiom.ToString("F2"));
		SendUserEvent("plot_task", dictionary);
	}

	public void GetAppVersionReport(string cuttentVersion, string version, string versionStatus, string versionOption)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("current_version", cuttentVersion);
		dictionary.Add("get_version_status", versionStatus);
		dictionary.Add("get_version", version);
		dictionary.Add("get_version_option", versionOption);
		SendUserEvent("get_version_pop", dictionary);
	}

	public void ResourceDownloadReport(string eventName, string resourceSize, string popStatus, double downloadSize, double downloadSpeed, string breakType = "", string downloadMode = "", string startTime = "", string duration = "")
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		switch (eventName)
		{
		case "resource_download_pop":
			dictionary.Add("total_resource_size_mb", resourceSize);
			dictionary.Add("pop_status", popStatus);
			dictionary.Add("download_mode_option", downloadMode);
			SendUserEvent("resource_download_pop", dictionary);
			break;
		case "resource_download_star":
		case "background_download_star":
			dictionary.Add("total_resource_size_mb", resourceSize);
			SendUserEvent(eventName, dictionary);
			break;
		case "resource_download_break":
			dictionary.Add("total_resource_size_mb", resourceSize);
			dictionary.Add("download_resource_size_mb", downloadSize);
			dictionary.Add("average_download_speed", downloadSpeed);
			dictionary.Add("break_type", breakType);
			SendUserEvent("resource_download_break", dictionary);
			break;
		case "background_download_pause":
			dictionary.Add("total_resource_size_mb", resourceSize);
			dictionary.Add("download_resource_size_mb", downloadSize);
			dictionary.Add("average_download_speed", downloadSpeed);
			dictionary.Add("background_download_star_time", startTime);
			SendUserEvent("background_download_pause", dictionary);
			break;
		case "background_download_finish":
			dictionary.Add("total_resource_size_mb", resourceSize);
			dictionary.Add("duration", duration);
			dictionary.Add("average_download_speed", downloadSpeed);
			dictionary.Add("background_download_star_time", startTime);
			SendUserEvent("background_download_finish", dictionary);
			break;
		}
	}
}
