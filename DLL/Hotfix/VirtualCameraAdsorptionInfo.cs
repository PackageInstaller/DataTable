using System;

[Serializable]
public struct VirtualCameraAdsorptionInfo(float maxHorizontalDistance = 12f, float maxVerticalDistance = 7f, float minHorizontalDistance = 18f, float minVerticalDistance = 10.5f)
{
	public float maxHorizontalDistance = maxHorizontalDistance;

	public float maxVerticalDistance = maxVerticalDistance;

	public float minHorizontalDistance = minHorizontalDistance;

	public float minVerticalDistance = minVerticalDistance;
}
