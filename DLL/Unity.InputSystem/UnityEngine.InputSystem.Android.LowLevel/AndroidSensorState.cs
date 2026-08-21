using System;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

namespace UnityEngine.InputSystem.Android.LowLevel;

internal struct AndroidSensorState : IInputStateTypeInfo
{
	public static FourCC kFormat = new FourCC('A', 'S', 'S');

	[InputControl(name = "rotation", layout = "Quaternion", processors = "AndroidCompensateRotation", variants = "GeomagneticRotationVector")]
	[InputControl(name = "stepCounter", layout = "Integer", variants = "StepCounter")]
	[InputControl(name = "ambientTemperature", layout = "Axis", variants = "AmbientTemperature")]
	[InputControl(name = "relativeHumidity", layout = "Axis", variants = "RelativeHumidity")]
	[InputControl(name = "attitude", layout = "Quaternion", processors = "AndroidCompensateRotation", variants = "RotationVector")]
	[InputControl(name = "acceleration", layout = "Vector3", processors = "AndroidCompensateDirection", variants = "LinearAcceleration")]
	[InputControl(name = "lightLevel", layout = "Axis", variants = "Light")]
	[InputControl(name = "distance", layout = "Axis", variants = "Proximity")]
	[InputControl(name = "atmosphericPressure", layout = "Axis", variants = "Pressure")]
	[InputControl(name = "angularVelocity", layout = "Vector3", processors = "CompensateDirection", variants = "Gyroscope")]
	[InputControl(name = "magneticField", layout = "Vector3", variants = "MagneticField")]
	[InputControl(name = "rate", layout = "Axis", variants = "HeartRate")]
	[InputControl(name = "gravity", layout = "Vector3", processors = "AndroidCompensateDirection", variants = "Gravity")]
	[InputControl(name = "acceleration", layout = "Vector3", processors = "AndroidCompensateDirection", variants = "Accelerometer")]
	public unsafe fixed float data[16];

	public FourCC format => kFormat;

	public unsafe AndroidSensorState WithData(params float[] data)
	{
		if (data == null)
		{
			throw new ArgumentNullException("data");
		}
		for (int i = 0; i < data.Length && i < 16; i++)
		{
			this.data[i] = data[i];
		}
		for (int j = data.Length; j < 16; j++)
		{
			this.data[j] = 0f;
		}
		return this;
	}
}
