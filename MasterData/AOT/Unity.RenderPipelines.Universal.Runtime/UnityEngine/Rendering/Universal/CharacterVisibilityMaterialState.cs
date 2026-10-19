namespace UnityEngine.Rendering.Universal;

public static class CharacterVisibilityMaterialState
{
	private static readonly int s_VisibilityModeId = Shader.PropertyToID("_VisibilityMode");

	public static bool SetEffect(Material material, CharacterVisibilityEffect effect)
	{
		if (!IsSupported(material))
		{
			return false;
		}
		if (effect < CharacterVisibilityEffect.None || effect > CharacterVisibilityEffect.Dissolve2)
		{
			effect = CharacterVisibilityEffect.None;
		}
		VisibilityMaterialKeywords.SetEffectKeywords(material, effect);
		if (!Mathf.Approximately(material.GetFloat(s_VisibilityModeId), (float)effect))
		{
			material.SetFloat(s_VisibilityModeId, (float)effect);
		}
		return true;
	}

	private static bool IsSupported(Material material)
	{
		if (material != null)
		{
			return material.HasProperty(s_VisibilityModeId);
		}
		return false;
	}
}
