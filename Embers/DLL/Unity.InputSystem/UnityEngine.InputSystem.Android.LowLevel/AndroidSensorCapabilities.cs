using System;

namespace UnityEngine.InputSystem.Android.LowLevel;

[Serializable]
internal struct AndroidSensorCapabilities
{
	public AndroidSensorType sensorType;

	public string ToJson()
	{
		return JsonUtility.ToJson((object)this);
	}

	public static AndroidSensorCapabilities FromJson(string json)
	{
		if (json == null)
		{
			throw new ArgumentNullException("json");
		}
		return JsonUtility.FromJson<AndroidSensorCapabilities>(json);
	}

	public override string ToString()
	{
		return "type = " + sensorType;
	}
}
