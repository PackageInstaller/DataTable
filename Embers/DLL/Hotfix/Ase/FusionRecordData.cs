using System;
using System.Collections.Generic;

namespace Ase;

[Serializable]
public struct FusionRecordData
{
	public bool openMix;

	public float touchInterval;

	public List<FusionRecordEntryData> multiSkeletonFusionList;

	public List<FusionRecordEntryData> multiSkeletonIdleList;
}
