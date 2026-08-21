using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public static class HeroDefinition
{
	public enum HeroIconType
	{
		SquareSmall,
		CardHorizontal,
		RectangleHorizontal,
		BoardIcon,
		Upgrade,
		Card,
		BattleAvatar
	}

	public static List<DRHeroInfo> GetOuterHeroConfigs()
	{
		DRHeroInfo[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroInfo p) => p.IsOpening);
		if (dataRows != null)
		{
			return dataRows.ToList();
		}
		return new List<DRHeroInfo>();
	}

	public static int GetHeroSkinShopMainId()
	{
		return GameEntry.DataTable.GetDataRow((DRMainShopList p) => p.ShopPosition == 4)?.Id ?? 0;
	}

	public static string GetHeroOriginalPath(int heroId, string skinSuffix, bool useLanguageSetting = false)
	{
		DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(heroId);
		if (dataRow == null)
		{
			return string.Empty;
		}
		string text = ((useLanguageSetting && Singleton<AudioSystem>.Instance.AudioLanguage != AudioLanguageEnum.defaultLanguage) ? ("_" + Singleton<AudioSystem>.Instance.AudioLanguage) : "");
		return dataRow.Original + skinSuffix + text;
	}

	public static DRVoice GetHeroSkinVoiceConfig(int heroId, int heroSkinId, int voiceType)
	{
		DRVoice dataRow = GameEntry.DataTable.GetDataRow((DRVoice p) => p.ObjectId == heroId && p.HeroSkinId == heroSkinId && p.Type == voiceType);
		if (dataRow == null)
		{
			DRHeroInfo drHeroInfo = GameEntry.DataTable.GetDataRow<DRHeroInfo>(heroId);
			if (drHeroInfo != null)
			{
				dataRow = GameEntry.DataTable.GetDataRow((DRVoice p) => p.ObjectId == heroId && p.HeroSkinId == drHeroInfo.InitialHeroSkin && p.Type == voiceType);
			}
		}
		return dataRow;
	}

	public static string GetHeroIconPath(HeroIconType type, int heroId, int skin = 0)
	{
		string text = ((skin < 10) ? $"0{skin}" : skin.ToString());
		string s = heroId + text;
		string skinSuffix = $"_{skin}";
		int skinConfigId = int.Parse(s);
		return GetHeroIconPath(type, heroId, skinSuffix, skinConfigId);
	}

	public static string GetHeroIconPath(HeroIconType type, HeroModel heroModel)
	{
		if (!heroModel.IsNullOrEmpty())
		{
			return GetHeroIconPath(type, heroModel.Id, heroModel.SkinSuffix, heroModel.SkinConfigId);
		}
		return "";
	}

	public static string GetHeroIconPath(HeroIconType type, BattleHeroData battleHeroData)
	{
		if (battleHeroData?.HeroModel == null)
		{
			return "";
		}
		int id = battleHeroData.HeroModel.Id;
		string skinSuffix = battleHeroData.HeroModel.SkinSuffix;
		int skinConfigId = battleHeroData.HeroModel.SkinConfigId;
		return GetHeroIconPath(type, id, skinSuffix, skinConfigId);
	}

	public static string GetHeroIconPath(HeroIconType type, int heroId, string skinSuffix, int skinConfigId)
	{
		return StreamerMode.GetHeroHeadIcon(GetHeroIconPath(type, heroId, skinSuffix), skinConfigId);
	}

	private static string GetHeroIconPath(HeroIconType type, int heroId, string skinSuffix)
	{
		return type switch
		{
			HeroIconType.SquareSmall => $"{heroId}_SmallIcon{skinSuffix}", 
			HeroIconType.CardHorizontal => $"{heroId}_CardHor{skinSuffix}", 
			HeroIconType.RectangleHorizontal => $"{heroId}_Rectangle{skinSuffix}", 
			HeroIconType.BoardIcon => $"{heroId}_BoardIcon", 
			HeroIconType.Upgrade => $"{heroId}_Upgrade{skinSuffix}", 
			HeroIconType.Card => $"{heroId}_Card{skinSuffix}", 
			HeroIconType.BattleAvatar => $"BattleAvatar{heroId}{skinSuffix}", 
			_ => "", 
		};
	}
}
