namespace UnityEngine.Rendering.Universal.Internal;

internal enum StencilUsage
{
	CharacterBody = 1,
	CharacterFace = 2,
	CharacterHair = 3,
	CharacterRelationMask = CharacterHair,
	CharacterOutline = 4,
	TransparentBodyMask = 8,
	CharacterEyeMask = 16,
	UserMask = 31,
	StencilLight = 128,
	MaterialMask = 96,
	DeferredScene = MaterialMask,
	DeferredCharacter = 32,
	DeferredPlant = 64,
	MaterialUnlit = DeferredPlant,
	MaterialLit = DeferredCharacter,
	MaterialSimpleLit = 0
}
