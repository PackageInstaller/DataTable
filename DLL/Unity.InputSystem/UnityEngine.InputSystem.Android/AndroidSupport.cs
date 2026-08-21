using System.Linq;
using UnityEngine.InputSystem.Android.LowLevel;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem.Android;

internal class AndroidSupport
{
	internal const string kAndroidInterface = "Android";

	public static void Initialize()
	{
		InputSystem.RegisterLayout<AndroidGamepad>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidGameController"));
		InputSystem.RegisterLayout<AndroidJoystick>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidGameController"));
		InputSystem.RegisterLayout<DualShock4GamepadAndroid>();
		InputSystem.RegisterLayout<XboxOneGamepadAndroid>();
		InputSystem.RegisterLayout<AndroidGamepadWithDpadAxes>();
		InputSystem.RegisterLayout<AndroidGamepadWithDpadButtons>();
		InputSystem.RegisterProcessor<AndroidCompensateDirectionProcessor>();
		InputSystem.RegisterProcessor<AndroidCompensateRotationProcessor>();
		InputSystem.RegisterLayout<AndroidAccelerometer>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidSensor").WithCapability("sensorType", AndroidSensorType.Accelerometer));
		InputSystem.RegisterLayout<AndroidMagneticFieldSensor>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidSensor").WithCapability("sensorType", AndroidSensorType.MagneticField));
		InputSystem.RegisterLayout<AndroidGyroscope>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidSensor").WithCapability("sensorType", AndroidSensorType.Gyroscope));
		InputSystem.RegisterLayout<AndroidLightSensor>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidSensor").WithCapability("sensorType", AndroidSensorType.Light));
		InputSystem.RegisterLayout<AndroidPressureSensor>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidSensor").WithCapability("sensorType", AndroidSensorType.Pressure));
		InputSystem.RegisterLayout<AndroidProximity>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidSensor").WithCapability("sensorType", AndroidSensorType.Proximity));
		InputSystem.RegisterLayout<AndroidGravitySensor>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidSensor").WithCapability("sensorType", AndroidSensorType.Gravity));
		InputSystem.RegisterLayout<AndroidLinearAccelerationSensor>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidSensor").WithCapability("sensorType", AndroidSensorType.LinearAcceleration));
		InputSystem.RegisterLayout<AndroidRotationVector>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidSensor").WithCapability("sensorType", AndroidSensorType.RotationVector));
		InputSystem.RegisterLayout<AndroidRelativeHumidity>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidSensor").WithCapability("sensorType", AndroidSensorType.RelativeHumidity));
		InputSystem.RegisterLayout<AndroidAmbientTemperature>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidSensor").WithCapability("sensorType", AndroidSensorType.AmbientTemperature));
		InputSystem.RegisterLayout<AndroidStepCounter>(null, default(InputDeviceMatcher).WithInterface("Android").WithDeviceClass("AndroidSensor").WithCapability("sensorType", AndroidSensorType.StepCounter));
		InputSystem.onFindLayoutForDevice += OnFindLayoutForDevice;
	}

	internal static string OnFindLayoutForDevice(ref InputDeviceDescription description, string matchedLayout, InputDeviceExecuteCommandDelegate executeCommandDelegate)
	{
		if (!string.IsNullOrEmpty(matchedLayout) && matchedLayout != "AndroidGamepad" && matchedLayout != "AndroidJoystick")
		{
			return null;
		}
		if (description.interfaceName != "Android" || string.IsNullOrEmpty(description.capabilities))
		{
			return null;
		}
		if (description.deviceClass == "AndroidGameController")
		{
			AndroidDeviceCapabilities androidDeviceCapabilities = AndroidDeviceCapabilities.FromJson(description.capabilities);
			if ((androidDeviceCapabilities.inputSources & AndroidInputSource.Gamepad) != AndroidInputSource.Gamepad)
			{
				return "AndroidJoystick";
			}
			if (androidDeviceCapabilities.motionAxes == null)
			{
				return "AndroidGamepadWithDpadButtons";
			}
			if (androidDeviceCapabilities.motionAxes.Contains(AndroidAxis.Z) && androidDeviceCapabilities.motionAxes.Contains(AndroidAxis.Rz) && androidDeviceCapabilities.motionAxes.Contains(AndroidAxis.HatX) && androidDeviceCapabilities.motionAxes.Contains(AndroidAxis.HatY))
			{
				if (androidDeviceCapabilities.vendorId == 1118)
				{
					return "XboxOneGamepadAndroid";
				}
				if (androidDeviceCapabilities.vendorId == 1356)
				{
					return "DualShock4GamepadAndroid";
				}
			}
			if (androidDeviceCapabilities.motionAxes.Contains(AndroidAxis.HatX) && androidDeviceCapabilities.motionAxes.Contains(AndroidAxis.HatY))
			{
				return "AndroidGamepadWithDpadAxes";
			}
			return "AndroidGamepadWithDpadButtons";
		}
		return null;
	}
}
