using Unity.XR.GoogleVr;
using Unity.XR.Oculus.Input;
using Unity.XR.OpenVR;
using UnityEngine.InputSystem.Layouts;
using UnityEngine.XR.WindowsMR.Input;

namespace UnityEngine.InputSystem.XR;

internal static class XRSupport
{
	public static void Initialize()
	{
		InputSystem.RegisterLayout<PoseControl>("Pose");
		InputSystem.RegisterLayout<BoneControl>("Bone");
		InputSystem.RegisterLayout<EyesControl>("Eyes");
		InputSystem.RegisterLayout<XRHMD>();
		InputSystem.RegisterLayout<XRController>();
		InputSystem.onFindLayoutForDevice += XRLayoutBuilder.OnFindLayoutForDevice;
		InputSystem.RegisterLayout<WMRHMD>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("(Windows Mixed Reality HMD)|(Microsoft HoloLens)|(^(WindowsMR Headset))"));
		InputSystem.RegisterLayout<WMRSpatialController>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("(^(Spatial Controller))|(^(OpenVR Controller\\(WindowsMR))"));
		InputSystem.RegisterLayout<HololensHand>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("(^(Hand -))"));
		InputSystem.RegisterLayout<OculusHMD>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("^(Oculus Rift)|^(Oculus Quest)|^(Oculus Go)"));
		InputSystem.RegisterLayout<OculusTouchController>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("(^(Oculus Touch Controller))|(^(Oculus Quest Controller))"));
		InputSystem.RegisterLayout<OculusRemote>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("Oculus Remote"));
		InputSystem.RegisterLayout<OculusTrackingReference>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("((Tracking Reference)|(^(Oculus Rift [a-zA-Z0-9]* \\(Camera)))"));
		InputSystem.RegisterLayout<OculusHMDExtended>("GearVR", default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("Oculus HMD"));
		InputSystem.RegisterLayout<GearVRTrackedController>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("^(Oculus Tracked Remote)"));
		InputSystem.RegisterLayout<DaydreamHMD>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("Daydream HMD"));
		InputSystem.RegisterLayout<DaydreamController>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("^(Daydream Controller)"));
		InputSystem.RegisterLayout<OpenVRHMD>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("^(OpenVR Headset)|^(Vive Pro)"));
		InputSystem.RegisterLayout<OpenVRControllerWMR>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("^(OpenVR Controller\\(WindowsMR)"));
		InputSystem.RegisterLayout<ViveWand>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithManufacturer("HTC").WithProduct("^(OpenVR Controller\\(((Vive. Controller)|(VIVE. Controller)|(Vive Controller)))"));
		InputSystem.RegisterLayout<OpenVROculusTouchController>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithProduct("^(OpenVR Controller\\(Oculus)"));
		InputSystem.RegisterLayout<ViveTracker>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithManufacturer("HTC").WithProduct("^(VIVE Tracker)"));
		InputSystem.RegisterLayout<HandedViveTracker>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithManufacturer("HTC").WithProduct("^(OpenVR Controller\\(VIVE Tracker)"));
		InputSystem.RegisterLayout<ViveLighthouse>(null, default(InputDeviceMatcher).WithInterface("^(XRInput)").WithManufacturer("HTC").WithProduct("^(HTC V2-XD/XE)"));
	}
}
