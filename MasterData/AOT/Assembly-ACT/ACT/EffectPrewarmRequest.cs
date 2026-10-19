namespace ACT;

public readonly struct EffectPrewarmRequest(string assetKey, int instanceCount, EffectPrewarmPriority priority, bool waitUntilReady, string sourceTag)
{
	public readonly string AssetKey = assetKey;

	public readonly int InstanceCount = instanceCount;

	public readonly EffectPrewarmPriority Priority = priority;

	public readonly bool WaitUntilReady = waitUntilReady;

	public readonly string SourceTag = sourceTag;
}
