using System;

namespace YooAsset;

public class AssetInfo
{
	internal enum ELoadMethod
	{
		None,
		LoadAsset,
		LoadSubAssets,
		LoadAllAssets,
		LoadScene,
		LoadRawFile
	}

	private readonly PackageAsset _packageAsset;

	private string _providerGUID;

	internal ELoadMethod LoadMethod;

	public string PackageName { get; private set; }

	public Type AssetType { get; private set; }

	public string Error { get; private set; }

	internal PackageAsset Asset => _packageAsset;

	internal string GUID
	{
		get
		{
			if (!string.IsNullOrEmpty(_providerGUID))
			{
				return _providerGUID;
			}
			if (AssetType == null)
			{
				_providerGUID = "[" + AssetPath + "][null]";
			}
			else
			{
				_providerGUID = "[" + AssetPath + "][" + AssetType.Name + "]";
			}
			return _providerGUID;
		}
	}

	public bool IsInvalid => _packageAsset == null;

	public string Address
	{
		get
		{
			if (_packageAsset == null)
			{
				return string.Empty;
			}
			return _packageAsset.Address;
		}
	}

	public string AssetPath
	{
		get
		{
			if (_packageAsset == null)
			{
				return string.Empty;
			}
			return _packageAsset.AssetPath;
		}
	}

	internal AssetInfo(string packageName, PackageAsset packageAsset, Type assetType)
	{
		if (packageAsset == null)
		{
			throw new Exception("Should never get here !");
		}
		_providerGUID = string.Empty;
		_packageAsset = packageAsset;
		PackageName = packageName;
		AssetType = assetType;
		Error = string.Empty;
	}

	internal AssetInfo(string packageName, string error)
	{
		_providerGUID = string.Empty;
		_packageAsset = null;
		PackageName = packageName;
		AssetType = null;
		Error = error;
	}
}
