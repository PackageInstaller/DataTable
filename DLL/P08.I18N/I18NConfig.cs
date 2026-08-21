using System.Collections.Generic;
using UnityEngine;

public class I18NConfig
{
	public static string instructionBookUrl = "https://wiki.in.ys4fun.com/pages/viewpage.action?pageId=152279288";

	public static string languageS = "zh_cn";

	public static string deleteVersion = "";

	public static string translateFilePathForRefreshChangedTextI18NKey = "";

	public static string statisticFilePathOfRefreshChangedTextI18NKey = "/../../config/Output/Function/TranslateCSV/TMP/refresh_changed_text_I18NKey_statistic.csv";

	public static string filePathForCheckComponentCfgBind = "/../../checkComponentCfgBind.txt";

	public static int serverIndex = 0;

	public static string[] serverList = new string[5] { "zh_cn", "en", "jp", "kr", "tw" };

	public static string[] languageNameList = new string[5] { "zh_cn", "en", "jp", "kr", "tc" };

	public static string[] differentAreaList = new string[4] { "en", "jp", "kr", "tw" };

	public static string differentAreaListStr = "en,jp,kr,tw";

	public static string[] UI_PREFAB_PATH_LIST = new string[6] { "Assets/ABResources/UI", "Assets/ABResources/DynamicSticker", "Assets/UIResources/UI_AB/Widget", "Assets/ABResources/GuildActivityUI", "Assets/ABResources/GuildActivitySPUI", "Assets/ABResources/CaptureGame" };

	public static string[] UI_TEXTURE_PATH_LIST = new string[3] { "Assets/ABResources", "Assets/ArtResources", "Assets/UIResources" };

	public static string[] FONT_PATH_LIST = new string[1] { "Assets/ABResources/Fonts" };

	public static string replacePrefabPath = "";

	public static string i18NImgMainFolder = "Assets/UIResources/UI_AB/I18NImg";

	public static string languageSuffixPattern = "@zh_cn|@en|@jp|@kr|@fr|@de|@tc";

	public static string[] invalidI18NImgFolder = new string[6] { "Assets/ArtResources/UI/Atlas/", "Assets/ABResources/UI/VersionUI/", "Assets/ABResources/Textures/", "Assets/UIResources/UI_AB/", "Assets/UIResources/UI_Art/", "Assets/ArtResources/Font/" };

	public static string skipCollectImgFolderPattern = "TextureConfig/Chat/ChatSticker|TextureConfig/Sticker|TextureConfig/Item_l|Assets/ABResources/Fonts";

	public static string skipCheckI18NPrefabPattern = "Assets/ABResources/DynamicSticker";

	public static List<string> languageList = new List<string> { "zh_cn", "en", "jp", "kr", "tc" };

	public static string[] languageSuffixList = new string[5] { "@zh_cn", "@en", "@jp", "@kr", "@tc" };

	public static string allTranslateFilePath = Application.dataPath + "/../../config/Source/策划数据源/系统配置/all_translate.csv";

	public static string translateDataSavePath = "Assets/ABResources/I18NTranslate/";

	public static string translateDebugDataSavePath = "Assets/ABResources/I18NTranslate/Debug/";

	public static int MAX_NUMBER_OF_SPLIT_TRANSLATE_DATA = 1024;

	public static string resultFilePathOfCheckingInvalidI18NResource = "/../../errorResourcesInfo.txt";

	public static string resultFilePathOfRecoverAllTranslate = "/../../config/Source/策划数据源/系统配置/TranslateCSV/TMP/recover_history_all_translate_statistic.csv";

	public static string batPathForReplaceChineseToI18NKey = "/../../config/导出本地化表.bat";

	public static string batPathForExportAllTranslate = "/../../config/Scripts/I18N/Bat/ExportI18NText.bat";

	public static string batPathForUpdateAllTranslate = "/../../config/Scripts/I18N/Bat/UpdateAllTranslate.bat";

	public static string batPathForImportAllTranslate = "/../../config/Scripts/I18N/Bat/ImportI18NText.bat";

	public static string batPathForCheckNeedTranslateCsv = "/../../config/Scripts/I18N/Bat/CheckNeedMarkTranslateTable.bat";

	public static string batPathForRecoverAllTranslate = "/../../config/Scripts/I18N/Bat/RecoverHistoryAllTranslate.bat";

	public static string batPathForFillDefaultTranslate = "/../../config/Scripts/I18N/Bat/FillDefaultTranslate.bat";
}
