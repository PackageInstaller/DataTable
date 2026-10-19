using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Rendering;

namespace UnityEngine;

[StaticAccessor("GetRenderSettings()", StaticAccessorType.Dot)]
[NativeHeader("Runtime/Graphics/QualitySettingsTypes.h")]
[NativeHeader("Runtime/Camera/RenderSettings.h")]
public sealed class RenderSettings : Object
{
	[Obsolete("Use RenderSettings.ambientIntensity instead (UnityUpgradable) -> ambientIntensity", false)]
	public static float ambientSkyboxAmount
	{
		get
		{
			return ambientIntensity;
		}
		set
		{
			ambientIntensity = value;
		}
	}

	[NativeProperty("UseFog")]
	public static extern bool fog
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("LinearFogStart")]
	public static extern float fogStartDistance
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("LinearFogEnd")]
	public static extern float fogEndDistance
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern FogMode fogMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static Color fogColor
	{
		get
		{
			get_fogColor_Injected(out var ret);
			return ret;
		}
		set
		{
			set_fogColor_Injected(ref value);
		}
	}

	public static extern float fogDensity
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern AmbientMode ambientMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static Color ambientSkyColor
	{
		get
		{
			get_ambientSkyColor_Injected(out var ret);
			return ret;
		}
		set
		{
			set_ambientSkyColor_Injected(ref value);
		}
	}

	public static Color ambientEquatorColor
	{
		get
		{
			get_ambientEquatorColor_Injected(out var ret);
			return ret;
		}
		set
		{
			set_ambientEquatorColor_Injected(ref value);
		}
	}

	public static Color ambientGroundColor
	{
		get
		{
			get_ambientGroundColor_Injected(out var ret);
			return ret;
		}
		set
		{
			set_ambientGroundColor_Injected(ref value);
		}
	}

	public static extern float ambientIntensity
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("AmbientSkyColor")]
	public static Color ambientLight
	{
		get
		{
			get_ambientLight_Injected(out var ret);
			return ret;
		}
		set
		{
			set_ambientLight_Injected(ref value);
		}
	}

	public static Color subtractiveShadowColor
	{
		get
		{
			get_subtractiveShadowColor_Injected(out var ret);
			return ret;
		}
		set
		{
			set_subtractiveShadowColor_Injected(ref value);
		}
	}

	[NativeProperty("SkyboxMaterial")]
	public static extern Material skybox
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern Light sun
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static SphericalHarmonicsL2 ambientProbe
	{
		[NativeMethod("GetFinalAmbientProbe")]
		get
		{
			get_ambientProbe_Injected(out var ret);
			return ret;
		}
		set
		{
			set_ambientProbe_Injected(ref value);
		}
	}

	[Obsolete("RenderSettings.customReflection has been deprecated in favor of RenderSettings.customReflectionTexture.", false)]
	public static Cubemap customReflection
	{
		get
		{
			if (!(customReflectionTexture is Cubemap result))
			{
				throw new ArgumentException("RenderSettings.customReflection is currently not referencing a cubemap.");
			}
			return result;
		}
		[NativeThrows]
		set
		{
			customReflectionTexture = value;
		}
	}

	[NativeProperty("CustomReflection")]
	public static extern Texture customReflectionTexture
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeThrows]
		set;
	}

	public static extern float reflectionIntensity
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int reflectionBounces
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[NativeProperty("GeneratedSkyboxReflection")]
	internal static extern Cubemap defaultReflection
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public static extern DefaultReflectionMode defaultReflectionMode
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern int defaultReflectionResolution
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern float haloStrength
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern float flareStrength
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public static extern float flareFadeSpeed
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	private RenderSettings()
	{
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetRenderSettings")]
	internal static extern Object GetRenderSettings();

	[MethodImpl((MethodImplOptions)4096)]
	[StaticAccessor("RenderSettingsScripting", StaticAccessorType.DoubleColon)]
	internal static extern void Reset();

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_fogColor_Injected(out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void set_fogColor_Injected(ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_ambientSkyColor_Injected(out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void set_ambientSkyColor_Injected(ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_ambientEquatorColor_Injected(out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void set_ambientEquatorColor_Injected(ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_ambientGroundColor_Injected(out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void set_ambientGroundColor_Injected(ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_ambientLight_Injected(out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void set_ambientLight_Injected(ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_subtractiveShadowColor_Injected(out Color ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void set_subtractiveShadowColor_Injected(ref Color value);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void get_ambientProbe_Injected(out SphericalHarmonicsL2 ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private static extern void set_ambientProbe_Injected(ref SphericalHarmonicsL2 value);
}
