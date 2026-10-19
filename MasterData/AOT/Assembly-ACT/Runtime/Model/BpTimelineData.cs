using System;
using ACT;
using Unity.VisualScripting;

namespace Runtime.Model;

[Serializable]
[Inspectable]
public struct BpTimelineData
{
	[Inspectable]
	public YooAssetReference assetReference;
}
