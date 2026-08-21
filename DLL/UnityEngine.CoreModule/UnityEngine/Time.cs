using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Input/TimeManager.h")]
[StaticAccessor(/*Could not decode attribute arguments.*/)]
public class Time
{
	[NativeProperty("CurTime")]
	public static extern float time
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeProperty("CurTime")]
	public static extern double timeAsDouble
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeProperty("TimeSinceSceneLoad")]
	public static extern float timeSinceLevelLoad
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeProperty("TimeSinceSceneLoad")]
	public static extern double timeSinceLevelLoadAsDouble
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern float deltaTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern float fixedTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeProperty("FixedTime")]
	public static extern double fixedTimeAsDouble
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern float unscaledTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeProperty("UnscaledTime")]
	public static extern double unscaledTimeAsDouble
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern float fixedUnscaledTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeProperty("FixedUnscaledTime")]
	public static extern double fixedUnscaledTimeAsDouble
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern float unscaledDeltaTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern float fixedUnscaledDeltaTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern float fixedDeltaTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern float maximumDeltaTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern float smoothDeltaTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern float maximumParticleDeltaTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern float timeScale
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int frameCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeProperty("RenderFrameCount")]
	public static extern int renderedFrameCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeProperty("Realtime")]
	public static extern float realtimeSinceStartup
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[NativeProperty("Realtime")]
	public static extern double realtimeSinceStartupAsDouble
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern float captureDeltaTime
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static int captureFramerate
	{
		get
		{
			return (captureDeltaTime != 0f) ? ((int)Mathf.Round(1f / captureDeltaTime)) : 0;
		}
		set
		{
			captureDeltaTime = ((value == 0) ? 0f : (1f / (float)value));
		}
	}

	public static extern bool inFixedTimeStep
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("IsUsingFixedTimeStep")]
		get;
	}
}
