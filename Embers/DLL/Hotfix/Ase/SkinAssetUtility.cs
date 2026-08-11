namespace Ase;

public static class SkinAssetUtility
{
	public static string GetSkinConfigDataPath(int skinId)
	{
		return Utility.Text.Format("Assets/Art/SkinConfigData/Item_{0}", skinId);
	}

	public static string GetSkinImagePath()
	{
		return "Assets/Art/UI/UIItems/Battle/UISkin/Item_{0}/{1}.png";
	}

	public static string GetSkinEffectPath()
	{
		return "Assets/Art/UI/UIEffects/SkinEffect/Item_{0}/{1}.prefab";
	}

	public static string GetBossIcon(string icon)
	{
		return Utility.Text.Format("Assets/Art/Textures/CopyBossDefeat/{0}.png", icon);
	}

	public static string GetSkinHeadFrame(int skinId)
	{
		return Utility.Text.Format("Assets/Art/UI/UIItems/Battle/UISkin/Item_{0}/battle_roleframe.png", skinId);
	}

	public static string GetSkinBattleDSFrame(int skinId)
	{
		return Utility.Text.Format("Assets/Art/UI/UIItems/Battle/UISkin/Item_{0}/battle_desframe.png", skinId);
	}
}
