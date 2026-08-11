namespace GameFramework;

public static class AssetUtility
{
	public static string GetResourceUIFormAsset(string assetName)
	{
		return Utility.Text.Format("UI/UIForms/{0}", assetName);
	}

	public static string GetLanguageAsset(string assetName)
	{
		return Utility.Text.Format("Assets/Art/Localization/{0}.csv", assetName);
	}

	public static string GetLanguagesSource(string assetName)
	{
		return Utility.Text.Format("Assets/Art/Localization/{0}.asset", assetName);
	}
}
