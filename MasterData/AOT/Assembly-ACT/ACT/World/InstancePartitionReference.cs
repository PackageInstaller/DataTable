using System;

namespace ACT.World;

[Serializable]
internal class InstancePartitionReference : YooAssetReference<ConfigWorldPartition_v2>
{
	public InstancePartitionReference(string guid)
		: base(guid)
	{
	}
}
