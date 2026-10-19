using System;

namespace ACT.World;

[Serializable]
internal class SubWorldPartitionReference : YooAssetReference<ConfigWorldPartition_v2_SubworldData>
{
	public SubWorldPartitionReference(string guid)
		: base(guid)
	{
	}
}
