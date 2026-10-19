using System;

namespace ACT;

[Serializable]
internal class RemoteConfigResourceNormalData
{
	public int version;

	public ZipInfo[] full;

	public ZipInfo[] diff;
}
