using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering;

public static class CameraCaptureBridge
{
	private static Dictionary<Camera, HashSet<Action<RenderTargetIdentifier, CommandBuffer>>> actionDict = new Dictionary<Camera, HashSet<Action<RenderTargetIdentifier, CommandBuffer>>>();

	private static bool _enabled;

	public static bool enabled
	{
		set
		{
			_enabled = value;
		}
	}
}
