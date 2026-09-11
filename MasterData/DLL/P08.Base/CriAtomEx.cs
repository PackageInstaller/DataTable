using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using UnityEngine;

public static class CriAtomEx
{
	public enum CharacterEncoding
	{
		Utf8,
		Sjis
	}

	public enum SoundRendererType
	{
		Default = 0,
		Native = 1,
		Asr = 2,
		Extended = 3,
		Spatial = 4,
		Hw1 = Native,
		Hw2 = 65537,
		Hw3 = 131073,
		Hw4 = 196609,
		Haptic = Extended,
		Pseudo = 65539,
		SpatialChannels = Spatial,
		Ambisonics = 65540,
		Passtrough = 131076,
		Object = 196612
	}

	public enum VoiceAllocationMethod
	{
		Once,
		Retry
	}

	public enum BiquadFilterType
	{
		Off,
		LowPass,
		HighPass,
		Notch,
		LowShelf,
		HighShelf,
		Peaking
	}

	public enum ResumeMode
	{
		AllPlayback,
		PausedPlayback,
		PreparedPlayback
	}

	public enum PanType
	{
		Unknown = -1,
		Pan3d,
		Pos3d,
		Auto
	}

	public enum VoiceControlMethod
	{
		PreferLast,
		PreferFirst
	}

	public enum Parameter
	{
		Volume = 0,
		Pitch = 1,
		Pan3dAngle = 2,
		Pan3dDistance = 3,
		Pan3dVolume = 4,
		BusSendLevel0 = 9,
		BusSendLevel1 = 10,
		BusSendLevel2 = 11,
		BusSendLevel3 = 12,
		BusSendLevel4 = 13,
		BusSendLevel5 = 14,
		BusSendLevel6 = 15,
		BusSendLevel7 = 16,
		BandPassFilterCofLow = 17,
		BandPassFilterCofHigh = 18,
		BiquadFilterType = 19,
		BiquadFilterFreq = 20,
		BiquadFIlterQ = 21,
		BiquadFilterGain = 22,
		EnvelopeAttackTime = 23,
		EnvelopeHoldTime = 24,
		EnvelopeDecayTime = 25,
		EnvelopeReleaseTime = 26,
		EnvelopeSustainLevel = 27,
		StartTime = 28,
		Priority = 31
	}

	public enum Speaker
	{
		FrontLeft,
		FrontRight,
		FrontCenter,
		LowFrequency,
		SurroundLeft,
		SurroundRight,
		SurroundBackLeft,
		SurroundBackRight
	}

	public enum Format : uint
	{
		ADX = 1u,
		HCA = 3u,
		HCA_MX = 4u,
		WAVE = 5u,
		RAW_PCM = 6u,
		AUDIO_BUFFER = 9u,
		HW1 = 65537u,
		HW2 = 65538u,
		HW3 = 65539u,
		MP3 = HW3
	}

	public enum CurveType
	{
		Linear,
		Square,
		SquareReverse,
		SCurve,
		FlatAtHalf
	}

	private enum SpeakerSystem : uint
	{
		Surround_5_1,
		Surround_7_1
	}

	public struct SpeakerAngles6ch
	{
		public float frontLeft;

		public float frontRight;

		public float frontCenter;

		public float lowFrequency;

		public float surroundLeft;

		public float surroundRight;

		public static SpeakerAngles6ch Default()
		{
			return new SpeakerAngles6ch
			{
				frontLeft = -30f,
				frontRight = 30f,
				frontCenter = 0f,
				lowFrequency = 0f,
				surroundLeft = -120f,
				surroundRight = 120f
			};
		}
	}

	public struct SpeakerAngles8ch
	{
		public float frontLeft;

		public float frontRight;

		public float frontCenter;

		public float lowFrequency;

		public float surroundLeft;

		public float surroundRight;

		public float surroundBackLeft;

		public float surroundBackRight;

		public static SpeakerAngles8ch Default()
		{
			return new SpeakerAngles8ch
			{
				frontLeft = -30f,
				frontRight = 30f,
				frontCenter = 0f,
				lowFrequency = 0f,
				surroundLeft = -110f,
				surroundRight = 110f,
				surroundBackLeft = -150f,
				surroundBackRight = 150f
			};
		}
	}

	public struct FormatInfo
	{
		public Format format;

		public int samplingRate;

		public long numSamples;

		public long loopOffset;

		public long loopLength;

		public int numChannels;

		public uint reserved;
	}

	public struct AisacControlInfo
	{
		[MarshalAs(UnmanagedType.LPStr)]
		public readonly string name;

		public uint id;

		public AisacControlInfo(byte[] data, int startIndex)
		{
			if (IntPtr.Size == 4)
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex)));
				id = BitConverter.ToUInt32(data, startIndex + 4);
			}
			else
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex)));
				id = BitConverter.ToUInt32(data, startIndex + 8);
			}
		}
	}

	public enum Randomize3dCalcType
	{
		None = -1,
		Rectangle = 0,
		Cuboid = 1,
		Circle = 2,
		Cylinder = 3,
		Sphere = 4,
		List = 6
	}

	public enum Randomize3dParamType
	{
		None,
		Width,
		Depth,
		Height,
		Radius
	}

	[Serializable]
	public struct Randomize3dConfig
	{
		public const int NumOfCalcParams = 3;

		[SerializeField]
		private bool followsOriginalSource;

		[SerializeField]
		private Randomize3dCalcType calculationType;

		[MarshalAs(UnmanagedType.ByValArray, SizeConst = 3)]
		[SerializeField]
		private float[] calculationParameters;

		public bool FollowsOriginalSource => followsOriginalSource;

		public Randomize3dCalcType CalculationType => calculationType;

		public float CalculationParameter1 => calculationParameters[0];

		public float CalculationParameter2 => calculationParameters[1];

		public float CalculationParameter3 => calculationParameters[2];

		internal Randomize3dConfig(byte[] data, int startIndex)
		{
			followsOriginalSource = BitConverter.ToInt32(data, startIndex) != 0;
			calculationType = (Randomize3dCalcType)BitConverter.ToInt32(data, startIndex + 4);
			calculationParameters = new float[3];
			for (int i = 0; i < 3; i++)
			{
				calculationParameters[i] = BitConverter.ToSingle(data, startIndex + 8 + 4 * i);
			}
		}

		public Randomize3dConfig(bool followsOriginalSource, Randomize3dCalcType calculationType, float param1 = 0f, float param2 = 0f, float param3 = 0f)
		{
			this.followsOriginalSource = followsOriginalSource;
			this.calculationType = calculationType;
			calculationParameters = new float[3];
			calculationParameters[0] = param1;
			calculationParameters[1] = param2;
			calculationParameters[2] = param3;
		}

		public Randomize3dConfig(int dummy)
		{
			followsOriginalSource = false;
			calculationType = Randomize3dCalcType.Rectangle;
			calculationParameters = new float[3];
			ClearCalcParams();
		}

		public void ClearCalcParams(float initVal = 0f)
		{
			for (int i = 0; i < 3; i++)
			{
				calculationParameters[i] = initVal;
			}
		}

		public bool GetParamByType(Randomize3dParamType paramType, ref float paramVal)
		{
			int num = Array.IndexOf(randomize3dParamTable[calculationType], paramType);
			if (num < 0)
			{
				Debug.LogWarningFormat("[CRIWARE] Parameter {0} not available for 3d randomize calculation type {1}", paramType.ToString(), calculationType.ToString());
				return false;
			}
			paramVal = calculationParameters[num];
			return true;
		}

		public bool SetParamByType(Randomize3dParamType paramType, float paramVal)
		{
			int num = Array.IndexOf(randomize3dParamTable[calculationType], paramType);
			if (num < 0)
			{
				Debug.LogWarningFormat("[CRIWARE] Parameter {0} not available for 3d randomize calculation type {1}", paramType.ToString(), calculationType.ToString());
				return false;
			}
			calculationParameters[num] = paramVal;
			return true;
		}
	}

	public struct CuePos3dInfo(byte[] data, int startIndex)
	{
		public float coneInsideAngle = BitConverter.ToSingle(data, startIndex);

		public float coneOutsideAngle = BitConverter.ToSingle(data, startIndex + 4);

		public float minAttenuationDistance = BitConverter.ToSingle(data, startIndex + 8);

		public float maxAttenuationDistance = BitConverter.ToSingle(data, startIndex + 12);

		public float sourceRadius = BitConverter.ToSingle(data, startIndex + 16);

		public float interiorDistance = BitConverter.ToSingle(data, startIndex + 20);

		public float dopplerFactor = BitConverter.ToSingle(data, startIndex + 24);

		public Randomize3dConfig randomPos = new Randomize3dConfig(data, startIndex + 28);

		public uint distanceAisacControl = BitConverter.ToUInt32(data, startIndex + 48);

		public uint listenerBaseAngleAisacControl = BitConverter.ToUInt32(data, startIndex + 52);

		public uint sourceBaseAngleAisacControl = BitConverter.ToUInt32(data, startIndex + 56);

		public uint listenerBaseElevationAisacControl = BitConverter.ToUInt32(data, startIndex + 60);

		public uint sourceBaseElevationAisacControl = BitConverter.ToUInt32(data, startIndex + 64);
	}

	public struct GameVariableInfo
	{
		[MarshalAs(UnmanagedType.LPStr)]
		public readonly string name;

		public uint id;

		public float gameValue;

		public GameVariableInfo(byte[] data, int startIndex)
		{
			if (IntPtr.Size == 4)
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex)));
				id = BitConverter.ToUInt32(data, startIndex + 4);
				gameValue = BitConverter.ToSingle(data, startIndex + 8);
			}
			else
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex)));
				id = BitConverter.ToUInt32(data, startIndex + 8);
				gameValue = BitConverter.ToSingle(data, startIndex + 12);
			}
		}

		public GameVariableInfo(string name, uint id, float gameValue)
		{
			this.name = name;
			this.id = id;
			this.gameValue = gameValue;
		}
	}

	public enum CueType
	{
		Polyphonic,
		Sequential,
		Shuffle,
		Random,
		RandomNoRepeat,
		SwitchGameVariable,
		ComboSequential,
		SwitchSelector,
		TrackTransitionBySelector
	}

	public enum SilentMode
	{
		Normal,
		Stop,
		Virtual,
		VirtualRetrigger
	}

	public struct CueInfo
	{
		public int id;

		public CueType type;

		[MarshalAs(UnmanagedType.LPStr)]
		public readonly string name;

		[MarshalAs(UnmanagedType.LPStr)]
		public readonly string userData;

		public long length;

		[MarshalAs(UnmanagedType.ByValArray, SizeConst = 16)]
		public ushort[] categories;

		public short numLimits;

		public ushort numBlocks;

		public ushort numTracks;

		public ushort numRelatedWaveForms;

		public byte priority;

		public byte headerVisibility;

		public byte ignore_player_parameter;

		public byte probability;

		public PanType panType;

		public CuePos3dInfo pos3dInfo;

		public GameVariableInfo gameVariableInfo;

		public float volume;

		public SilentMode silentMode;

		public float pitch;

		public ushort selectorIndex;

		public CueInfo(byte[] data, int startIndex)
		{
			if (IntPtr.Size == 4)
			{
				id = BitConverter.ToInt32(data, startIndex);
				type = (CueType)BitConverter.ToInt32(data, startIndex + 4);
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex + 8)));
				userData = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex + 12)));
				length = BitConverter.ToInt64(data, startIndex + 16);
				categories = new ushort[16];
				for (int i = 0; i < 16; i++)
				{
					categories[i] = BitConverter.ToUInt16(data, startIndex + 24 + 2 * i);
				}
				numLimits = BitConverter.ToInt16(data, startIndex + 56);
				numBlocks = BitConverter.ToUInt16(data, startIndex + 58);
				numTracks = BitConverter.ToUInt16(data, startIndex + 60);
				numRelatedWaveForms = BitConverter.ToUInt16(data, startIndex + 62);
				priority = data[startIndex + 64];
				headerVisibility = data[startIndex + 65];
				ignore_player_parameter = data[startIndex + 66];
				probability = data[startIndex + 67];
				panType = (PanType)BitConverter.ToInt32(data, startIndex + 68);
				pos3dInfo = new CuePos3dInfo(data, startIndex + 72);
				gameVariableInfo = new GameVariableInfo(data, startIndex + 140);
				volume = BitConverter.ToSingle(data, startIndex + 152);
				silentMode = (SilentMode)BitConverter.ToInt32(data, startIndex + 156);
				pitch = BitConverter.ToSingle(data, startIndex + 160);
				selectorIndex = BitConverter.ToUInt16(data, startIndex + 162);
			}
			else
			{
				id = BitConverter.ToInt32(data, startIndex);
				type = (CueType)BitConverter.ToInt32(data, startIndex + 4);
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex + 8)));
				userData = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex + 16)));
				length = BitConverter.ToInt64(data, startIndex + 24);
				categories = new ushort[16];
				for (int j = 0; j < 16; j++)
				{
					categories[j] = BitConverter.ToUInt16(data, startIndex + 32 + 2 * j);
				}
				numLimits = BitConverter.ToInt16(data, startIndex + 64);
				numBlocks = BitConverter.ToUInt16(data, startIndex + 66);
				numTracks = BitConverter.ToUInt16(data, startIndex + 68);
				numRelatedWaveForms = BitConverter.ToUInt16(data, startIndex + 70);
				priority = data[startIndex + 72];
				headerVisibility = data[startIndex + 73];
				ignore_player_parameter = data[startIndex + 74];
				probability = data[startIndex + 75];
				panType = (PanType)BitConverter.ToInt32(data, startIndex + 76);
				pos3dInfo = new CuePos3dInfo(data, startIndex + 80);
				gameVariableInfo = new GameVariableInfo(data, startIndex + 152);
				volume = BitConverter.ToSingle(data, startIndex + 168);
				silentMode = (SilentMode)BitConverter.ToInt32(data, startIndex + 172);
				pitch = BitConverter.ToSingle(data, startIndex + 176);
				selectorIndex = BitConverter.ToUInt16(data, startIndex + 178);
			}
		}
	}

	public struct WaveformInfo
	{
		public int waveId;

		public uint format;

		public int samplingRate;

		public int numChannels;

		public long numSamples;

		public bool streamingFlag;

		[MarshalAs(UnmanagedType.ByValArray, SizeConst = 1)]
		public uint[] reserved;

		public WaveformInfo(byte[] data, int startIndex)
		{
			waveId = BitConverter.ToInt32(data, startIndex);
			format = BitConverter.ToUInt32(data, startIndex + 4);
			samplingRate = BitConverter.ToInt32(data, startIndex + 8);
			numChannels = BitConverter.ToInt32(data, startIndex + 12);
			numSamples = BitConverter.ToInt64(data, startIndex + 16);
			streamingFlag = BitConverter.ToInt32(data, startIndex + 24) != 0;
			reserved = new uint[1];
			for (int i = 0; i < 1; i++)
			{
				reserved[i] = BitConverter.ToUInt32(data, startIndex + 28 + 4 * i);
			}
		}
	}

	public struct AisacInfo
	{
		[MarshalAs(UnmanagedType.LPStr)]
		public readonly string name;

		public bool defaultControlFlag;

		public float defaultControlValue;

		public uint controlId;

		[MarshalAs(UnmanagedType.LPStr)]
		public readonly string controlName;

		public AisacInfo(byte[] data, int startIndex)
		{
			if (IntPtr.Size == 4)
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex)));
				defaultControlFlag = BitConverter.ToInt32(data, startIndex + 4) != 0;
				defaultControlValue = BitConverter.ToSingle(data, startIndex + 8);
				controlId = BitConverter.ToUInt32(data, startIndex + 12);
				controlName = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex + 16)));
			}
			else
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex)));
				defaultControlFlag = BitConverter.ToInt32(data, startIndex + 8) != 0;
				defaultControlValue = BitConverter.ToSingle(data, startIndex + 12);
				controlId = BitConverter.ToUInt32(data, startIndex + 16);
				controlName = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex + 20)));
			}
		}
	}

	public struct PerformanceInfo
	{
		public uint serverProcessCount;

		public uint lastServerTime;

		public uint maxServerTime;

		public uint averageServerTime;

		public uint lastServerInterval;

		public uint maxServerInterval;

		public uint averageServerInterval;
	}

	public struct ResourceUsage
	{
		public uint useCount;

		public uint limit;
	}

	public struct NativeVector
	{
		public float x;

		public float y;

		public float z;

		public NativeVector(float x, float y, float z)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}

		public NativeVector(Vector3 vector)
		{
			x = vector.x;
			y = vector.y;
			z = vector.z;
		}
	}

	public struct CueLinkInfo
	{
		public IntPtr nativePlayerHn;

		public uint basePlaybackId;

		public uint targetPlaybackId;

		public int cueLinkType;
	}

	[UnmanagedFunctionPointer(CallingConvention.Cdecl)]
	public delegate void CueLinkCbFunc(ref CueLinkInfo info);

	public const uint InvalidAisacControlId = uint.MaxValue;

	public static readonly Dictionary<Randomize3dCalcType, Randomize3dParamType[]> randomize3dParamTable = new Dictionary<Randomize3dCalcType, Randomize3dParamType[]>
	{
		{
			Randomize3dCalcType.None,
			new Randomize3dParamType[3]
		},
		{
			Randomize3dCalcType.Rectangle,
			new Randomize3dParamType[3]
			{
				Randomize3dParamType.Width,
				Randomize3dParamType.Depth,
				Randomize3dParamType.None
			}
		},
		{
			Randomize3dCalcType.Cuboid,
			new Randomize3dParamType[3]
			{
				(Randomize3dParamType)1818323314,
				(Randomize3dParamType)1952545385,
				(Randomize3dParamType)1164865385
			}
		},
		{
			Randomize3dCalcType.Circle,
			new Randomize3dParamType[3]
			{
				Randomize3dParamType.Radius,
				Randomize3dParamType.None,
				Randomize3dParamType.None
			}
		},
		{
			Randomize3dCalcType.Cylinder,
			new Randomize3dParamType[3]
			{
				Randomize3dParamType.Radius,
				Randomize3dParamType.Height,
				Randomize3dParamType.None
			}
		},
		{
			Randomize3dCalcType.Sphere,
			new Randomize3dParamType[3]
			{
				Randomize3dParamType.Radius,
				Randomize3dParamType.None,
				Randomize3dParamType.None
			}
		},
		{
			Randomize3dCalcType.List,
			new Randomize3dParamType[3]
		}
	};

	public static event CueLinkCbFunc OnCueLinkCallback
	{
		add
		{
			CriAtom.OnCueLinkCallback += value;
		}
		remove
		{
			CriAtom.OnCueLinkCallback -= value;
		}
	}

	public static void SetSpeakerAngle(SpeakerAngles6ch speakerAngle)
	{
		criAtomEx_SetSpeakerAngleArray(SpeakerSystem.Surround_5_1, ref speakerAngle);
	}

	public static void SetSpeakerAngle(SpeakerAngles8ch speakerAngle)
	{
		criAtomEx_SetSpeakerAngleArray(SpeakerSystem.Surround_7_1, ref speakerAngle);
	}

	public static void SetVirtualSpeakerAngle(SpeakerAngles6ch speakerAngle)
	{
		criAtomEx_SetVirtualSpeakerAngleArray(SpeakerSystem.Surround_5_1, ref speakerAngle);
	}

	public static void SetVirtualSpeakerAngle(SpeakerAngles8ch speakerAngle)
	{
		criAtomEx_SetVirtualSpeakerAngleArray(SpeakerSystem.Surround_7_1, ref speakerAngle);
	}

	public static void ControlVirtualSpeakerSetting(bool sw)
	{
		criAtomEx_ControlVirtualSpeakerSetting(sw);
	}

	public static bool RegisterAcf(CriFsBinder binder, string acfPath)
	{
		return criAtomEx_RegisterAcfFile(binder?.nativeHandle ?? IntPtr.Zero, acfPath, IntPtr.Zero, 0);
	}

	public static bool RegisterAcf(IntPtr acfData, int dataSize)
	{
		return criAtomEx_RegisterAcfData(acfData, dataSize, IntPtr.Zero, 0);
	}

	[Obsolete("Use RegisterAcf(IntPtr, int) instead")]
	public static bool RegisterAcf(byte[] acfData)
	{
		return criAtomEx_RegisterAcfData(acfData, acfData.Length, IntPtr.Zero, 0);
	}

	public static void UnregisterAcf()
	{
		criAtomEx_UnregisterAcf();
	}

	public static string GetAppliedDspBusSnapshotName()
	{
		IntPtr intPtr = criAtomEx_GetAppliedDspBusSnapshotName();
		if (intPtr == IntPtr.Zero)
		{
			return null;
		}
		return Marshal.PtrToStringAnsi(intPtr);
	}

	public static void AttachDspBusSetting(string settingName)
	{
		criAtomEx_AttachDspBusSetting(settingName, IntPtr.Zero, 0);
	}

	public static void DetachDspBusSetting()
	{
		criAtomEx_DetachDspBusSetting();
	}

	public static void ApplyDspBusSnapshot(string snapshot_name, int time_ms)
	{
		criAtomEx_ApplyDspBusSnapshot(snapshot_name, time_ms);
	}

	public static int GetNumGameVariables()
	{
		return criAtomEx_GetNumGameVariables();
	}

	public static bool GetGameVariableInfo(ushort index, out GameVariableInfo info)
	{
		using CriStructMemory<GameVariableInfo> criStructMemory = new CriStructMemory<GameVariableInfo>();
		bool result = criAtomEx_GetGameVariableInfo(index, criStructMemory.ptr);
		info = new GameVariableInfo(criStructMemory.bytes, 0);
		return result;
	}

	public static float GetGameVariable(uint game_variable_id)
	{
		return criAtomEx_GetGameVariableById(game_variable_id);
	}

	public static float GetGameVariable(string game_variable_name)
	{
		return criAtomEx_GetGameVariableByName(game_variable_name);
	}

	public static void SetGameVariable(uint game_variable_id, float game_variable_value)
	{
		criAtomEx_SetGameVariableById(game_variable_id, game_variable_value);
	}

	public static void SetGameVariable(string game_variable_name, float game_variable_value)
	{
		criAtomEx_SetGameVariableByName(game_variable_name, game_variable_value);
	}

	public static void SetRandomSeed(uint seed)
	{
		criAtomEx_SetRandomSeed(seed);
	}

	public static void ResetPerformanceMonitor()
	{
		criAtom_ResetPerformanceMonitor();
	}

	public static void GetPerformanceInfo(out PerformanceInfo info)
	{
		criAtom_GetPerformanceInfo(out info);
	}

	public static void SetGlobalLabelToSelectorByIndex(ushort selector_index, ushort label_index)
	{
		criAtomExAcf_SetGlobalLabelToSelectorByIndex(selector_index, label_index);
	}

	public static void SetGlobalLabelToSelectorByName(string selector_name, string label_name)
	{
		criAtomExAcf_SetGlobalLabelToSelectorByName(selector_name, label_name);
	}

	public static void PauseTimer(bool sw)
	{
		criAtomEx_PauseTimer(sw);
	}

	public static void Lock()
	{
		criAtomEx_Lock();
	}

	public static void Unlock()
	{
		criAtomEx_Unlock();
	}

	public static void SetOutputAudioDevice_PC(string deviceId)
	{
		string deviceId2 = ((!string.IsNullOrEmpty(deviceId) && !deviceId.Contains("{")) ? ("{0.0.0.00000000}.{" + deviceId + "}") : deviceId);
		criAtom_SetDeviceId_WASAPI(SoundRendererType.Native, deviceId2);
	}

	public static string GetOutputAudioDeviceId_PC(out bool isDefaultDevice)
	{
		StringBuilder stringBuilder = new StringBuilder(256);
		criAtom_GetDeviceId_WASAPI(SoundRendererType.Native, stringBuilder, stringBuilder.Capacity, out var is_default_device);
		isDefaultDevice = is_default_device != 0;
		string result = stringBuilder.ToString();
		stringBuilder.Clear();
		return result;
	}

	public static int GetOutputAudioDeviceIndex_PC(out bool isDefaultDevice)
	{
		string outputAudioDeviceId_PC = GetOutputAudioDeviceId_PC(out isDefaultDevice);
		char[] array = new char[outputAudioDeviceId_PC.Length];
		for (int i = 0; i < GetNumAudioDevices_PC(); i++)
		{
			Marshal.Copy(criAtomUnity_GetAudioDeviceId_PC(i), array, 0, outputAudioDeviceId_PC.Length);
			if (Enumerable.SequenceEqual(outputAudioDeviceId_PC, array))
			{
				return i;
			}
		}
		return -1;
	}

	public static bool LoadAudioDeviceList_PC()
	{
		return criAtomUnity_LoadAudioDeviceList_PC();
	}

	public static int GetNumAudioDevices_PC()
	{
		return criAtomUnity_GetNumAudioDevices_PC();
	}

	public static string GetAudioDeviceName_PC(int index)
	{
		IntPtr intPtr = criAtomUnity_GetAudioDeviceName_PC(index);
		if (intPtr == IntPtr.Zero)
		{
			return null;
		}
		return Marshal.PtrToStringAnsi(intPtr);
	}

	public static void SetOutputAudioDevice_PC(int index)
	{
		IntPtr deviceId = criAtomUnity_GetAudioDeviceId_PC(index);
		criAtom_SetDeviceId_WASAPI(SoundRendererType.Native, deviceId);
	}

	public static void SetOutputVolume_VITA(float volume)
	{
	}

	public static bool IsBgmPortAcquired_VITA()
	{
		return true;
	}

	public static void EnableBackgroundPlayback_IOS()
	{
	}

	public static void DisableBackgroundPlayback_IOS()
	{
	}

	public static bool IsInterruptedOtherAudio_IOS()
	{
		return false;
	}

	public static void ResumeAudio_IOS()
	{
	}

	public static bool IsSoundStopped_IOS()
	{
		return false;
	}

	public static void EnableAudioSessionRestoration_IOS(bool flag)
	{
	}

	public static void EnableBusSendOffsetWhenLevelNotExist(bool enable)
	{
		criAtomEx_EnableBusSendOffsetWhenLevelNotExist(enable);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomEx_RegisterAcfFile(IntPtr binder, string path, IntPtr work, int workSize);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomEx_RegisterAcfData(IntPtr acfData, int acfDataSize, IntPtr work, int workSize);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomEx_RegisterAcfData(byte[] acfData, int acfDataSize, IntPtr work, int workSize);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_UnregisterAcf();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_AttachDspBusSetting(string settingName, IntPtr work, int workSize);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_DetachDspBusSetting();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_ApplyDspBusSnapshot(string snapshot_name, int time_ms);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomEx_GetAppliedDspBusSnapshotName();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomEx_GetNumGameVariables();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomEx_GetGameVariableInfo(ushort index, IntPtr game_variable_info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criAtomEx_GetGameVariableById(uint game_variable_id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern float criAtomEx_GetGameVariableByName(string game_variable_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_SetGameVariableById(uint game_variable_id, float game_variable_value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_SetGameVariableByName(string game_variable_name, float game_variable_value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_SetRandomSeed(uint seed);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_PauseTimer(bool sw);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_Lock();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_Unlock();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtom_ResetPerformanceMonitor();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtom_GetPerformanceInfo(out PerformanceInfo info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAcf_SetGlobalLabelToSelectorByIndex(ushort selector_index, ushort label_index);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExAcf_SetGlobalLabelToSelectorByName(string selector_name, string label_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_SetSpeakerAngleArray(SpeakerSystem speaker_system, ref SpeakerAngles6ch angle_array);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_SetSpeakerAngleArray(SpeakerSystem speaker_system, ref SpeakerAngles8ch angle_array);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_SetVirtualSpeakerAngleArray(SpeakerSystem speaker_system, ref SpeakerAngles6ch angle_array);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_SetVirtualSpeakerAngleArray(SpeakerSystem speaker_system, ref SpeakerAngles8ch angle_array);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_ControlVirtualSpeakerSetting(bool sw);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomEx_EnableBusSendOffsetWhenLevelNotExist(bool enable);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtom_SetDeviceId_WASAPI(SoundRendererType soundRendererType, [MarshalAs(UnmanagedType.LPWStr)] string deviceId);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtom_GetDeviceId_WASAPI(SoundRendererType soundRendererType, [MarshalAs(UnmanagedType.LPWStr)] StringBuilder deviceId, int count, out int is_default_device);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtom_SetDeviceId_WASAPI(SoundRendererType type, IntPtr deviceId);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomUnity_LoadAudioDeviceList_PC();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomUnity_GetNumAudioDevices_PC();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomUnity_GetAudioDeviceName_PC(int index);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomUnity_GetAudioDeviceId_PC(int index);
}
