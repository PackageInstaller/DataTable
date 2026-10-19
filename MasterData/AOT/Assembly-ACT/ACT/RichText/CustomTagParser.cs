using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;
using ACT.Config;
using ACT.Core;
using ACT.Utility;
using Bamboo.NumberString;
using Fundamental;
using UnityEngine;

namespace ACT.RichText;

public class CustomTagParser
{
	public delegate string DelegateTagParse(Match match);

	public const string Error = "String Not Found!";

	private static StringBuilder _timeDescrptionBuilder = new StringBuilder();

	private static Dictionary<string, int> _indexMap = new Dictionary<string, int>
	{
		{ "N", 0 },
		{ "M", 1 },
		{ "L", 2 },
		{ "P", 3 },
		{ "Q", 4 },
		{ "R", 5 },
		{ "S", 6 },
		{ "T", 7 }
	};

	public static ACTCustomTagConfig TagConfig => GameLoader.meta.actTagConfig;

	public static string MatchCustomRichText(string input, DelegateTagParse callback)
	{
		string text = input;
		foreach (ACTCustomTagConfig.CustomTag customTag in TagConfig.CustomTags)
		{
			string pattern = customTag.startTag + "(.*?)" + customTag.endTag;
			text = Regex.Replace(text, pattern, (Match match) => callback(match) ?? "");
		}
		return text;
	}

	public static string ReplaceSkillMessageText(int skillMessageId, string tableName, bool isBrief = true, int currentLevel = 1, int nextLevel = 0)
	{
		SkillDetailMessageData data = CoreUtils.GetData(skillMessageId, RuntimeConfigs.data.skillDetailMessageDatas);
		if (data != null)
		{
			try
			{
				string localizeString = LocalizationUtility.GetLocalizeString(tableName, isBrief ? data.briefDescLocal : data.detailDescLocal, isSmart: false);
				return ReplaceText(data.skillid, localizeString, currentLevel, nextLevel);
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
				return string.Empty;
			}
		}
		return string.Empty;
	}

	public static string ReplaceText(int skillId, string input, int currentLevel, int nextLevel = 0)
	{
		try
		{
			return MatchCustomRichText(input, (Match match) =>
			{
				SkillDetailData skillDetailData = RuntimeConfigs.data.skillDetailDatas[skillId];
				Match match2 = Regex.Match(match.Value, "{(.*?):(.*?)}");
				Match match3 = Regex.Match(match.Value, "<calculate>(.*?)</calculate:(.*?)>");
				if (match2.Success)
				{
					if (match2.Groups[1].Value.Equals("level"))
					{
						if (!GameUtility.GetSkillGroupLevel(int.Parse(match2.Groups[2].Value), out var level))
						{
							return "String Not Found!";
						}
						return level.ToString();
					}
					string format = string.Empty;
					float num = 0f;
					if (!match2.Groups[1].Value.StartsWith("param"))
					{
						for (int i = 0; i < skillDetailData.validParam.Length; i++)
						{
							if (skillDetailData.validParam[i].Equals(match2.Groups[1].Value))
							{
								int num2 = skillId * 100 + currentLevel + nextLevel;
								SkillDetailLevelData data = CoreUtils.GetData(num2, RuntimeConfigs.data.skillDetailLevelDatas);
								if (data != null && data.param != null && data.param.Length > i)
								{
									num = data.param[i];
									format = "{0:" + $"{match2.Groups[2]}" + "}";
									break;
								}
								return "String Not Found!" + $"skillDetailLevelDatas Id为{num2} 的 param数量和skillDetailDatas 的 validparam 数量对应不上！策划检查表！";
							}
						}
					}
					else
					{
						for (int j = 0; j < skillDetailData.validParam1.Length; j++)
						{
							if (skillDetailData.validParam1[j].Equals(match2.Groups[1].Value))
							{
								int num3 = skillId * 100 + currentLevel + nextLevel;
								SkillDetailLevelData data2 = CoreUtils.GetData(num3, RuntimeConfigs.data.skillDetailLevelDatas);
								if (data2 != null && data2.param1 != null && data2.param1.Length > j)
								{
									num = data2.param1[j];
									format = "{0:" + $"{match2.Groups[2]}" + "}";
									break;
								}
								return "String Not Found!" + $"skillDetailLevelDatas Id为{num3} 的 param1数量和skillDetailDatas 的 validparam1 数量对应不上！策划检查表！";
							}
						}
					}
					return string.Format(format, num);
				}
				if (match3.Success)
				{
					try
					{
						double num4 = AlgorithmUtility.CalculateReturnDouble(match3.Groups[1].Value);
						if (string.IsNullOrEmpty(match3.Groups[2].Value))
						{
							_ = LuminApplication.LogEnabled;
							return $"{num4:#0%}";
						}
						return string.Format("{0:" + match3.Groups[2].Value + "}", num4);
					}
					catch (Exception)
					{
						if (LuminApplication.LogEnabled)
						{
							Debug.LogError(match3.Groups[1].Value + " 不符合四则运算语法！");
						}
					}
				}
				for (int k = 0; k < skillDetailData.validParam.Length - 1; k++)
				{
					if (skillDetailData.validParam[k].Equals(match.Groups[2].Value))
					{
						int key = skillId * 100 + currentLevel + nextLevel;
						return RuntimeConfigs.data.skillDetailLevelDatas[key].param[k].ToString(CultureInfo.InvariantCulture);
					}
				}
				for (int l = 0; l < skillDetailData.validParam1.Length - 1; l++)
				{
					if (skillDetailData.validParam1[l].Equals(match.Groups[2].Value))
					{
						int key2 = skillId * 100 + currentLevel + nextLevel;
						return RuntimeConfigs.data.skillDetailLevelDatas[key2].param1[l].ToString(CultureInfo.InvariantCulture);
					}
				}
				return "String Not Found!";
			});
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(message);
			}
		}
		return "String Not Found!";
	}

	public static string ReplacePreconditionText(Mission missionData, int count, int[] param)
	{
		if (missionData.missionDescription != 0)
		{
			string localizeString = LocalizationUtility.GetLocalizeString("longcommon", missionData.missionDescription, isSmart: false);
			if (!string.IsNullOrEmpty(localizeString))
			{
				return localizeString;
			}
		}
		PreconditionData data = CoreUtils.GetData(missionData.preconditionId, RuntimeConfigs.data.preconditionDatas);
		if (data == null)
		{
			return "String Not Found!";
		}
		try
		{
			string localizeString2 = LocalizationUtility.GetLocalizeString("longcommon", data.desId, isSmart: false);
			List<string> list = ListPool<string>.Get();
			list.Add(count.FastToString());
			ReplaceLocalizeText(missionData.preconditionId, count, param, list);
			string result = ReplacePreconditionText(localizeString2, count, param, list);
			ListPool<string>.Release(list);
			return result;
		}
		catch (Exception arg)
		{
			Debug.LogError($"PreConditionID {missionData.preconditionId} 发生错误:{arg}");
			return "String Not Found!";
		}
	}

	private static void ReplaceLocalizeText(int preconditionID, int count, int[] param, List<string> paramNames)
	{
		switch (preconditionID)
		{
		case 1:
		{
			MissionBase data21 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.missionBases);
			if (data21 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data21.name));
			}
			break;
		}
		case 6:
		{
			ItemData data13 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.itemDatas);
			if (data13 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data13.nameLocal));
			}
			break;
		}
		case 7:
		{
			int id = ((param != null && param.Length > 0) ? param[0] : 0);
			ItemType data10 = CoreUtils.GetData(id, RuntimeConfigs.data.itemTypes);
			if (data10 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data10.typeLocal));
			}
			ItemQuality data11 = CoreUtils.GetData(id, RuntimeConfigs.data.itemQualitys);
			if (data11 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data11.name));
			}
			break;
		}
		case 12:
		{
			ItemData data24 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.itemDatas);
			if (data24 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data24.nameLocal));
			}
			break;
		}
		case 13:
		{
			AbyssData data17 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.abyssDatas);
			if (data17 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data17.abyssNameLocal));
			}
			break;
		}
		case 16:
		{
			RaidTypeDes data4 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.raidTypeDess);
			if (data4 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data4.typeDes));
			}
			break;
		}
		case 18:
		{
			TimeSpan timeSpan = TimeSpan.FromSeconds(count);
			int num3 = timeSpan.Hours + timeSpan.Days * 24;
			int minutes = timeSpan.Minutes;
			int seconds = timeSpan.Seconds;
			string text3 = string.Empty;
			if (num3 > 0 && minutes > 0)
			{
				text3 += string.Format("{0}{1}", num3, LocalizationUtility.GetLocalizeString("Common", 41000109));
				text3 += string.Format("{0}{1}", minutes, LocalizationUtility.GetLocalizeString("Common", 41000110));
			}
			else if (num3 > 0 && minutes == 0)
			{
				text3 += string.Format("{0}{1}", num3, LocalizationUtility.GetLocalizeString("Common", 41000109));
			}
			else if (num3 == 0 && minutes > 0 && seconds > 0)
			{
				text3 += string.Format("{0}{1}", minutes, LocalizationUtility.GetLocalizeString("Common", 41000110));
				text3 += string.Format("{0}{1}", seconds, LocalizationUtility.GetLocalizeString("Common", 624));
			}
			else if (num3 == 0 && minutes > 0 && seconds == 0)
			{
				text3 += string.Format("{0}{1}", minutes, LocalizationUtility.GetLocalizeString("Common", 41000110));
			}
			else if (num3 == 0 && minutes == 0 && seconds > 0)
			{
				text3 += string.Format("{0}{1}", seconds, LocalizationUtility.GetLocalizeString("Common", 624));
			}
			paramNames[0] = text3;
			break;
		}
		case 25:
		{
			MapArea data14 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.mapAreas);
			if (data14 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data14.name));
			}
			break;
		}
		case 28:
		{
			EntityData data3 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.entityDatas);
			if (data3 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data3.nameLocal));
			}
			break;
		}
		case 29:
		{
			ActivityData data16 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.activityDatas);
			if (data16 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data16.activityName));
			}
			break;
		}
		case 33:
		{
			ItemData data20 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.itemDatas);
			if (data20 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data20.nameLocal));
			}
			break;
		}
		case 39:
		{
			ItemQuality data8 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.itemQualitys);
			if (data8 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data8.name));
			}
			break;
		}
		case 41:
		{
			StateObjectGroup data5 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.stateObjectGroups);
			if (data5 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data5.groupName));
			}
			break;
		}
		case 42:
		{
			Raid data19 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.raids);
			if (data19 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data19.raidName));
			}
			break;
		}
		case 44:
		{
			RaidEntranceData data9 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.raidEntranceDatas);
			if (data9 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data9.entranceName));
			}
			break;
		}
		case 45:
		{
			MissionBase data18 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.missionBases);
			if (data18 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data18.name));
			}
			break;
		}
		case 47:
		{
			AreaStateObject data12 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.areaStateObjects);
			if (data12 != null)
			{
				int name = CoreUtils.GetData(data12.id, RuntimeConfigs.data.mapAreas).name;
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", name));
			}
			break;
		}
		case 48:
		{
			AreaStateObject data6 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.areaStateObjects);
			if (data6 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data6.id));
			}
			break;
		}
		case 52:
		{
			RaidTypeDes data22 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.raidTypeDess);
			if (data22 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data22.typeDes));
			}
			break;
		}
		case 54:
		{
			ItemQuality data15 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.itemQualitys);
			if (data15 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data15.monsterName));
			}
			break;
		}
		case 55:
		{
			Raid data7 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.raids);
			if (data7 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data7.raidName));
			}
			break;
		}
		case 101:
		{
			HandBookMain data23 = CoreUtils.GetData((param != null && param.Length > 0) ? param[0] : 0, RuntimeConfigs.data.handBookMains);
			if (data23 != null)
			{
				paramNames.Add(LocalizationUtility.GetLocalizeString("shortcommon", data23.contentLv1name));
			}
			switch (count)
			{
			case 0:
				paramNames[0] = LocalizationUtility.GetLocalizeString("Common", 2605);
				break;
			case 1:
				paramNames[0] = LocalizationUtility.GetLocalizeString("Common", 2606);
				break;
			case 2:
				paramNames[0] = LocalizationUtility.GetLocalizeString("Common", 2607);
				break;
			}
			break;
		}
		case 116:
		{
			int num = ((param != null && param.Length > 0) ? param[0] : 0);
			MapArea data = CoreUtils.GetData(num, RuntimeConfigs.data.mapAreas);
			string text = ((data == null) ? num.FastToString() : LocalizationUtility.GetLocalizeString("shortcommon", data.name));
			paramNames.Add(string.IsNullOrEmpty(text) ? num.FastToString() : text);
			int num2 = ((param != null && param.Length > 1) ? param[1] : 0);
			StateObjectType data2 = CoreUtils.GetData(num2, RuntimeConfigs.data.stateObjectTypes);
			string text2 = ((data2 == null) ? num2.FastToString() : LocalizationUtility.GetLocalizeString("shortcommon", data2.typeName));
			paramNames.Add(string.IsNullOrEmpty(text2) ? num2.FastToString() : text2);
			break;
		}
		}
	}

	public static string ReplacePreconditionText(string inputString, int count, int[] param, List<string> paramName)
	{
		Dictionary<string, int> paramName_Value = DictionaryPool<string, int>.Get();
		try
		{
			return MatchCustomRichText(inputString, (Match match) =>
			{
				Match match2 = Regex.Match(match.Value, "{(.*?)}");
				Match match3 = Regex.Match(match.Value, "<hideIf:(.*?)>(.*?)</hideIf>");
				if (match2.Success)
				{
					Group obj = match2.Groups[1];
					int num = _indexMap[obj.Value];
					int value = ((num == 0) ? count : ((param != null && param.Length > num - 1) ? param[num - 1] : 0));
					paramName_Value[obj.Value] = value;
					if (paramName != null && paramName.Count > 0 && paramName.Count > num)
					{
						return paramName[num];
					}
					return value.FastToString();
				}
				if (match3.Success)
				{
					Match match4 = Regex.Match(match3.Groups[1].Value, "([A-Z])(==|!=|>=|<=|>|<)(-?\\d+)");
					if (match4.Success)
					{
						int num2 = paramName_Value[match4.Groups[1].Value];
						int num3 = int.Parse(match4.Groups[3].Value);
						switch (match4.Groups[2].Value)
						{
						case "==":
							if (num2 == num3)
							{
								return string.Empty;
							}
							break;
						case "!=":
							if (num2 != num3)
							{
								return string.Empty;
							}
							break;
						case ">=":
							if (num2 >= num3)
							{
								return string.Empty;
							}
							break;
						case "<=":
							if (num2 <= num3)
							{
								return string.Empty;
							}
							break;
						case "<":
							if (num2 < num3)
							{
								return string.Empty;
							}
							break;
						case ">":
							if (num2 > num3)
							{
								return string.Empty;
							}
							break;
						}
						return match3.Groups[2].Value;
					}
				}
				return "String Not Found!";
			});
		}
		finally
		{
			DictionaryPool<string, int>.Release(paramName_Value);
		}
	}

	public static string ReplaceBattleRuleDataText(Rules rules, int count, int[] param)
	{
		if (rules.missionDescription > 0)
		{
			string localizeString = LocalizationUtility.GetLocalizeString("longcommon", rules.missionDescription, isSmart: false);
			if (!string.IsNullOrEmpty(localizeString))
			{
				return localizeString;
			}
		}
		BattleRulesData data = CoreUtils.GetData(rules.rulesId, RuntimeConfigs.data.battleRulesDatas);
		if (data == null)
		{
			return "String Not Found!";
		}
		try
		{
			string localizeString2 = LocalizationUtility.GetLocalizeString("longcommon", data.desId, isSmart: false);
			List<string> list = ListPool<string>.Get();
			list.Add(count.FastToString());
			ReplaceBattleRuleText(rules.rulesId, count, param, list);
			string result = ReplacePreconditionText(localizeString2, count, param, list);
			ListPool<string>.Release(list);
			return result;
		}
		catch (Exception arg)
		{
			Debug.LogError($"替换BattleRulesData {rules.rulesId} 描述 发生错误:{arg}");
			return "String Not Found!";
		}
	}

	public static void ReplaceBattleRuleText(int battleRuleId, int count, int[] param, List<string> paramNames)
	{
		switch (battleRuleId)
		{
		case 2:
		case 31:
		case 40:
		case 45:
			paramNames[0] = GetTimeDescription(count);
			break;
		case 4:
		{
			string item3 = $"<sprite index={param[0] - 1}>";
			paramNames.Add(item3);
			break;
		}
		case 6:
		case 7:
			paramNames.Add(GetBattleRuleMonsterLevelName(param));
			break;
		case 9:
			paramNames.Add(GetBattleRuleMonsterLevelName(param));
			break;
		case 12:
		{
			int num = ((param != null && param.Length > 0) ? param[0] : 0);
			string item = num.FastToString();
			if (RuntimeConfigs.data?.entityDatas != null && RuntimeConfigs.data.entityDatas.TryGetValue(num, out var value))
			{
				string localizeString = LocalizationUtility.GetLocalizeString("shortcommon", value.nameLocal);
				if (!string.IsNullOrEmpty(localizeString))
				{
					item = localizeString;
				}
			}
			paramNames.Add(item);
			int num2 = ((param != null && param.Length > 1) ? param[1] : 0);
			string item2 = num2.FastToString();
			if (RuntimeConfigs.data?.stateNames != null && RuntimeConfigs.data.stateNames.TryGetValue(num2, out var value2))
			{
				string[] nodeID = value2.nodeID;
				if (nodeID != null && nodeID.Length > 0)
				{
					item2 = string.Join("/", value2.nodeID);
				}
			}
			paramNames.Add(item2);
			break;
		}
		}
	}

	private static string GetBattleRuleMonsterLevelName(int[] param)
	{
		int num = ((param != null && param.Length > 0) ? param[0] : 0);
		switch (num)
		{
		case 0:
		case 1:
		case 2:
			return LocalizationUtility.GetLocalizeString("Common", 1077);
		case 6:
			return LocalizationUtility.GetLocalizeString("Common", 1076);
		case 3:
			return LocalizationUtility.GetLocalizeString("Common", 38);
		default:
			return num.FastToString();
		}
	}

	public static string GetTimeDescription(int totalSecond)
	{
		if (totalSecond <= 0)
		{
			return string.Empty;
		}
		int num = totalSecond / 3600;
		int num2 = totalSecond / 60;
		int num3 = totalSecond % 60;
		_timeDescrptionBuilder.Clear();
		if (num > 0)
		{
			_timeDescrptionBuilder.Append(num);
			_timeDescrptionBuilder.Append(LocalizationUtility.GetLocalizeString("Common", 41000109));
		}
		if (num2 > 0)
		{
			_timeDescrptionBuilder.Append(num2);
			_timeDescrptionBuilder.Append(LocalizationUtility.GetLocalizeString("Common", 623));
		}
		if (num <= 0 && num3 > 0)
		{
			_timeDescrptionBuilder.Append(num3);
			_timeDescrptionBuilder.Append(LocalizationUtility.GetLocalizeString("Common", 624));
		}
		return _timeDescrptionBuilder.ToString();
	}
}
