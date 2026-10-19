using System;
using System.Collections.Generic;
using ACT;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Bamboo.AssetField;
using UnityEngine;

namespace Lumin.LoungeSystem;

public static class LoungeUtility
{
	public static string GetMoodStateName(LoungeDefine.MoodState mood)
	{
		return mood switch
		{
			LoungeDefine.MoodState.VeryHappy => "非常开心", 
			LoungeDefine.MoodState.Happy => "开心", 
			LoungeDefine.MoodState.Normal => "普通", 
			LoungeDefine.MoodState.Unhappy => "不开心", 
			LoungeDefine.MoodState.Sad => "难过", 
			_ => "未知", 
		};
	}

	public static string GetMoodIcon(LoungeDefine.MoodState mood)
	{
		return mood switch
		{
			LoungeDefine.MoodState.VeryHappy => "UI/Icons/Mood_VeryHappy", 
			LoungeDefine.MoodState.Happy => "UI/Icons/Mood_Happy", 
			LoungeDefine.MoodState.Normal => "UI/Icons/Mood_Normal", 
			LoungeDefine.MoodState.Unhappy => "UI/Icons/Mood_Unhappy", 
			LoungeDefine.MoodState.Sad => "UI/Icons/Mood_Sad", 
			_ => "UI/Icons/Mood_Default", 
		};
	}

	public static string GetInteractionTypeName(LoungeDefine.InteractionType type, int storyId = 0)
	{
		return type switch
		{
			LoungeDefine.InteractionType.Chat => (storyId == 0) ? "聊天" : GetInteractText(type, storyId), 
			LoungeDefine.InteractionType.Touch => "触摸", 
			LoungeDefine.InteractionType.Gift => "赠送礼物", 
			LoungeDefine.InteractionType.TriggerGlobalStory => (storyId == 0) ? "全局剧情" : GetInteractText(type, storyId), 
			LoungeDefine.InteractionType.PersonalStory => (storyId == 0) ? "个人剧情" : GetInteractText(type, storyId), 
			LoungeDefine.InteractionType.BackToMain => "下次再聊", 
			_ => "未知", 
		};
	}

	private static string GetInteractText(LoungeDefine.InteractionType type, int storyId = 0)
	{
		if (type == LoungeDefine.InteractionType.Chat)
		{
			CharacterGreet data = CoreUtils.GetData(storyId, RuntimeConfigs.data.characterGreets);
			if (data == null)
			{
				return string.Empty;
			}
			return LocalizationUtility.GetLocalizeString("longcommon", data.greetText);
		}
		LoungeStory data2 = CoreUtils.GetData(storyId, RuntimeConfigs.data.loungeStorys);
		if (data2 == null)
		{
			return string.Empty;
		}
		return LocalizationUtility.GetLocalizeString("longcommon", data2.storyText);
	}

	public static (Dictionary<string, AnimationClip>, CharacterIdel) GetRandomCharcterAnimClip(int characterId, int pointId)
	{
		EntityCharacterData data = CoreUtils.GetData(characterId, RuntimeConfigs.data.entityCharacterDatas);
		List<CharacterIdel> list = new List<CharacterIdel>();
		List<float> list2 = new List<float>();
		int num = CharacterSkinRuntimeUtility.ResolveSkinId(characterId);
		foreach (CharacterIdel value4 in RuntimeConfigs.data.characterIdels.Values)
		{
			if (value4.characterId == num && value4.pointId == pointId)
			{
				list.Add(value4);
				list2.Add(value4.weight);
			}
		}
		if (list.Count == 0 && list2.Count == 0)
		{
			num = characterId;
			foreach (CharacterIdel value5 in RuntimeConfigs.data.characterIdels.Values)
			{
				if (value5.characterId == num && value5.pointId == pointId)
				{
					list.Add(value5);
					list2.Add(value5.weight);
				}
			}
		}
		CharacterIdel characterIdel = WeightedRandom(list, list2);
		if (characterIdel != null)
		{
			string address = characterIdel.address;
			if (!string.IsNullOrEmpty(address))
			{
				string text = data.config;
				if (!string.IsNullOrEmpty(text) && text.Length >= 2)
				{
					text = $"{text.Substring(0, text.Length - 2)}{num % 100:D2}";
				}
				string assetID = string.Format("{0}@{1}_{2}", text, address, "LoungeIdle");
				string assetID2 = string.Format("{0}@{1}_{2}", text, address, "LoungeLeaveInteract");
				string assetID3 = string.Format("{0}@{1}_{2}", text, address, "LoungeTurnToInteract");
				Dictionary<string, AnimationClip> dictionary = new Dictionary<string, AnimationClip>();
				AssetLoadHandle assetLoadHandle = AssetStationManager.BattleStation.Load<AnimationClip>(assetID);
				if (assetLoadHandle.IsValid && assetLoadHandle.Result is AnimationClip value)
				{
					dictionary["LoungeIdle"] = value;
				}
				AssetLoadHandle assetLoadHandle2 = AssetStationManager.BattleStation.Load<AnimationClip>(assetID2);
				if (assetLoadHandle2.IsValid && assetLoadHandle2.Result is AnimationClip value2)
				{
					dictionary["LoungeLeaveInteract"] = value2;
				}
				AssetLoadHandle assetLoadHandle3 = AssetStationManager.BattleStation.Load<AnimationClip>(assetID3);
				if (assetLoadHandle3.IsValid && assetLoadHandle3.Result is AnimationClip value3)
				{
					dictionary["LoungeTurnToInteract"] = value3;
				}
				if (dictionary.Count > 0)
				{
					return (dictionary, characterIdel);
				}
			}
		}
		return (null, null);
	}

	public static string FormatTimeSpan(TimeSpan timeSpan)
	{
		if (timeSpan.TotalMinutes < 1.0)
		{
			return $"{(int)timeSpan.TotalSeconds}秒";
		}
		if (timeSpan.TotalHours < 1.0)
		{
			return $"{(int)timeSpan.TotalMinutes}分钟";
		}
		if (timeSpan.TotalDays < 1.0)
		{
			return $"{(int)timeSpan.TotalHours}小时";
		}
		return $"{(int)timeSpan.TotalDays}天";
	}

	public static string GetGreetingByTime()
	{
		int hour = System.DateTime.Now.Hour;
		if (hour >= 5 && hour < 12)
		{
			return "早上好";
		}
		if (hour >= 12 && hour < 14)
		{
			return "中午好";
		}
		if (hour >= 14 && hour < 18)
		{
			return "下午好";
		}
		if (hour >= 18 && hour < 22)
		{
			return "晚上好";
		}
		return "深夜了，要注意休息哦";
	}

	public static T RandomElement<T>(List<T> list)
	{
		if (list == null || list.Count == 0)
		{
			return default;
		}
		return list[UnityEngine.Random.Range(0, list.Count)];
	}

	public static T WeightedRandom<T>(List<T> items, List<float> weights)
	{
		if (items == null || items.Count == 0 || weights == null || weights.Count != items.Count)
		{
			return default;
		}
		float num = 0f;
		foreach (float weight in weights)
		{
			num += weight;
		}
		float num2 = UnityEngine.Random.Range(0f, num);
		float num3 = 0f;
		for (int i = 0; i < items.Count; i++)
		{
			num3 += weights[i];
			if (num2 <= num3)
			{
				return items[i];
			}
		}
		return items[items.Count - 1];
	}

	public static bool IsSpecialDate(System.DateTime date, out string specialDateName)
	{
		specialDateName = string.Empty;
		if (date.Month == 2 && date.Day == 14)
		{
			specialDateName = "情人节";
			return true;
		}
		if (date.Month == 12 && date.Day == 25)
		{
			specialDateName = "圣诞节";
			return true;
		}
		if (date.Month == 1 && date.Day == 1)
		{
			specialDateName = "新年";
			return true;
		}
		return false;
	}

	public static string FormatNumber(int number)
	{
		if (number < 1000)
		{
			return number.ToString();
		}
		if (number < 1000000)
		{
			return $"{(float)number / 1000f:F1}K";
		}
		return $"{(float)number / 1000000f:F1}M";
	}

	public static bool IsValidCharacterName(string name)
	{
		if (string.IsNullOrEmpty(name))
		{
			return false;
		}
		if (name.Length < 2 || name.Length > 20)
		{
			return false;
		}
		return true;
	}
}
