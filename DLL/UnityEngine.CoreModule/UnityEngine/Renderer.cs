using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Scripting;
using UnityEngineInternal;

namespace UnityEngine;

[UsedByNativeCode]
[RequireComponent(typeof(Transform))]
[NativeHeader("Runtime/Graphics/GraphicsScriptBindings.h")]
[NativeHeader("Runtime/Graphics/Renderer.h")]
public class Renderer : Component
{
	public Bounds bounds
	{
		[FreeFunction(Name = "RendererScripting::GetWorldBounds", HasExplicitThis = true)]
		get
		{
			get_bounds_Injected(out var ret);
			return ret;
		}
		[NativeName("SetWorldAABB")]
		set
		{
			set_bounds_Injected(ref value);
		}
	}

	public Bounds localBounds
	{
		[FreeFunction(Name = "RendererScripting::GetLocalBounds", HasExplicitThis = true)]
		get
		{
			get_localBounds_Injected(out var ret);
			return ret;
		}
		[NativeName("SetLocalAABB")]
		set
		{
			set_localBounds_Injected(ref value);
		}
	}

	public extern bool enabled
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool isVisible
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("IsVisibleInScene")]
		get;
	}

	public extern ShadowCastingMode shadowCastingMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool receiveShadows
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool forceRenderingOff
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public bool staticShadowCaster
	{
		get
		{
			return GetIsStaticShadowCaster();
		}
		set
		{
			SetIsStaticShadowCaster(value);
		}
	}

	public extern MotionVectorGenerationMode motionVectorGenerationMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern LightProbeUsage lightProbeUsage
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern ReflectionProbeUsage reflectionProbeUsage
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern uint renderingLayerMask
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int rendererPriority
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern RayTracingMode rayTracingMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern string sortingLayerName
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int sortingLayerID
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int sortingOrder
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	internal extern int sortingGroupID
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	internal extern int sortingGroupOrder
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("IsDynamicOccludee")]
	public extern bool allowOcclusionWhenDynamic
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("StaticBatchRoot")]
	internal extern Transform staticBatchRootTransform
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	internal extern int staticBatchIndex
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern bool isPartOfStaticBatch
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeName("IsPartOfStaticBatch")]
		get;
	}

	public Matrix4x4 worldToLocalMatrix
	{
		get
		{
			get_worldToLocalMatrix_Injected(out var ret);
			return ret;
		}
	}

	public Matrix4x4 localToWorldMatrix
	{
		get
		{
			get_localToWorldMatrix_Injected(out var ret);
			return ret;
		}
	}

	public extern GameObject lightProbeProxyVolumeOverride
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern Transform probeAnchor
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public int lightmapIndex
	{
		get
		{
			return GetLightmapIndex(LightmapType.StaticLightmap);
		}
		set
		{
			SetLightmapIndex(value, LightmapType.StaticLightmap);
		}
	}

	public int realtimeLightmapIndex
	{
		get
		{
			return GetLightmapIndex(LightmapType.DynamicLightmap);
		}
		set
		{
			SetLightmapIndex(value, LightmapType.DynamicLightmap);
		}
	}

	public Vector4 lightmapScaleOffset
	{
		get
		{
			return GetLightmapST(LightmapType.StaticLightmap);
		}
		set
		{
			SetStaticLightmapST(value);
		}
	}

	public Vector4 realtimeLightmapScaleOffset
	{
		get
		{
			return GetLightmapST(LightmapType.DynamicLightmap);
		}
		set
		{
			SetLightmapST(value, LightmapType.DynamicLightmap);
		}
	}

	public Material[] materials
	{
		get
		{
			return GetMaterialArray();
		}
		set
		{
			SetMaterialArray(value);
		}
	}

	public Material material
	{
		get
		{
			return GetMaterial();
		}
		set
		{
			SetMaterial(value);
		}
	}

	public Material sharedMaterial
	{
		get
		{
			return GetSharedMaterial();
		}
		set
		{
			SetMaterial(value);
		}
	}

	public Material[] sharedMaterials
	{
		get
		{
			return GetSharedMaterialArray();
		}
		set
		{
			SetMaterialArray(value);
		}
	}

	[Obsolete("Use shadowCastingMode instead.", false)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public bool castShadows
	{
		get
		{
			return shadowCastingMode != ShadowCastingMode.Off;
		}
		set
		{
			shadowCastingMode = (value ? ShadowCastingMode.On : ShadowCastingMode.Off);
		}
	}

	[Obsolete("Use motionVectorGenerationMode instead.", false)]
	public bool motionVectors
	{
		get
		{
			return motionVectorGenerationMode == MotionVectorGenerationMode.Object;
		}
		set
		{
			motionVectorGenerationMode = (value ? MotionVectorGenerationMode.Object : MotionVectorGenerationMode.Camera);
		}
	}

	[Obsolete("Use lightProbeUsage instead.", false)]
	public bool useLightProbes
	{
		get
		{
			return lightProbeUsage != LightProbeUsage.Off;
		}
		set
		{
			lightProbeUsage = (value ? LightProbeUsage.BlendProbes : LightProbeUsage.Off);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("ResetWorldAABB")]
	public extern void ResetBounds();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("ResetLocalAABB")]
	public extern void ResetLocalBounds();

	[FreeFunction(Name = "RendererScripting::SetStaticLightmapST", HasExplicitThis = true)]
	private void SetStaticLightmapST(Vector4 st)
	{
		SetStaticLightmapST_Injected(ref st);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RendererScripting::GetMaterial", HasExplicitThis = true)]
	private extern Material GetMaterial();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RendererScripting::GetSharedMaterial", HasExplicitThis = true)]
	private extern Material GetSharedMaterial();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RendererScripting::SetMaterial", HasExplicitThis = true)]
	private extern void SetMaterial(Material m);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RendererScripting::GetMaterialArray", HasExplicitThis = true)]
	private extern Material[] GetMaterialArray();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RendererScripting::GetMaterialArray", HasExplicitThis = true)]
	private extern void CopyMaterialArray([Out] Material[] m);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RendererScripting::GetSharedMaterialArray", HasExplicitThis = true)]
	private extern void CopySharedMaterialArray([Out] Material[] m);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RendererScripting::SetMaterialArray", HasExplicitThis = true)]
	private extern void SetMaterialArray([NotNull("ArgumentNullException")] Material[] m);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RendererScripting::SetPropertyBlock", HasExplicitThis = true)]
	internal extern void Internal_SetPropertyBlock(MaterialPropertyBlock properties);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RendererScripting::GetPropertyBlock", HasExplicitThis = true)]
	internal extern void Internal_GetPropertyBlock([NotNull("ArgumentNullException")] MaterialPropertyBlock dest);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RendererScripting::SetPropertyBlockMaterialIndex", HasExplicitThis = true)]
	internal extern void Internal_SetPropertyBlockMaterialIndex(MaterialPropertyBlock properties, int materialIndex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RendererScripting::GetPropertyBlockMaterialIndex", HasExplicitThis = true)]
	internal extern void Internal_GetPropertyBlockMaterialIndex([NotNull("ArgumentNullException")] MaterialPropertyBlock dest, int materialIndex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RendererScripting::HasPropertyBlock", HasExplicitThis = true)]
	public extern bool HasPropertyBlock();

	public void SetPropertyBlock(MaterialPropertyBlock properties)
	{
		Internal_SetPropertyBlock(properties);
	}

	public void SetPropertyBlock(MaterialPropertyBlock properties, int materialIndex)
	{
		Internal_SetPropertyBlockMaterialIndex(properties, materialIndex);
	}

	public void GetPropertyBlock(MaterialPropertyBlock properties)
	{
		Internal_GetPropertyBlock(properties);
	}

	public void GetPropertyBlock(MaterialPropertyBlock properties, int materialIndex)
	{
		Internal_GetPropertyBlockMaterialIndex(properties, materialIndex);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "RendererScripting::GetClosestReflectionProbes", HasExplicitThis = true)]
	private extern void GetClosestReflectionProbesInternal(object result);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetIsStaticShadowCaster")]
	private extern bool GetIsStaticShadowCaster();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetIsStaticShadowCaster")]
	private extern void SetIsStaticShadowCaster(bool value);

	[MethodImpl((MethodImplOptions)4096)]
	internal extern void SetStaticBatchInfo(int firstSubMesh, int subMeshCount);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetLightmapIndexInt")]
	private extern int GetLightmapIndex(LightmapType lt);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("SetLightmapIndexInt")]
	private extern void SetLightmapIndex(int index, LightmapType lt);

	[NativeName("GetLightmapST")]
	private Vector4 GetLightmapST(LightmapType lt)
	{
		GetLightmapST_Injected(lt, out var ret);
		return ret;
	}

	[NativeName("SetLightmapST")]
	private void SetLightmapST(Vector4 st, LightmapType lt)
	{
		SetLightmapST_Injected(ref st, lt);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern int GetMaterialCount();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("GetMaterialArray")]
	private extern Material[] GetSharedMaterialArray();

	public void GetMaterials(List<Material> m)
	{
		if (m == null)
		{
			throw new ArgumentNullException("The result material list cannot be null.", "m");
		}
		NoAllocHelpers.EnsureListElemCount(m, GetMaterialCount());
		CopyMaterialArray(NoAllocHelpers.ExtractArrayFromListT(m));
	}

	public void GetSharedMaterials(List<Material> m)
	{
		if (m == null)
		{
			throw new ArgumentNullException("The result material list cannot be null.", "m");
		}
		NoAllocHelpers.EnsureListElemCount(m, GetMaterialCount());
		CopySharedMaterialArray(NoAllocHelpers.ExtractArrayFromListT(m));
	}

	public void GetClosestReflectionProbes(List<ReflectionProbeBlendInfo> result)
	{
		GetClosestReflectionProbesInternal(result);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_bounds_Injected(out Bounds ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_bounds_Injected(ref Bounds value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_localBounds_Injected(out Bounds ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_localBounds_Injected(ref Bounds value);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetStaticLightmapST_Injected(ref Vector4 st);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_worldToLocalMatrix_Injected(out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_localToWorldMatrix_Injected(out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetLightmapST_Injected(LightmapType lt, out Vector4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetLightmapST_Injected(ref Vector4 st, LightmapType lt);
}
