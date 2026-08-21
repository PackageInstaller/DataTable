using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Rendering;

namespace UnityEngine;

[RequireComponent(typeof(Transform))]
[RequireComponent(typeof(Transform))]
[NativeHeader("Runtime/Camera/Light.h")]
[NativeHeader("Runtime/Export/Graphics/Light.bindings.h")]
public sealed class Light : Behaviour
{
	private int m_BakedIndex;

	public extern LightShadows shadows
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetShadowType")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Light_Bindings::SetShadowType", HasExplicitThis = true, ThrowsException = true)]
		set;
	}

	public extern float shadowStrength
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Light_Bindings::SetShadowStrength", HasExplicitThis = true)]
		set;
	}

	public extern LightShadowResolution shadowResolution
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Light_Bindings::SetShadowResolution", HasExplicitThis = true, ThrowsException = true)]
		set;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Shadow softness is removed in Unity 5.0+", true)]
	public float shadowSoftness
	{
		get
		{
			return 4f;
		}
		set
		{
		}
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Shadow softness is removed in Unity 5.0+", true)]
	public float shadowSoftnessFade
	{
		get
		{
			return 1f;
		}
		set
		{
		}
	}

	public extern float[] layerShadowCullDistances
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Light_Bindings::GetLayerShadowCullDistances", HasExplicitThis = true, ThrowsException = false)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Light_Bindings::SetLayerShadowCullDistances", HasExplicitThis = true, ThrowsException = true)]
		set;
	}

	public extern float cookieSize
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern Texture cookie
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern LightRenderMode renderMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("Light_Bindings::SetRenderMode", HasExplicitThis = true, ThrowsException = true)]
		set;
	}

	[Obsolete("warning bakedIndex has been removed please use bakingOutput.isBaked instead.", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public int bakedIndex
	{
		get
		{
			return m_BakedIndex;
		}
		set
		{
			m_BakedIndex = value;
		}
	}

	public extern int commandBufferCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[Obsolete("Use QualitySettings.pixelLightCount instead.")]
	public static int pixelLightCount
	{
		get
		{
			return QualitySettings.pixelLightCount;
		}
		set
		{
			QualitySettings.pixelLightCount = value;
		}
	}

	[Obsolete("light.shadowConstantBias was removed, use light.shadowBias", true)]
	public float shadowConstantBias
	{
		get
		{
			return 0f;
		}
		set
		{
		}
	}

	[Obsolete("light.shadowObjectSizeBias was removed, use light.shadowBias", true)]
	public float shadowObjectSizeBias
	{
		get
		{
			return 0f;
		}
		set
		{
		}
	}

	[Obsolete("light.attenuate was removed; all lights always attenuate now", true)]
	public bool attenuate
	{
		get
		{
			return true;
		}
		set
		{
		}
	}

	[NativeProperty("LightType")]
	public extern LightType type
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("LightShape")]
	public extern LightShape shape
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float spotAngle
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float innerSpotAngle
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public Color color
	{
		get
		{
			get_color_Injected(out var ret);
			return ret;
		}
		set
		{
			set_color_Injected(ref value);
		}
	}

	public extern float colorTemperature
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool useColorTemperature
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float intensity
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float bounceIntensity
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool useBoundingSphereOverride
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public Vector4 boundingSphereOverride
	{
		get
		{
			get_boundingSphereOverride_Injected(out var ret);
			return ret;
		}
		set
		{
			set_boundingSphereOverride_Injected(ref value);
		}
	}

	public extern bool useViewFrustumForShadowCasterCull
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int shadowCustomResolution
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float shadowBias
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float shadowNormalBias
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern float shadowNearPlane
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool useShadowMatrixOverride
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public Matrix4x4 shadowMatrixOverride
	{
		get
		{
			get_shadowMatrixOverride_Injected(out var ret);
			return ret;
		}
		set
		{
			set_shadowMatrixOverride_Injected(ref value);
		}
	}

	public extern float range
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern Flare flare
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public LightBakingOutput bakingOutput
	{
		get
		{
			get_bakingOutput_Injected(out var ret);
			return ret;
		}
		set
		{
			set_bakingOutput_Injected(ref value);
		}
	}

	public extern int cullingMask
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int renderingLayerMask
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern LightShadowCasterMode lightShadowCasterMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern void Reset();

	public void AddCommandBuffer(LightEvent evt, CommandBuffer buffer)
	{
		AddCommandBuffer(evt, buffer, ShadowMapPass.All);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Light_Bindings::AddCommandBuffer", HasExplicitThis = true)]
	public extern void AddCommandBuffer(LightEvent evt, CommandBuffer buffer, ShadowMapPass shadowPassMask);

	public void AddCommandBufferAsync(LightEvent evt, CommandBuffer buffer, ComputeQueueType queueType)
	{
		AddCommandBufferAsync(evt, buffer, ShadowMapPass.All, queueType);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Light_Bindings::AddCommandBufferAsync", HasExplicitThis = true)]
	public extern void AddCommandBufferAsync(LightEvent evt, CommandBuffer buffer, ShadowMapPass shadowPassMask, ComputeQueueType queueType);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void RemoveCommandBuffer(LightEvent evt, CommandBuffer buffer);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void RemoveCommandBuffers(LightEvent evt);

	[MethodImpl((MethodImplOptions)4096)]
	public extern void RemoveAllCommandBuffers();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Light_Bindings::GetCommandBuffers", HasExplicitThis = true)]
	public extern CommandBuffer[] GetCommandBuffers(LightEvent evt);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Light_Bindings::GetLights")]
	public static extern Light[] GetLights(LightType type, int layer);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_color_Injected(out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_color_Injected(ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_boundingSphereOverride_Injected(out Vector4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_boundingSphereOverride_Injected(ref Vector4 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_shadowMatrixOverride_Injected(out Matrix4x4 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_shadowMatrixOverride_Injected(ref Matrix4x4 value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_bakingOutput_Injected(out LightBakingOutput ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_bakingOutput_Injected(ref LightBakingOutput value);
}
