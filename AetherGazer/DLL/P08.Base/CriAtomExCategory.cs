using System;
using System.Runtime.InteropServices;

public static class CriAtomExCategory
{
	public enum ReactType
	{
		Ducker,
		AisacModulationTrigger
	}

	public enum ReactDuckerTargetType
	{
		Volume,
		AisacControlValue
	}

	[Obsolete("Use CriWare.CriAtomEx.CurveType instead")]
	public enum ReactDuckerCurveType
	{
		Linear,
		Square,
		SquareReverse,
		SCurve,
		FlatAtHalf
	}

	public struct ReactFadeParameter
	{
		public CriAtomEx.CurveType curveType;

		public float curveStrength;

		public ushort fadeTimeMs;
	}

	public enum ReactHoldType
	{
		WhilePlaying,
		FixedTime
	}

	[StructLayout(LayoutKind.Explicit)]
	public struct ReactDuckerParameter
	{
		public struct Volume
		{
			public float level;
		}

		public struct AisacControl
		{
			public uint id;

			public float value;
		}

		[StructLayout(LayoutKind.Explicit)]
		public struct Target
		{
			[FieldOffset(0)]
			public Volume volume;

			[FieldOffset(0)]
			public AisacControl aisacControl;
		}

		[FieldOffset(0)]
		public Target target;

		[FieldOffset(8)]
		public ReactDuckerTargetType targetType;

		[FieldOffset(12)]
		public ReactFadeParameter entry;

		[FieldOffset(24)]
		public ReactFadeParameter exit;

		[FieldOffset(36)]
		public ReactHoldType holdType;

		[FieldOffset(40)]
		public ushort holdTimeMs;
	}

	public struct ReactAisacModulationParameter
	{
		private int _enableDecrementAisacModulationKey;

		public uint decrementAisacModulationKey;

		private int _enableIncrementAisacModulationKey;

		public uint incrementAisacModulationKey;

		public bool enableDecrementAisacModulationKey
		{
			get
			{
				if (_enableDecrementAisacModulationKey == 0)
				{
					return false;
				}
				return true;
			}
		}

		public bool enableIncrementAisacModulationKey
		{
			get
			{
				if (_enableIncrementAisacModulationKey == 0)
				{
					return false;
				}
				return true;
			}
		}
	}

	[StructLayout(LayoutKind.Explicit)]
	public struct ReactParameter
	{
		[StructLayout(LayoutKind.Explicit)]
		public struct Parameter
		{
			[FieldOffset(0)]
			public ReactDuckerParameter ducker;

			[FieldOffset(0)]
			public ReactAisacModulationParameter aisacModulation;
		}

		[FieldOffset(0)]
		public Parameter parameter;

		[FieldOffset(44)]
		public ReactType type;

		[FieldOffset(48)]
		public bool enablePausingCue;
	}

	public enum ReactStatus
	{
		Stop,
		FadeOut,
		Hold,
		FadeIn,
		Error
	}

	public static void SetVolume(string name, float volume)
	{
		criAtomExCategory_SetVolumeByName(name, volume);
	}

	public static void SetVolume(int id, float volume)
	{
		criAtomExCategory_SetVolumeById(id, volume);
	}

	public static float GetVolume(string name)
	{
		return criAtomExCategory_GetVolumeByName(name);
	}

	public static float GetVolume(int id)
	{
		return criAtomExCategory_GetVolumeById(id);
	}

	public static void Mute(string name, bool mute)
	{
		criAtomExCategory_MuteByName(name, mute);
	}

	public static void Mute(int id, bool mute)
	{
		criAtomExCategory_MuteById(id, mute);
	}

	public static bool IsMuted(string name)
	{
		return criAtomExCategory_IsMutedByName(name);
	}

	public static bool IsMuted(int id)
	{
		return criAtomExCategory_IsMutedById(id);
	}

	public static void Solo(string name, bool solo, float muteVolume)
	{
		criAtomExCategory_SoloByName(name, solo, muteVolume);
	}

	public static void Solo(int id, bool solo, float muteVolume)
	{
		criAtomExCategory_SoloById(id, solo, muteVolume);
	}

	public static bool IsSoloed(string name)
	{
		return criAtomExCategory_IsSoloedByName(name);
	}

	public static bool IsSoloed(int id)
	{
		return criAtomExCategory_IsSoloedById(id);
	}

	public static void Pause(string name, bool pause)
	{
		criAtomExCategory_PauseByName(name, pause);
	}

	public static void Pause(int id, bool pause)
	{
		criAtomExCategory_PauseById(id, pause);
	}

	public static bool IsPaused(string name)
	{
		return criAtomExCategory_IsPausedByName(name);
	}

	public static bool IsPaused(int id)
	{
		return criAtomExCategory_IsPausedById(id);
	}

	public static void SetAisacControl(string name, string controlName, float value)
	{
		criAtomExCategory_SetAisacControlByName(name, controlName, value);
	}

	[Obsolete("Use CriAtomExCategory.SetAisacControl")]
	public static void SetAisac(string name, string controlName, float value)
	{
		SetAisacControl(name, controlName, value);
	}

	public static void SetAisacControl(int id, int controlId, float value)
	{
		criAtomExCategory_SetAisacControlById(id, (ushort)controlId, value);
	}

	[Obsolete("Use CriAtomExCategory.SetAisacControl")]
	public static void SetAisac(int id, int controlId, float value)
	{
		SetAisacControl(id, controlId, value);
	}

	public static void SetReactParameter(string name, ReactParameter parameter)
	{
		criAtomExCategory_SetReactParameter(name, ref parameter);
	}

	public static bool GetReactParameter(string name, out ReactParameter parameter)
	{
		return criAtomExCategory_GetReactParameter(name, out parameter);
	}

	public static bool GetAttachedAisacInfoById(uint id, int aisacAttachedIndex, out CriAtomEx.AisacInfo aisacInfo)
	{
		using CriStructMemory<CriAtomEx.AisacInfo> criStructMemory = new CriStructMemory<CriAtomEx.AisacInfo>();
		bool num = criAtomExCategory_GetAttachedAisacInfoById(id, aisacAttachedIndex, criStructMemory.ptr);
		if (num)
		{
			aisacInfo = new CriAtomEx.AisacInfo(criStructMemory.bytes, 0);
		}
		else
		{
			aisacInfo = default(CriAtomEx.AisacInfo);
		}
		return num;
	}

	public static bool GetAttachedAisacInfoByName(string name, int aisacAttachedIndex, out CriAtomEx.AisacInfo aisacInfo)
	{
		using CriStructMemory<CriAtomEx.AisacInfo> criStructMemory = new CriStructMemory<CriAtomEx.AisacInfo>();
		bool num = criAtomExCategory_GetAttachedAisacInfoByName(name, aisacAttachedIndex, criStructMemory.ptr);
		if (num)
		{
			aisacInfo = new CriAtomEx.AisacInfo(criStructMemory.bytes, 0);
		}
		else
		{
			aisacInfo = default(CriAtomEx.AisacInfo);
		}
		return num;
	}

	public static bool GetCurrentAisacControlValue(string categoryName, string aisacControlName, out float controlValue)
	{
		return criAtomExCategory_GetCurrentAisacControlValueByName(categoryName, aisacControlName, out controlValue);
	}

	public static ReactStatus GetReactStatus(string reactName)
	{
		return criAtomExCategory_GetReactStatus(reactName);
	}

	public static void Stop(int id)
	{
		criAtomExCategory_StopById(id);
	}

	public static void Stop(string name)
	{
		criAtomExCategory_StopByName(name);
	}

	public static void StopWithoutReleaseTime(int id)
	{
		criAtomExCategory_StopWithoutReleaseTimeById(id);
	}

	public static void StopWithoutReleaseTime(string name)
	{
		criAtomExCategory_StopWithoutReleaseTimeByName(name);
	}

	public static float GetTotalVolume(int id)
	{
		return criAtomExCategory_GetTotalVolumeById(id);
	}

	public static float GetTotalVolume(string name)
	{
		return criAtomExCategory_GetTotalVolumeByName(name);
	}

	public static void SetFadeInTime(int id, ushort ms)
	{
		criAtomExCategory_SetFadeInTimeById(id, ms);
	}

	public static void SetFadeInTime(string name, ushort ms)
	{
		criAtomExCategory_SetFadeInTimeByName(name, ms);
	}

	public static void SetFadeOutTime(int id, ushort ms)
	{
		criAtomExCategory_SetFadeOutTimeById(id, ms);
	}

	public static void SetFadeOutTime(string name, ushort ms)
	{
		criAtomExCategory_SetFadeOutTimeByName(name, ms);
	}

	public static bool ResetAllAisacControl(int id)
	{
		return criAtomExCategory_ResetAllAisacControlById(id);
	}

	public static bool ResetAllAisacControl(string name)
	{
		return criAtomExCategory_ResetAllAisacControlByName(name);
	}

	public static void AttachAisac(int id, string globalAisacName)
	{
		criAtomExCategory_AttachAisacById(id, globalAisacName);
	}

	public static void AttachAisac(string name, string globalAisacName)
	{
		criAtomExCategory_AttachAisacByName(name, globalAisacName);
	}

	public static void DetachAisac(int id, string globalAisacName)
	{
		criAtomExCategory_DetachAisacById(id, globalAisacName);
	}

	public static void DetachAisac(string name, string globalAisacName)
	{
		criAtomExCategory_DetachAisacByName(name, globalAisacName);
	}

	public static void DetachAisacAll(int id)
	{
		criAtomExCategory_DetachAisacAllById(id);
	}

	public static void DetachAisacAll(string name)
	{
		criAtomExCategory_DetachAisacAllByName(name);
	}

	public static int GetNumAttachedAisacs(int id)
	{
		return criAtomExCategory_GetNumAttachedAisacsById(id);
	}

	public static int GetNumAttachedAisacs(string name)
	{
		return criAtomExCategory_GetNumAttachedAisacsByName(name);
	}

	public static int GetNumCuePlayingCount(int id)
	{
		return criAtomExCategory_GetNumCuePlayingCountById(id);
	}

	public static int GetNumCuePlayingCount(string name)
	{
		return criAtomExCategory_GetNumCuePlayingCountByName(name);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_SetVolumeByName(string name, float volume);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criAtomExCategory_GetVolumeByName(string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_SetVolumeById(int id, float volume);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criAtomExCategory_GetVolumeById(int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_MuteById(int id, bool mute);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExCategory_IsMutedById(int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_MuteByName(string name, bool mute);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExCategory_IsMutedByName(string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_SoloById(int id, bool solo, float volume);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExCategory_IsSoloedById(int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_SoloByName(string name, bool solo, float volume);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExCategory_IsSoloedByName(string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_PauseById(int id, bool pause);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExCategory_IsPausedById(int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_PauseByName(string name, bool pause);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExCategory_IsPausedByName(string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_SetAisacControlById(int id, ushort controlId, float value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_SetAisacControlByName(string name, string controlName, float value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_SetReactParameter(string react_name, ref ReactParameter parameter);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExCategory_GetReactParameter(string react_name, out ReactParameter parameter);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExCategory_GetAttachedAisacInfoById(uint id, int aisacAttachedIndex, IntPtr aisacInfo);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExCategory_GetAttachedAisacInfoByName(string name, int aisacAttachedIndex, IntPtr aisacInfo);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExCategory_GetCurrentAisacControlValueByName(string category_name, string aisac_control_name, out float control_value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern ReactStatus criAtomExCategory_GetReactStatus(string react_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criAtomExCategory_GetTotalVolumeById(int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criAtomExCategory_GetTotalVolumeByName(string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_SetFadeInTimeById(int id, ushort ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_SetFadeInTimeByName(string name, ushort ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_SetFadeOutTimeById(int id, ushort ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_SetFadeOutTimeByName(string name, ushort ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExCategory_ResetAllAisacControlById(int category_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExCategory_ResetAllAisacControlByName(string category_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_AttachAisacById(int id, string global_aisac_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_AttachAisacByName(string name, string global_aisac_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_DetachAisacById(int id, string global_aisac_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_DetachAisacByName(string name, string global_aisac_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_DetachAisacAllById(int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_DetachAisacAllByName(string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExCategory_GetNumAttachedAisacsById(int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExCategory_GetNumAttachedAisacsByName(string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExCategory_GetNumCuePlayingCountById(int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExCategory_GetNumCuePlayingCountByName(string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_StopById(int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_StopByName(string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_StopWithoutReleaseTimeById(int id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExCategory_StopWithoutReleaseTimeByName(string name);
}
