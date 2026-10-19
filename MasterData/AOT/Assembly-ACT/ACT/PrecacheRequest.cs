using Bamboo.AssetField;

namespace ACT;

public readonly struct PrecacheRequest(string assetKey, PrecacheKind kind, AssetLoadHandle handle = default(AssetLoadHandle))
{
	public readonly string AssetKey = assetKey;

	public readonly PrecacheKind Kind = kind;

	public readonly AssetLoadHandle Handle = handle;

	public string GetIdentity()
	{
		return $"{(int)Kind}:{AssetKey}";
	}
}
