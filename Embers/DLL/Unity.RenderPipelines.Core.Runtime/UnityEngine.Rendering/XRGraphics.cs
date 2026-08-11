using System;
using UnityEngine.XR;

namespace UnityEngine.Rendering;

[Serializable]
public class XRGraphics
{
	public enum StereoRenderingMode
	{
		MultiPass,
		SinglePass,
		SinglePassInstanced,
		SinglePassMultiView
	}

	public static float eyeTextureResolutionScale
	{
		get
		{
			if (enabled)
			{
				return XRSettings.eyeTextureResolutionScale;
			}
			return 1f;
		}
		set
		{
			XRSettings.eyeTextureResolutionScale = value;
		}
	}

	public static float renderViewportScale
	{
		get
		{
			if (enabled)
			{
				return XRSettings.renderViewportScale;
			}
			return 1f;
		}
	}

	public static bool enabled => XRSettings.enabled;

	public static bool isDeviceActive
	{
		get
		{
			if (enabled)
			{
				return XRSettings.isDeviceActive;
			}
			return false;
		}
	}

	public static string loadedDeviceName
	{
		get
		{
			if (enabled)
			{
				return XRSettings.loadedDeviceName;
			}
			return "No XR device loaded";
		}
	}

	public static string[] supportedDevices
	{
		get
		{
			if (enabled)
			{
				return XRSettings.supportedDevices;
			}
			return new string[1];
		}
	}

	public static StereoRenderingMode stereoRenderingMode
	{
		get
		{
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_000d: Expected I4, but got Unknown
			if (enabled)
			{
				return (StereoRenderingMode)XRSettings.stereoRenderingMode;
			}
			return StereoRenderingMode.SinglePass;
		}
	}

	public static RenderTextureDescriptor eyeTextureDesc
	{
		get
		{
			if (enabled)
			{
				return XRSettings.eyeTextureDesc;
			}
			return new RenderTextureDescriptor(0, 0);
		}
	}

	public static int eyeTextureWidth
	{
		get
		{
			if (enabled)
			{
				return XRSettings.eyeTextureWidth;
			}
			return 0;
		}
	}

	public static int eyeTextureHeight
	{
		get
		{
			if (enabled)
			{
				return XRSettings.eyeTextureHeight;
			}
			return 0;
		}
	}
}
