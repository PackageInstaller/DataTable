using System;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

public class SupportedRenderingFeatures
{
	[Flags]
	public enum ReflectionProbeModes
	{
		None = 0,
		Rotation = 1
	}

	[Flags]
	public enum LightmapMixedBakeModes
	{
		None = 0,
		IndirectOnly = 1,
		Subtractive = 2,
		Shadowmask = 4
	}

	private static SupportedRenderingFeatures s_Active = new SupportedRenderingFeatures();

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private ReflectionProbeModes reflectionProbeModes__BackingField = ReflectionProbeModes.None;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private bool lightProbeProxyVolumes__BackingField = true;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private bool motionVectors__BackingField = true;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private bool receiveShadows__BackingField = true;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private bool reflectionProbes__BackingField = true;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private bool reflectionProbesBlendDistance__BackingField = true;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private bool rendererPriority__BackingField = false;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private bool overridesEnvironmentLighting__BackingField = false;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private bool overridesFog__BackingField = false;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private bool overridesRealtimeReflectionProbes__BackingField = false;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private bool overridesOtherLightingSettings__BackingField = false;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private bool editableMaterialRenderQueue__BackingField = true;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private bool overridesLODBias__BackingField = false;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private bool overridesMaximumLODLevel__BackingField = false;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private bool overridesEnableLODCrossFade__BackingField = false;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private bool rendererProbes__BackingField = true;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private bool particleSystemInstancing__BackingField = true;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private bool overridesShadowmask__BackingField = false;

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private bool supportsHDR__BackingField = false;

	[CompilerGenerated]
	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	private string overridesLightProbeSystemWarningMessage__BackingField = "The rendering pipeline used has an alternative method to handle light probes. Please consult the documentation for the used SRP to setup the alternative.";

	public static SupportedRenderingFeatures active
	{
		get
		{
			if (s_Active == null)
			{
				s_Active = new SupportedRenderingFeatures();
			}
			return s_Active;
		}
		set
		{
			s_Active = value;
		}
	}

	public LightmapMixedBakeModes defaultMixedLightingModes { get; } = LightmapMixedBakeModes.None;

	public LightmapMixedBakeModes mixedLightingModes { get; } = LightmapMixedBakeModes.IndirectOnly | LightmapMixedBakeModes.Subtractive | LightmapMixedBakeModes.Shadowmask;

	public LightmapBakeType lightmapBakeTypes { get; } = LightmapBakeType.Realtime | LightmapBakeType.Baked | LightmapBakeType.Mixed;

	public LightmapsMode lightmapsModes { get; } = LightmapsMode.CombinedDirectional;

	[Obsolete("Bake with the Progressive Lightmapper. The backend that uses Enlighten to bake is deprecated.", false)]
	public bool enlightenLightmapper { get; } = true;

	public bool enlighten { get; } = true;

	public bool rendersUIOverlay { get; } = false;

	public bool autoAmbientProbeBaking { get; } = true;

	public bool autoDefaultReflectionProbeBaking { get; } = true;

	public bool overridesLightProbeSystem { get; } = false;

	[RequiredByNativeCode]
	internal unsafe static void FallbackMixedLightingModeByRef(IntPtr fallbackModePtr)
	{
		MixedLightingMode* ptr = (MixedLightingMode*)(void*)fallbackModePtr;
		if (active.defaultMixedLightingModes != LightmapMixedBakeModes.None && (active.mixedLightingModes & active.defaultMixedLightingModes) == active.defaultMixedLightingModes)
		{
			switch (active.defaultMixedLightingModes)
			{
			case LightmapMixedBakeModes.Shadowmask:
				*ptr = MixedLightingMode.Shadowmask;
				break;
			case LightmapMixedBakeModes.Subtractive:
				*ptr = MixedLightingMode.Subtractive;
				break;
			default:
				*ptr = MixedLightingMode.IndirectOnly;
				break;
			}
		}
		else if (IsMixedLightingModeSupported(MixedLightingMode.Shadowmask))
		{
			*ptr = MixedLightingMode.Shadowmask;
		}
		else if (IsMixedLightingModeSupported(MixedLightingMode.Subtractive))
		{
			*ptr = MixedLightingMode.Subtractive;
		}
		else
		{
			*ptr = MixedLightingMode.IndirectOnly;
		}
	}

	internal unsafe static bool IsMixedLightingModeSupported(MixedLightingMode mixedMode)
	{
		bool result = default;
		IsMixedLightingModeSupportedByRef(mixedMode, new IntPtr(&result));
		return result;
	}

	[RequiredByNativeCode]
	internal unsafe static void IsMixedLightingModeSupportedByRef(MixedLightingMode mixedMode, IntPtr isSupportedPtr)
	{
		bool* ptr = (bool*)(void*)isSupportedPtr;
		if (!IsLightmapBakeTypeSupported(LightmapBakeType.Mixed))
		{
			*ptr = false;
		}
		else
		{
			*ptr = (mixedMode == MixedLightingMode.IndirectOnly && (active.mixedLightingModes & LightmapMixedBakeModes.IndirectOnly) == LightmapMixedBakeModes.IndirectOnly) || (mixedMode == MixedLightingMode.Subtractive && (active.mixedLightingModes & LightmapMixedBakeModes.Subtractive) == LightmapMixedBakeModes.Subtractive) || (mixedMode == MixedLightingMode.Shadowmask && (active.mixedLightingModes & LightmapMixedBakeModes.Shadowmask) == LightmapMixedBakeModes.Shadowmask);
		}
	}

	internal unsafe static bool IsLightmapBakeTypeSupported(LightmapBakeType bakeType)
	{
		bool result = default;
		IsLightmapBakeTypeSupportedByRef(bakeType, new IntPtr(&result));
		return result;
	}

	[RequiredByNativeCode]
	internal unsafe static void IsLightmapBakeTypeSupportedByRef(LightmapBakeType bakeType, IntPtr isSupportedPtr)
	{
		bool* ptr = (bool*)(void*)isSupportedPtr;
		if (bakeType == LightmapBakeType.Mixed && (!IsLightmapBakeTypeSupported(LightmapBakeType.Baked) || active.mixedLightingModes == LightmapMixedBakeModes.None))
		{
			*ptr = false;
			return;
		}
		*ptr = (active.lightmapBakeTypes & bakeType) == bakeType;
		if (bakeType == LightmapBakeType.Realtime && !active.enlighten)
		{
			*ptr = false;
		}
	}

	[RequiredByNativeCode]
	internal unsafe static void IsLightmapsModeSupportedByRef(LightmapsMode mode, IntPtr isSupportedPtr)
	{
		bool* ptr = (bool*)(void*)isSupportedPtr;
		*ptr = (active.lightmapsModes & mode) == mode;
	}

	[RequiredByNativeCode]
	internal unsafe static void IsLightmapperSupportedByRef(int lightmapper, IntPtr isSupportedPtr)
	{
		bool* ptr = (bool*)(void*)isSupportedPtr;
		*ptr = lightmapper != 0 || active.enlightenLightmapper;
	}

	[RequiredByNativeCode]
	internal unsafe static void IsUIOverlayRenderedBySRP(IntPtr isSupportedPtr)
	{
		bool* ptr = (bool*)(void*)isSupportedPtr;
		*ptr = active.rendersUIOverlay;
	}

	[RequiredByNativeCode]
	internal unsafe static void IsAutoAmbientProbeBakingSupported(IntPtr isSupportedPtr)
	{
		bool* ptr = (bool*)(void*)isSupportedPtr;
		*ptr = active.autoAmbientProbeBaking;
	}

	[RequiredByNativeCode]
	internal unsafe static void IsAutoDefaultReflectionProbeBakingSupported(IntPtr isSupportedPtr)
	{
		bool* ptr = (bool*)(void*)isSupportedPtr;
		*ptr = active.autoDefaultReflectionProbeBaking;
	}

	[RequiredByNativeCode]
	internal unsafe static void OverridesLightProbeSystem(IntPtr overridesPtr)
	{
		bool* ptr = (bool*)(void*)overridesPtr;
		*ptr = active.overridesLightProbeSystem;
	}

	[RequiredByNativeCode]
	internal unsafe static void FallbackLightmapperByRef(IntPtr lightmapperPtr)
	{
		int* ptr = (int*)(void*)lightmapperPtr;
		*ptr = 1;
	}
}
