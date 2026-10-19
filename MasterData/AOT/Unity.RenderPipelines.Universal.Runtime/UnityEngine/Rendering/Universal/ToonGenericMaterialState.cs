namespace UnityEngine.Rendering.Universal;

public static class ToonGenericMaterialState
{
	private const string k_AlphaTestKeyword = "_ALPHATEST_ON";

	private const string k_DitherKeyword = "_DITHER_ON";

	private const string k_DissolveKeyword = "_DISSOLVE_ON";

	private const string k_DepthOnlyLightMode = "DepthOnly";

	private static readonly int s_VisibilityModeId = Shader.PropertyToID("_VisibilityMode");

	private static readonly int s_SceneGBufferZTestId = Shader.PropertyToID("_SceneGBufferZTest");

	public static bool SetDitherEnabled(Material material, bool enabled)
	{
		if (!IsSupported(material))
		{
			return false;
		}
		CharacterVisibilityEffect effect = (enabled ? CharacterVisibilityEffect.Dither : (material.IsKeywordEnabled("_DISSOLVE_ON") ? CharacterVisibilityEffect.Dissolve : CharacterVisibilityEffect.None));
		return SetEffect(material, effect);
	}

	public static bool SetDissolveEnabled(Material material, bool enabled)
	{
		if (!IsSupported(material))
		{
			return false;
		}
		CharacterVisibilityEffect effect = (enabled ? CharacterVisibilityEffect.Dissolve : (material.IsKeywordEnabled("_DITHER_ON") ? CharacterVisibilityEffect.Dither : CharacterVisibilityEffect.None));
		return SetEffect(material, effect);
	}

	public static bool SetEffect(Material material, CharacterVisibilityEffect effect)
	{
		if (!IsSupported(material))
		{
			return false;
		}
		if (effect != CharacterVisibilityEffect.Dither && effect != CharacterVisibilityEffect.Dissolve)
		{
			effect = CharacterVisibilityEffect.None;
		}
		VisibilityMaterialKeywords.SetEffectKeywords(material, effect);
		if (!Mathf.Approximately(material.GetFloat(s_VisibilityModeId), (float)effect))
		{
			material.SetFloat(s_VisibilityModeId, (float)effect);
		}
		SynchronizePreZState(material);
		return true;
	}

	private static bool IsSupported(Material material)
	{
		if (material != null && material.HasProperty(s_VisibilityModeId))
		{
			return material.HasProperty(s_SceneGBufferZTestId);
		}
		return false;
	}

	private static bool SynchronizePreZState(Material material)
	{
		if (!IsSupported(material))
		{
			return false;
		}
		bool result = false;
		bool flag = RequiresPreZ(material);
		if (material.GetShaderPassEnabled("DepthOnly") != flag)
		{
			material.SetShaderPassEnabled("DepthOnly", flag);
			result = true;
		}
		float num = (flag ? 3f : 4f);
		if (!Mathf.Approximately(material.GetFloat(s_SceneGBufferZTestId), num))
		{
			material.SetFloat(s_SceneGBufferZTestId, num);
			result = true;
		}
		return result;
	}

	private static bool RequiresPreZ(Material material)
	{
		if (!material.IsKeywordEnabled("_ALPHATEST_ON") && !material.IsKeywordEnabled("_DITHER_ON"))
		{
			return material.IsKeywordEnabled("_DISSOLVE_ON");
		}
		return true;
	}
}
