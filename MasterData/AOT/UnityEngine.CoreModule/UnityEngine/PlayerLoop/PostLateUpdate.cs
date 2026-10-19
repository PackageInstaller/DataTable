using System.Runtime.InteropServices;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine.PlayerLoop;

[StructLayout(LayoutKind.Sequential, Size = 1)]
[MovedFrom("UnityEngine.Experimental.PlayerLoop")]
[RequiredByNativeCode]
public struct PostLateUpdate
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PlayerSendFrameStarted
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateRectTransform
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateCanvasRectTransform
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PlayerUpdateCanvases
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateAudio
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateVideo
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct DirectorLateUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ScriptRunDelayedDynamicFrameRate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct VFXUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ParticleSystemEndUpdateAll
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct EndGraphicsJobsAfterScriptLateUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateSubstance
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateCustomRenderTextures
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct XRPostLateUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateAllRenderers
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateLightProbeProxyVolumes
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct EnlightenRuntimeUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateAllSkinnedMeshes
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ProcessWebSendMessages
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct SortingGroupsUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateVideoTextures
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct DirectorRenderImage
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PlayerEmitCanvasGeometry
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	internal struct PlayerRenderUIEBatchModeOffscreen
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct FinishFrameRendering
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct BatchModeUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PlayerSendFrameComplete
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateCaptureScreenshot
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PresentAfterDraw
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ClearImmediateRenderers
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct XRPostPresent
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct UpdateResolution
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct InputEndFrame
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct GUIClearEvents
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ShaderHandleErrors
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ResetInputAxis
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ThreadedLoadingDebug
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ProfilerSynchronizeStats
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct MemoryFrameMaintenance
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ExecuteGameCenterCallbacks
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct XRPreEndFrame
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ProfilerEndFrame
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct GraphicsWarmupPreloadedShaders
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PlayerSendFramePostPresent
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PhysicsSkinnedClothBeginUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct PhysicsSkinnedClothFinishUpdate
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct TriggerEndOfFrameCallbacks
	{
	}

	[StructLayout(LayoutKind.Sequential, Size = 1)]
	[RequiredByNativeCode]
	public struct ObjectDispatcherPostLateUpdate
	{
	}
}
