using System;
using System.Collections.Generic;
using UnityEngine.XR;

namespace UnityEngine.InputSystem.XR;

[Serializable]
public class XRDeviceDescriptor
{
	public string deviceName;

	public string manufacturer;

	public string serialNumber;

	public InputDeviceCharacteristics characteristics;

	public int deviceId;

	public List<XRFeatureDescriptor> inputFeatures;

	public string ToJson()
	{
		return JsonUtility.ToJson((object)this);
	}

	public static XRDeviceDescriptor FromJson(string json)
	{
		return JsonUtility.FromJson<XRDeviceDescriptor>(json);
	}
}
