using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using UnityEngine;

namespace Ase;

public static class SpineHelper
{
	public static void SetSpineInteractivity(Transform spine, bool interactivity)
	{
		MonoBehaviour[] componentsInChildren = spine.GetComponentsInChildren<MonoBehaviour>(includeInactive: true);
		if (componentsInChildren == null)
		{
			return;
		}
		MonoBehaviour[] array = componentsInChildren;
		foreach (MonoBehaviour monoBehaviour in array)
		{
			if (monoBehaviour is IBoardPart)
			{
				monoBehaviour.gameObject.SetActive(interactivity);
			}
		}
	}

	public static bool PlayTransitionCheck(DRSkinTheater drSkinTheater, string prefabName)
	{
		if (drSkinTheater == null)
		{
			return false;
		}
		if (StreamerMode.GetStreamerMode())
		{
			return false;
		}
		GetTransitionConfig(drSkinTheater, 1, out var aniName, out var _, out var _);
		if (string.IsNullOrEmpty(aniName))
		{
			return false;
		}
		int num = GameEntry.Setting.GetInt("幻衣特殊转场");
		if (num == 1 && IsSpineTransitionedToday(prefabName, aniName))
		{
			return false;
		}
		if (num == 2)
		{
			return false;
		}
		return true;
	}

	public static void GetTransitionConfig(DRSkinTheater config, int tranType, out string aniName, out int voiceId, out int soundId)
	{
		aniName = "";
		voiceId = 0;
		soundId = 0;
		int num = config.TranType.FindIndex((int p) => p == tranType);
		if (num >= 0)
		{
			aniName = ((config.TranAnim.Count > num) ? config.TranAnim[num] : "");
			voiceId = ((config.TranVoice.Count > num) ? config.TranVoice[num] : 0);
			soundId = ((config.TranAudio.Count > num) ? config.TranAudio[num] : 0);
		}
	}

	public static List<SpineTransitionInfo> SaveTransitionInfo(string prefabName, string aniName)
	{
		List<SpineTransitionInfo> transitionLocalInfo = GetTransitionLocalInfo();
		transitionLocalInfo.RemoveAll((SpineTransitionInfo p) => p.PrefabName.Equals(prefabName) && p.AniName.Equals(aniName));
		transitionLocalInfo.Add(new SpineTransitionInfo
		{
			PrefabName = prefabName,
			AniName = aniName,
			Time = GetTime()
		});
		string value = JsonConvert.SerializeObject(new SpineTransitionInfoJsonData
		{
			datas = transitionLocalInfo
		});
		PlayerPrefs.SetString("SpineTransitionInfo", value);
		return transitionLocalInfo;
	}

	public static List<SpineTransitionInfo> GetTransitionLocalInfo()
	{
		return (JsonConvert.DeserializeObject<SpineTransitionInfoJsonData>(PlayerPrefs.GetString("SpineTransitionInfo")) ?? new SpineTransitionInfoJsonData()).datas ?? new List<SpineTransitionInfo>();
	}

	private static bool IsSpineTransitionedToday(string prefabName, string aniName)
	{
		return GetTransitionLocalInfo().Find((SpineTransitionInfo p) => p.PrefabName.Equals(prefabName) && p.AniName.Equals(aniName))?.Time.Equals(GetTime()) ?? false;
	}

	private static DateTime GetTime()
	{
		DateTime now = DateTime.Now;
		int dailyUpdateHour = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetDailyUpdateHour();
		DateTime dateTime = ((now.Hour < dailyUpdateHour) ? now.AddDays(-1.0) : now);
		return new DateTime(dateTime.Year, dateTime.Month, dateTime.Day);
	}
}
