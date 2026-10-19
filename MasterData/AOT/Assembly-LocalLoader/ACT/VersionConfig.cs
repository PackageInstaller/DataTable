namespace ACT;

public struct VersionConfig
{
	public int AssetVersion;

	public int DllVersion;

	public int ClientStaticVersion;

	public int RawFileVersion;

	public bool Equals(VersionConfig other)
	{
		if (AssetVersion != other.AssetVersion)
		{
			return false;
		}
		if (DllVersion != other.DllVersion)
		{
			return false;
		}
		if (ClientStaticVersion != other.ClientStaticVersion)
		{
			return false;
		}
		if (RawFileVersion != other.RawFileVersion)
		{
			return false;
		}
		return true;
	}

	public VersionConfig(int assetVersion, int dllVersion, int clientStaticVersion, int rawFileVersion)
	{
		AssetVersion = assetVersion;
		DllVersion = dllVersion;
		ClientStaticVersion = clientStaticVersion;
		RawFileVersion = rawFileVersion;
	}
}
