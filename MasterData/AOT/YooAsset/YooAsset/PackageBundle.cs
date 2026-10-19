using System;
using System.Collections.Generic;
using System.Linq;

namespace YooAsset;

[Serializable]
internal class PackageBundle
{
	public string BundleName;

	public uint UnityCRC;

	public string FileHash;

	public string FileCRC;

	public long FileSize;

	public bool Encrypted;

	public string[] Tags;

	public string DownloadTag;

	public int[] DependBundleIDs;

	private int _bundleType;

	private string _fileName;

	private string _fileExtension;

	[NonSerialized]
	public readonly List<PackageAsset> IncludeMainAssets = new List<PackageAsset>(10);

	[NonSerialized]
	public readonly List<int> ReferenceBundleIDs = new List<int>(10);

	private readonly HashSet<int> _referenceBundleIDs = new HashSet<int>();

	private PackageManifest _mainfest;

	private List<string> _debugReferenceBundles;

	public string BundleGUID => FileHash;

	public int BundleType => _bundleType;

	public string FileName
	{
		get
		{
			if (string.IsNullOrEmpty(_fileName))
			{
				throw new Exception("Should never get here !");
			}
			return _fileName;
		}
	}

	public string FileExtension
	{
		get
		{
			if (string.IsNullOrEmpty(_fileExtension))
			{
				throw new Exception("Should never get here !");
			}
			return _fileExtension;
		}
	}

	public void InitBundle(PackageManifest manifest)
	{
		_mainfest = manifest;
		_bundleType = manifest.BuildBundleType;
		_fileExtension = ManifestTools.GetRemoteBundleFileExtension(BundleName);
		_fileName = ManifestTools.GetRemoteBundleFileName(manifest.OutputNameStyle, BundleName, _fileExtension, FileHash);
	}

	public void AddReferenceBundleID(int bundleID)
	{
		if (!_referenceBundleIDs.Contains(bundleID))
		{
			_referenceBundleIDs.Add(bundleID);
			ReferenceBundleIDs.Add(bundleID);
		}
	}

	public bool HasTag(string[] tags)
	{
		if (tags == null || tags.Length == 0)
		{
			return false;
		}
		if (Tags == null || Tags.Length == 0)
		{
			return false;
		}
		foreach (string value in tags)
		{
			if (Tags.Contains(value))
			{
				return true;
			}
		}
		return false;
	}

	public bool HasAnyTags()
	{
		if (Tags != null && Tags.Length != 0)
		{
			return true;
		}
		return false;
	}

	public bool HasDownloadTag(string downloadTag)
	{
		if (string.IsNullOrEmpty(downloadTag))
		{
			return false;
		}
		if (string.IsNullOrEmpty(DownloadTag))
		{
			return false;
		}
		return DownloadTag == downloadTag;
	}

	public bool Equals(PackageBundle otherBundle)
	{
		if (FileHash == otherBundle.FileHash)
		{
			return true;
		}
		return false;
	}

	public List<string> GetDebugReferenceBundles()
	{
		if (_debugReferenceBundles == null)
		{
			_debugReferenceBundles = new List<string>(ReferenceBundleIDs.Count);
			foreach (int referenceBundleID in ReferenceBundleIDs)
			{
				PackageBundle packageBundle = _mainfest.BundleList[referenceBundleID];
				_debugReferenceBundles.Add(packageBundle.BundleName);
			}
		}
		return _debugReferenceBundles;
	}
}
