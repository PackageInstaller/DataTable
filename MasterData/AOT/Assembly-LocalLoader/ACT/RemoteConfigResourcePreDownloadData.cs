using System;

namespace ACT;

[Serializable]
internal class RemoteConfigResourcePreDownloadData
{
	public int version;

	public ZipInfo[] diff;
}
