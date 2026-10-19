namespace UnityEngine.Rendering.Universal;

public static class VisibilityMaterialKeywords
{
	private const string k_DitherKeyword = "_DITHER_ON";

	private const string k_DissolveKeyword = "_DISSOLVE_ON";

	private const string k_Dissolve2Keyword = "_DISSOLVE2_ON";

	public static bool SetEffectKeywords(Material material, CharacterVisibilityEffect effect)
	{
		if (material == null)
		{
			return false;
		}
		if (effect < CharacterVisibilityEffect.None || effect > CharacterVisibilityEffect.Dissolve2)
		{
			effect = CharacterVisibilityEffect.None;
		}
		SetKeyword(material, "_DITHER_ON", effect == CharacterVisibilityEffect.Dither);
		SetKeyword(material, "_DISSOLVE_ON", effect == CharacterVisibilityEffect.Dissolve);
		SetKeyword(material, "_DISSOLVE2_ON", effect == CharacterVisibilityEffect.Dissolve2);
		return true;
	}

	public static bool SetDitherKeyword(Material material, bool enabled)
	{
		return SetSingleKeyword(material, "_DITHER_ON", CharacterVisibilityEffect.Dither, enabled);
	}

	public static bool SetDissolveKeyword(Material material, bool enabled)
	{
		return SetSingleKeyword(material, "_DISSOLVE_ON", CharacterVisibilityEffect.Dissolve, enabled);
	}

	public static bool SetDissolve2Keyword(Material material, bool enabled)
	{
		return SetSingleKeyword(material, "_DISSOLVE2_ON", CharacterVisibilityEffect.Dissolve2, enabled);
	}

	private static bool SetSingleKeyword(Material material, string keyword, CharacterVisibilityEffect enabledEffect, bool enabled)
	{
		if (material == null)
		{
			return false;
		}
		if (enabled)
		{
			return SetEffectKeywords(material, enabledEffect);
		}
		SetKeyword(material, keyword, enabled: false);
		return true;
	}

	private static void SetKeyword(Material material, string keyword, bool enabled)
	{
		if (material.IsKeywordEnabled(keyword) != enabled)
		{
			if (enabled)
			{
				material.EnableKeyword(keyword);
			}
			else
			{
				material.DisableKeyword(keyword);
			}
		}
	}
}
