using Bamboo.AssetField;
using YooAsset;

namespace ACT;

public static class AssetIdExtension
{
	private static ResourcePackage _package;

	public static bool RuntimeKeyIsValid(this AssetID assetId)
	{
		string gUID = assetId.GUID;
		if (string.IsNullOrEmpty(gUID))
		{
			return false;
		}
		if (_package == null)
		{
			_package = YooAssets.GetPackage("Assets");
		}
		return _package.CheckLocationValid(gUID);
	}
}
