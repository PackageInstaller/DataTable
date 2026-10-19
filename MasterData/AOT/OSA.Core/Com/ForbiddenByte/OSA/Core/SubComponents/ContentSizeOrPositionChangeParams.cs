namespace Com.ForbiddenByte.OSA.Core.SubComponents;

internal struct ContentSizeOrPositionChangeParams
{
	public bool cancelSnappingIfAny;

	public bool fireScrollPositionChangedEvent;

	public bool keepVelocity;

	public bool allowOutsideBounds;

	public bool contentEndEdgeStationary;

	internal double? contentInsetOverride;

	public ComputeVisibilityParams computeVisibilityParams;
}
