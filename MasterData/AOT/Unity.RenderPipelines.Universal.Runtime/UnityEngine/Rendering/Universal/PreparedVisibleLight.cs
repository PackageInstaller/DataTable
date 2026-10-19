namespace UnityEngine.Rendering.Universal;

internal struct PreparedVisibleLight
{
	internal UniversalAdditionalLightData additionalData;

	internal Vector4 position;

	internal Vector4 color;

	internal Vector4 attenuation;

	internal Vector4 spotDirection;

	internal Vector4 actData;

	internal Vector4 actData2;

	internal Vector4 actData3;

	internal float range;

	internal float spotAngle;

	internal int layerMask;

	internal LightType lightType;
}
