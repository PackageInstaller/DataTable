using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/Export/RenderPipeline/ScriptableRenderPipeline.bindings.h")]
[NativeHeader("Runtime/Graphics/ScriptableRenderLoop/ScriptableCulling.h")]
[NativeHeader("Runtime/Scripting/ScriptingCommonStructDefinitions.h")]
public struct CullingResults : IEquatable<CullingResults>
{
	internal IntPtr ptr;

	private unsafe CullingAllocationInfo* m_AllocationInfo;

	public unsafe NativeArray<VisibleLight> visibleLights => GetNativeArray<VisibleLight>(m_AllocationInfo->visibleLightsPtr, m_AllocationInfo->visibleLightCount);

	public unsafe NativeArray<VisibleLight> visibleOffscreenVertexLights => GetNativeArray<VisibleLight>(m_AllocationInfo->visibleOffscreenVertexLightsPtr, m_AllocationInfo->visibleOffscreenVertexLightCount);

	public unsafe NativeArray<VisibleReflectionProbe> visibleReflectionProbes => GetNativeArray<VisibleReflectionProbe>(m_AllocationInfo->visibleReflectionProbesPtr, m_AllocationInfo->visibleReflectionProbeCount);

	public int lightIndexCount => GetLightIndexCount(ptr);

	public int reflectionProbeIndexCount => GetReflectionProbeIndexCount(ptr);

	public int lightAndReflectionProbeIndexCount => GetLightIndexCount(ptr) + GetReflectionProbeIndexCount(ptr);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ScriptableRenderPipeline_Bindings::GetLightIndexCount")]
	private static extern int GetLightIndexCount(IntPtr cullingResultsPtr);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ScriptableRenderPipeline_Bindings::GetReflectionProbeIndexCount")]
	private static extern int GetReflectionProbeIndexCount(IntPtr cullingResultsPtr);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("FillLightAndReflectionProbeIndices")]
	private static extern void FillLightAndReflectionProbeIndices(IntPtr cullingResultsPtr, ComputeBuffer computeBuffer);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("FillLightAndReflectionProbeIndices")]
	private static extern void FillLightAndReflectionProbeIndicesGraphicsBuffer(IntPtr cullingResultsPtr, GraphicsBuffer buffer);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetLightIndexMapSize")]
	private static extern int GetLightIndexMapSize(IntPtr cullingResultsPtr);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetReflectionProbeIndexMapSize")]
	private static extern int GetReflectionProbeIndexMapSize(IntPtr cullingResultsPtr);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("FillLightIndexMapScriptable")]
	private static extern void FillLightIndexMap(IntPtr cullingResultsPtr, IntPtr indexMapPtr, int indexMapSize);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("FillReflectionProbeIndexMapScriptable")]
	private static extern void FillReflectionProbeIndexMap(IntPtr cullingResultsPtr, IntPtr indexMapPtr, int indexMapSize);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("SetLightIndexMapScriptable")]
	private static extern void SetLightIndexMap(IntPtr cullingResultsPtr, IntPtr indexMapPtr, int indexMapSize);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("SetReflectionProbeIndexMapScriptable")]
	private static extern void SetReflectionProbeIndexMap(IntPtr cullingResultsPtr, IntPtr indexMapPtr, int indexMapSize);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ScriptableRenderPipeline_Bindings::GetShadowCasterBounds")]
	private static extern bool GetShadowCasterBounds(IntPtr cullingResultsPtr, int lightIndex, out Bounds bounds);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ScriptableRenderPipeline_Bindings::ComputeSpotShadowMatricesAndCullingPrimitives")]
	private static extern bool ComputeSpotShadowMatricesAndCullingPrimitives(IntPtr cullingResultsPtr, int activeLightIndex, out Matrix4x4 viewMatrix, out Matrix4x4 projMatrix, out ShadowSplitData shadowSplitData);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("ScriptableRenderPipeline_Bindings::ComputePointShadowMatricesAndCullingPrimitives")]
	private static extern bool ComputePointShadowMatricesAndCullingPrimitives(IntPtr cullingResultsPtr, int activeLightIndex, CubemapFace cubemapFace, float fovBias, out Matrix4x4 viewMatrix, out Matrix4x4 projMatrix, out ShadowSplitData shadowSplitData);

	[FreeFunction("ScriptableRenderPipeline_Bindings::ComputeDirectionalShadowMatricesAndCullingPrimitives")]
	private static bool ComputeDirectionalShadowMatricesAndCullingPrimitives(IntPtr cullingResultsPtr, int activeLightIndex, int splitIndex, int splitCount, Vector3 splitRatio, int shadowResolution, float shadowNearPlaneOffset, out Matrix4x4 viewMatrix, out Matrix4x4 projMatrix, out ShadowSplitData shadowSplitData)
	{
		return ComputeDirectionalShadowMatricesAndCullingPrimitives_Injected(cullingResultsPtr, activeLightIndex, splitIndex, splitCount, ref splitRatio, shadowResolution, shadowNearPlaneOffset, out viewMatrix, out projMatrix, out shadowSplitData);
	}

	private unsafe NativeArray<T> GetNativeArray<T>(void* dataPointer, int length) where T : struct
	{
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<T>(dataPointer, length, Allocator.Invalid);
	}

	public void FillLightAndReflectionProbeIndices(ComputeBuffer computeBuffer)
	{
		FillLightAndReflectionProbeIndices(ptr, computeBuffer);
	}

	public void FillLightAndReflectionProbeIndices(GraphicsBuffer buffer)
	{
		FillLightAndReflectionProbeIndicesGraphicsBuffer(ptr, buffer);
	}

	public unsafe NativeArray<int> GetLightIndexMap(Allocator allocator)
	{
		int lightIndexMapSize = GetLightIndexMapSize(ptr);
		NativeArray<int> nativeArray = new NativeArray<int>(lightIndexMapSize, allocator, NativeArrayOptions.UninitializedMemory);
		FillLightIndexMap(ptr, (IntPtr)nativeArray.GetUnsafePtr(), lightIndexMapSize);
		return nativeArray;
	}

	public unsafe void SetLightIndexMap(NativeArray<int> lightIndexMap)
	{
		SetLightIndexMap(ptr, (IntPtr)lightIndexMap.GetUnsafeReadOnlyPtr(), lightIndexMap.Length);
	}

	public unsafe NativeArray<int> GetReflectionProbeIndexMap(Allocator allocator)
	{
		int reflectionProbeIndexMapSize = GetReflectionProbeIndexMapSize(ptr);
		NativeArray<int> nativeArray = new NativeArray<int>(reflectionProbeIndexMapSize, allocator, NativeArrayOptions.UninitializedMemory);
		FillReflectionProbeIndexMap(ptr, (IntPtr)nativeArray.GetUnsafePtr(), reflectionProbeIndexMapSize);
		return nativeArray;
	}

	public unsafe void SetReflectionProbeIndexMap(NativeArray<int> lightIndexMap)
	{
		SetReflectionProbeIndexMap(ptr, (IntPtr)lightIndexMap.GetUnsafeReadOnlyPtr(), lightIndexMap.Length);
	}

	public bool GetShadowCasterBounds(int lightIndex, out Bounds outBounds)
	{
		return GetShadowCasterBounds(ptr, lightIndex, out outBounds);
	}

	public bool ComputeSpotShadowMatricesAndCullingPrimitives(int activeLightIndex, out Matrix4x4 viewMatrix, out Matrix4x4 projMatrix, out ShadowSplitData shadowSplitData)
	{
		return ComputeSpotShadowMatricesAndCullingPrimitives(ptr, activeLightIndex, out viewMatrix, out projMatrix, out shadowSplitData);
	}

	public bool ComputePointShadowMatricesAndCullingPrimitives(int activeLightIndex, CubemapFace cubemapFace, float fovBias, out Matrix4x4 viewMatrix, out Matrix4x4 projMatrix, out ShadowSplitData shadowSplitData)
	{
		return ComputePointShadowMatricesAndCullingPrimitives(ptr, activeLightIndex, cubemapFace, fovBias, out viewMatrix, out projMatrix, out shadowSplitData);
	}

	public bool ComputeDirectionalShadowMatricesAndCullingPrimitives(int activeLightIndex, int splitIndex, int splitCount, Vector3 splitRatio, int shadowResolution, float shadowNearPlaneOffset, out Matrix4x4 viewMatrix, out Matrix4x4 projMatrix, out ShadowSplitData shadowSplitData)
	{
		return ComputeDirectionalShadowMatricesAndCullingPrimitives(ptr, activeLightIndex, splitIndex, splitCount, splitRatio, shadowResolution, shadowNearPlaneOffset, out viewMatrix, out projMatrix, out shadowSplitData);
	}

	[Conditional("ENABLE_UNITY_COLLECTIONS_CHECKS")]
	internal void Validate()
	{
	}

	public unsafe bool Equals(CullingResults other)
	{
		return ptr.Equals(other.ptr) && m_AllocationInfo == other.m_AllocationInfo;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		return obj is CullingResults && Equals((CullingResults)obj);
	}

	public unsafe override int GetHashCode()
	{
		int hashCode = ptr.GetHashCode();
		return (hashCode * 397) ^ (int)m_AllocationInfo;
	}

	public static bool operator ==(CullingResults left, CullingResults right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(CullingResults left, CullingResults right)
	{
		return !left.Equals(right);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool ComputeDirectionalShadowMatricesAndCullingPrimitives_Injected(IntPtr cullingResultsPtr, int activeLightIndex, int splitIndex, int splitCount, ref Vector3 splitRatio, int shadowResolution, float shadowNearPlaneOffset, out Matrix4x4 viewMatrix, out Matrix4x4 projMatrix, out ShadowSplitData shadowSplitData);
}
