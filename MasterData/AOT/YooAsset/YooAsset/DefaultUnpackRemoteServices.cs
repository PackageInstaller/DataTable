using System.Collections.Generic;

namespace YooAsset;

internal class DefaultUnpackRemoteServices : IRemoteServices
{
	private readonly string _buildinPackageRoot;

	protected readonly Dictionary<string, string> _mapping = new Dictionary<string, string>(10000);

	public DefaultUnpackRemoteServices(string buildinPackRoot)
	{
		_buildinPackageRoot = buildinPackRoot;
	}

	string IRemoteServices.GetRemoteMainURL(string fileName)
	{
		return GetFileLoadURL(fileName);
	}

	string IRemoteServices.GetRemoteFallbackURL(string fileName)
	{
		return GetFileLoadURL(fileName);
	}

	public string GetDeviceId()
	{
		return null;
	}

	private string GetFileLoadURL(string fileName)
	{
		if (!_mapping.TryGetValue(fileName, out var value))
		{
			value = DownloadSystemHelper.ConvertToWWWPath(PathUtility.Combine(_buildinPackageRoot, fileName));
			_mapping.Add(fileName, value);
		}
		return value;
	}
}
