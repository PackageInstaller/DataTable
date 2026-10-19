using System;

namespace ACT;

[Serializable]
internal class RemoteConfigResourceHotfixData
{
	public int version;

	public ZipInfo[] diff;
}
