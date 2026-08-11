using System;
using System.Collections.Generic;

namespace UnityEngine.InputSystem.XR;

[Serializable]
public struct XRFeatureDescriptor
{
	public string name;

	public List<UsageHint> usageHints;

	public FeatureType featureType;

	public uint customSize;
}
