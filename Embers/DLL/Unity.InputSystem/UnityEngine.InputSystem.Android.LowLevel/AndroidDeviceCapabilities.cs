using System;
using System.Linq;

namespace UnityEngine.InputSystem.Android.LowLevel;

[Serializable]
internal struct AndroidDeviceCapabilities
{
	public string deviceDescriptor;

	public int productId;

	public int vendorId;

	public bool isVirtual;

	public AndroidAxis[] motionAxes;

	public AndroidInputSource inputSources;

	public string ToJson()
	{
		return JsonUtility.ToJson((object)this);
	}

	public static AndroidDeviceCapabilities FromJson(string json)
	{
		if (json == null)
		{
			throw new ArgumentNullException("json");
		}
		return JsonUtility.FromJson<AndroidDeviceCapabilities>(json);
	}

	public override string ToString()
	{
		return string.Format("deviceDescriptor = {0}, productId = {1}, vendorId = {2}, isVirtual = {3}, motionAxes = {4}, inputSources = {5}", deviceDescriptor, productId, vendorId, isVirtual, (motionAxes == null) ? "<null>" : string.Join(",", motionAxes.Select((AndroidAxis i) => i.ToString()).ToArray()), inputSources);
	}
}
