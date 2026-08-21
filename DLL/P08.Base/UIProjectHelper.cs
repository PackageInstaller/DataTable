using System.Collections.Generic;

public static class UIProjectHelper
{
	public const string CharPath = "Char/";

	public const string CharLightPath = "Char/1061ui_light";

	public static List<string> CharPathRemap = new List<string> { "ui_light", "ui_story", "ui_main", "ui_tpose", "tpose", "story" };

	public static List<string> CharPathRemapResult = new List<string> { "Char/1061ui_light", "Char/1061ui_story", "Char/1061ui_main", "Char/1061ui_tpose", "Char/1061_tpose", "Char/1061_story" };

	public const string WeaponPath = "Weapon/";

	public const string DefaultWeaponPath = "Weapon/1061ui_weapon";

	public static string RemapAssetPath(string path)
	{
		if (path.StartsWith("Char/"))
		{
			for (int i = 0; i < CharPathRemap.Count; i++)
			{
				if (path.Contains(CharPathRemap[i]))
				{
					return CharPathRemapResult[i];
				}
			}
			return "Char/1061ui_light";
		}
		if (path.StartsWith("Weapon/"))
		{
			return "Weapon/1061ui_weapon";
		}
		return path;
	}
}
