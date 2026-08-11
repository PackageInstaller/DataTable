using System;
using System.Collections.Generic;

namespace UnityEngine.Rendering;

public static class CameraCaptureBridge
{
	private static Dictionary<Camera, HashSet<Action<RenderTargetIdentifier, CommandBuffer>>> actionDict = new Dictionary<Camera, HashSet<Action<RenderTargetIdentifier, CommandBuffer>>>();

	private static bool _enabled;

	public static bool enabled
	{
		get
		{
			return _enabled;
		}
		set
		{
			_enabled = value;
		}
	}

	public static IEnumerator<Action<RenderTargetIdentifier, CommandBuffer>> GetCaptureActions(Camera camera)
	{
		if (!actionDict.TryGetValue(camera, out var value) || value.Count == 0)
		{
			return null;
		}
		return value.GetEnumerator();
	}

	public static void AddCaptureAction(Camera camera, Action<RenderTargetIdentifier, CommandBuffer> action)
	{
		actionDict.TryGetValue(camera, out var value);
		if (value == null)
		{
			value = new HashSet<Action<RenderTargetIdentifier, CommandBuffer>>();
			actionDict.Add(camera, value);
		}
		value.Add(action);
	}

	public static void RemoveCaptureAction(Camera camera, Action<RenderTargetIdentifier, CommandBuffer> action)
	{
		if (!(camera == null) && actionDict.TryGetValue(camera, out var value))
		{
			value.Remove(action);
		}
	}
}
