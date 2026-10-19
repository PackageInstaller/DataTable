namespace UnityEngine.Rendering.Universal;

internal static class ShaderPassTags
{
	internal static readonly ShaderTagId UniversalGBuffer = new ShaderTagId("UniversalGBuffer");

	internal static readonly ShaderTagId SceneGBuffer = new ShaderTagId("SceneGBuffer");

	internal static readonly ShaderTagId CharacterGBuffer = new ShaderTagId("CharacterGBuffer");

	internal static readonly ShaderTagId GBufferHair = new ShaderTagId("GBufferHair");

	internal static readonly ShaderTagId GBufferHairOverEye = new ShaderTagId("GBufferHairOverEye");

	internal static readonly ShaderTagId GBufferHairOpaque = new ShaderTagId("GBufferHairOpaque");

	internal static readonly ShaderTagId CharacterGBufferOutline = new ShaderTagId("CharacterGBufferOutline");

	internal static readonly ShaderTagId PlantGBuffer = new ShaderTagId("PlantGBuffer");

	internal static readonly ShaderTagId DepthOnly = new ShaderTagId("DepthOnly");

	internal static readonly ShaderTagId CharacterHairDepthOnly = new ShaderTagId("CharacterHairDepthOnly");

	internal static readonly ShaderTagId CharacterDepthOnlyOutline = new ShaderTagId("CharacterDepthOnlyOutline");

	internal static readonly ShaderTagId TransPreZ = new ShaderTagId("TransPreZ");

	internal static readonly ShaderTagId UniversalForward = new ShaderTagId("UniversalForward");

	internal static readonly ShaderTagId UniversalForwardSecondary = new ShaderTagId("UniversalForwardSecondary");

	internal static readonly ShaderTagId UniversalForwardOnly = new ShaderTagId("UniversalForwardOnly");

	internal static readonly ShaderTagId ForwardOnlySecondary = new ShaderTagId("ForwardOnlySecondary");

	internal static readonly ShaderTagId TransparentOutline = new ShaderTagId("TransparentOutline");

	internal static readonly ShaderTagId ForwardOnlyHairShadow = new ShaderTagId("ForwardOnlyHairShadow");

	internal static readonly ShaderTagId SRPDefaultUnlit = new ShaderTagId("SRPDefaultUnlit");

	internal static readonly ShaderTagId[] ForwardShaderTags = new ShaderTagId[6] { UniversalForward, UniversalForwardSecondary, UniversalForwardOnly, ForwardOnlySecondary, TransparentOutline, SRPDefaultUnlit };

	internal static readonly ShaderTagId[] ForwardShaderTagsWithoutCharacterOutline = new ShaderTagId[5] { UniversalForward, UniversalForwardSecondary, UniversalForwardOnly, ForwardOnlySecondary, SRPDefaultUnlit };

	internal static readonly ShaderTagId[] DeferredForwardOnlyShaderTags = new ShaderTagId[4] { UniversalForwardOnly, ForwardOnlySecondary, ForwardOnlyHairShadow, SRPDefaultUnlit };

	internal static readonly ShaderTagId[] DeferredForwardOnlyShaderTagsWithoutHairShadow = new ShaderTagId[3] { UniversalForwardOnly, ForwardOnlySecondary, SRPDefaultUnlit };
}
