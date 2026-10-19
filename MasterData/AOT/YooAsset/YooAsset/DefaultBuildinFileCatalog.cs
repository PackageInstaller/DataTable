using System;
using System.Collections.Generic;

namespace YooAsset;

[Serializable]
internal class DefaultBuildinFileCatalog
{
	[Serializable]
	public class FileWrapper
	{
		public string BundleGUID;

		public string FileName;
	}

	public string FileVersion;

	public string PackageName;

	public string PackageVersion;

	public List<FileWrapper> Wrappers = new List<FileWrapper>();
}
