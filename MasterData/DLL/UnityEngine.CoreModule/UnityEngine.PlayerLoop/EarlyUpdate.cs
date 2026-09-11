using System;
using System.Runtime.InteropServices;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.PlayerLoop;

[StructLayout(LayoutKind.Sequential, Size = 1)]
[MovedFrom("UnityEngine.Experimental.PlayerLoop")]
[RequiredByNativeCode]
public struct EarlyUpdate
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PollPlayerConnection
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PollHtcsPlayerConnection
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct GpuTimestamp
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct AnalyticsCoreStatsUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UnityWebRequestUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateStreamingManager
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ExecuteMainThreadJobs
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ProcessMouseInWindow
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ClearIntermediateRenderers
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ClearLines
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PresentBeforeUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ResetFrameStatsAfterPresent
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateAsyncReadbackManager
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateTextureStreamingManager
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdatePreloading
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateContentLoading
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateAsyncInstantiate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct RendererNotifyInvisible
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PlayerCleanupCachedData
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateMainGameViewRect
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateCanvasRectTransform
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateInputManager
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ProcessRemoteInput
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct XRUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ScriptRunDelayedStartupFrame
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateKinect
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct DeliverIosPlatformEvents
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct DispatchEventQueueEvents
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct Physics2DEarlyUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PhysicsResetInterpolatedTransformPosition
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct SpriteAtlasManagerUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	[Obsolete("TangoUpdate has been deprecated. Use ARCoreUpdate instead (UnityUpgradable) -> UnityEngine.PlayerLoop.EarlyUpdate/ARCoreUpdate", false)]
	public struct TangoUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ARCoreUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PerformanceAnalyticsUpdate
	{
	}
}
