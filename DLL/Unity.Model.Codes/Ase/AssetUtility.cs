using GameFramework;
using UnityEngine;

namespace Ase;

public static class AssetUtility
{
	public static Vector2 ScreenSize = new Vector2(2400f, 1080f);

	public static string GetResourceUIFormAsset(string assetName)
	{
		return Utility.Text.Format("UI/UIForms/{0}", assetName);
	}

	public static string GetConfigAsset(string assetName, LoadType loadType)
	{
		return Utility.Text.Format("Assets/Art/Configs/{0}.{1}", assetName, (loadType == LoadType.Text) ? "txt" : "bytes");
	}

	public static string GetBattleViewConfigAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/BattleViewConfig/{0}", assetName);
	}

	public static string GetDataTableAsset(string assetName, LoadType loadType)
	{
		return Utility.Text.Format("Assets/Art/DataTables/{0}.{1}", assetName, (loadType == LoadType.Text) ? "txt" : "bytes");
	}

	public static string GetDictionaryAsset(string assetName, LoadType loadType)
	{
		return Utility.Text.Format("Assets/Art/Localization/{0}/Dictionaries/{1}.{2}", GameEntry.Localization.Language.ToString(), assetName, (loadType == LoadType.Text) ? "xml" : "bytes");
	}

	public static string GetFontAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/Fonts/{0}.ttf", assetName);
	}

	public static string GetUISprite(string spritePath)
	{
		return Utility.Text.Format("Assets/Art/UI/UISprites/{0}", spritePath);
	}

	public static string GetFGImageSprite(string spritePath)
	{
		return Utility.Text.Format("Assets/Art/Timeline/Assets/Texture/FGImage/{0}", spritePath);
	}

	public static string GetTimelineImageSprite(string spritePath)
	{
		return Utility.Text.Format("Assets/Art/Timeline/Assets/Texture/Image/{0}", spritePath);
	}

	public static string GetTimelineSmallImageSprite(string spritePath)
	{
		return Utility.Text.Format("Assets/Art/Timeline/Assets/Texture/SmallImage/{0}", spritePath);
	}

	public static string GetStoryImageSprite(string spritePath)
	{
		return Utility.Text.Format("Assets/Art/Story/Assets/Image/{0}", spritePath);
	}

	public static string GetStorySpine(string spinePath)
	{
		return Utility.Text.Format("Assets/Art/Story/GameObject/Spine/{0}.prefab", spinePath);
	}

	public static string GetTextureIconSprite(string spritePath)
	{
		return Utility.Text.Format("Assets/Art/Textures/ItemIcons/{0}", spritePath);
	}

	public static string GetUIItemAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/UI/UIItems/{0}.prefab", assetName);
	}

	public static string GetCodeAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/Codes/{0}.bytes", assetName);
	}

	public static string GetSceneAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/Scenes/{0}.unity", assetName);
	}

	public static string GetMusicAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/Audio/{0}.{1}", assetName, "bytes");
	}

	public static string GetSoundAsset(string assetName, bool mp3 = true)
	{
		return Utility.Text.Format("Assets/Art/Sounds/{0}.{1}", assetName, mp3 ? "mp3" : "wav");
	}

	public static string GetUIFormAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/UI/UIForms/{0}", assetName);
	}

	public static string GetUIEffectAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/UI/UIEffects/LoadEffects/{0}.prefab", assetName);
	}

	public static string GetUISoundAsset(string assetName, bool mp3 = true)
	{
		return Utility.Text.Format("Assets/Art/UI/UISounds/{0}.{1}", assetName, mp3 ? "mp3" : "wav");
	}

	public static string GetTextureAsset(string assetName, string affix = "png")
	{
		if (assetName.EndsWith(".png"))
		{
			return Utility.Text.Format("Assets/Art/Textures/{0}", assetName);
		}
		return Utility.Text.Format("Assets/Art/Textures/{0}.{1}", assetName, affix);
	}

	public static string GetCopyMapDataAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/MapData/Copy/{0}.prefab", assetName);
	}

	public static string GetLevelMapDataAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/MapData/Level/{0}.prefab", assetName);
	}

	public static string GetActivityMapDataAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/MapData/Activity/{0}.asset", assetName);
	}

	public static string GetActivityMapDataPrefab(string assetName)
	{
		return Utility.Text.Format("Assets/Art/MapData/Activity/{0}.prefab", assetName);
	}

	public static string GetCampaignMapDataAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/MapData/Campaign/{0}.asset", assetName);
	}

	public static string GetStoryAsset(string assetPath)
	{
		return Utility.Text.Format("Assets/{0}", assetPath);
	}

	public static string GetTeachGuideAsset(string assetPath)
	{
		return Utility.Text.Format("Assets/Art/Textures/Copy/CopyGuide/{0}.png", assetPath);
	}

	public static string GetGuideVideoPrefab(string assetPath)
	{
		return Utility.Text.Format("Assets/Art/UI/GuideVideo/{0}.prefab", assetPath);
	}

	public static string GetHeroSkillCameraSkinVideoPrefab(string assetPath)
	{
		return Utility.Text.Format("Assets/Art/UI/HeroSkillCameraSkinVideo/{0}.prefab", assetPath);
	}

	public static string GetTimeLineAsset(string assetPath)
	{
		return Utility.Text.Format("Assets/Art/Timeline/{0}", assetPath);
	}

	public static string GetIllustratedGuideNPCHeadAvatar(string assetName)
	{
		return Utility.Text.Format("Assets/Art/Timeline/Assets/Texture/FGImage/Emotion/{0}", assetName);
	}

	public static string GetDynamicDecorationPrefab(string assetPath)
	{
		return Utility.Text.Format("Assets/Art/UI/DynamicDecoration/{0}.prefab", assetPath);
	}

	public static string GetParadoxAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/Paradoxs/{0}.prefab", assetName);
	}

	public static string GetSkillTimeLineAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/Entities/{0}.prefab", assetName);
	}

	public static string GetEntityAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/Entities/{0}.prefab", assetName);
	}
}
