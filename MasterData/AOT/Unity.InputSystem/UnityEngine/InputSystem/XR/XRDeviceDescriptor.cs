using System;
using System.Collections.Generic;

namespace UnityEngine.InputSystem.XR;

[Serializable]
public class XRDeviceDescriptor
{
	public string deviceName;

	public string manufacturer;

	public string serialNumber;

	[SerializeField]
	private uint characteristics;

	public int deviceId;

	public List<XRFeatureDescriptor> inputFeatures;

	public string ToJson()
	{
		return JsonUtility.ToJson(this);
	}

	public static XRDeviceDescriptor FromJson(string json)
	{
		return JsonUtility.FromJson<XRDeviceDescriptor>(json);
	}
}
