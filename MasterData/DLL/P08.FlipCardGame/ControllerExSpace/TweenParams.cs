using System;

namespace ControllerExSpace;

[Serializable]
public struct TweenParams
{
	public int propertyIndex;

	public float duration;

	public LeanTweenType ease;

	public GearType type;

	public int runtimeTweenId;
}
