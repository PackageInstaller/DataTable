using System;
using System.Runtime.InteropServices;

public class CriAtomExAcf
{
	public struct AcfDspSettingInfo
	{
		[MarshalAs(UnmanagedType.LPStr)]
		public string name;

		[MarshalAs(UnmanagedType.ByValArray, SizeConst = 64)]
		public ushort[] busIndexes;

		[MarshalAs(UnmanagedType.ByValArray, SizeConst = 64)]
		public ushort[] extendBusIndexes;

		public ushort snapshotStartIndex;

		public byte numBuses;

		public byte numExtendBuses;

		public ushort numSnapshots;

		public ushort snapshotWorkSize;

		public ushort numMixerAisacs;

		public ushort mixerAisacStartIndex;

		public AcfDspSettingInfo(byte[] data, int startIndex)
		{
			if (IntPtr.Size == 4)
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex)));
				busIndexes = new ushort[64];
				for (int i = 0; i < 64; i++)
				{
					busIndexes[i] = BitConverter.ToUInt16(data, startIndex + 4 + 2 * i);
				}
				extendBusIndexes = new ushort[64];
				for (int j = 0; j < 64; j++)
				{
					extendBusIndexes[j] = BitConverter.ToUInt16(data, startIndex + 132 + 2 * j);
				}
				snapshotStartIndex = BitConverter.ToUInt16(data, startIndex + 260);
				numBuses = data[startIndex + 262];
				numExtendBuses = data[startIndex + 263];
				numSnapshots = BitConverter.ToUInt16(data, startIndex + 264);
				snapshotWorkSize = BitConverter.ToUInt16(data, startIndex + 266);
				numMixerAisacs = BitConverter.ToUInt16(data, startIndex + 268);
				mixerAisacStartIndex = BitConverter.ToUInt16(data, startIndex + 270);
			}
			else
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex)));
				busIndexes = new ushort[64];
				for (int k = 0; k < 64; k++)
				{
					busIndexes[k] = BitConverter.ToUInt16(data, startIndex + 8 + 2 * k);
				}
				extendBusIndexes = new ushort[64];
				for (int l = 0; l < 64; l++)
				{
					extendBusIndexes[l] = BitConverter.ToUInt16(data, startIndex + 136 + 2 * l);
				}
				snapshotStartIndex = BitConverter.ToUInt16(data, startIndex + 264);
				numBuses = data[startIndex + 265];
				numExtendBuses = data[startIndex + 266];
				numSnapshots = BitConverter.ToUInt16(data, startIndex + 268);
				snapshotWorkSize = BitConverter.ToUInt16(data, startIndex + 270);
				numMixerAisacs = BitConverter.ToUInt16(data, startIndex + 272);
				mixerAisacStartIndex = BitConverter.ToUInt16(data, startIndex + 274);
			}
		}
	}

	public struct AcfDspSettingSnapshotInfo
	{
		[MarshalAs(UnmanagedType.LPStr)]
		public string name;

		public byte numBuses;

		public byte numExtendBuses;

		[MarshalAs(UnmanagedType.ByValArray, SizeConst = 2)]
		public byte[] reserved;

		[MarshalAs(UnmanagedType.ByValArray, SizeConst = 64)]
		public ushort[] busIndexes;

		[MarshalAs(UnmanagedType.ByValArray, SizeConst = 64)]
		public ushort[] extendBusIndexes;

		public AcfDspSettingSnapshotInfo(byte[] data, int startIndex)
		{
			if (IntPtr.Size == 4)
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex)));
				numBuses = data[startIndex + 4];
				numExtendBuses = data[startIndex + 5];
				reserved = new byte[2];
				for (int i = 0; i < 2; i++)
				{
					reserved[i] = data[startIndex + 6 + i];
				}
				busIndexes = new ushort[64];
				for (int j = 0; j < 64; j++)
				{
					busIndexes[j] = BitConverter.ToUInt16(data, startIndex + 8 + 2 * j);
				}
				extendBusIndexes = new ushort[64];
				for (int k = 0; k < 64; k++)
				{
					extendBusIndexes[k] = BitConverter.ToUInt16(data, startIndex + 136 + 2 * k);
				}
			}
			else
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex)));
				numBuses = data[startIndex + 8];
				numExtendBuses = data[startIndex + 9];
				reserved = new byte[2];
				for (int l = 0; l < 2; l++)
				{
					reserved[l] = data[startIndex + 10 + l];
				}
				busIndexes = new ushort[64];
				for (int m = 0; m < 64; m++)
				{
					busIndexes[m] = BitConverter.ToUInt16(data, startIndex + 12 + 2 * m);
				}
				extendBusIndexes = new ushort[64];
				for (int n = 0; n < 64; n++)
				{
					extendBusIndexes[n] = BitConverter.ToUInt16(data, startIndex + 140 + 2 * n);
				}
			}
		}
	}

	public struct AcfDspBusInfo
	{
		public IntPtr namePointer;

		public float volume;

		public float pan3dVolume;

		public float pan3dAngle;

		public float pan3dDistance;

		public float pan3dSpread;

		public float pan3dWideness;

		[MarshalAs(UnmanagedType.ByValArray, SizeConst = 8)]
		public ushort[] fxIndexes;

		[MarshalAs(UnmanagedType.ByValArray, SizeConst = 64)]
		public ushort[] busLinkIndexes;

		public ushort busNo;

		public byte numFxes;

		public byte numBusLinks;

		public CriAtom.SpeakerMapping speakerMapping;

		public DspBusOutputType outputType;

		public byte outputOptions;

		public string name => Marshal.PtrToStringAnsi(namePointer);
	}

	public enum DspBusOutputType
	{
		None,
		Main,
		MainPassthrough,
		PadHaptic,
		PadSpeaker,
		Personal,
		PersonalPassthrough
	}

	public enum AcfDspBusLinkType : uint
	{
		preVolume,
		postVolume,
		postPan
	}

	public struct AcfDspBusLinkInfo(byte[] data, int startIndex)
	{
		public AcfDspBusLinkType type = (AcfDspBusLinkType)Enum.ToObject(typeof(AcfDspBusLinkType), BitConverter.ToUInt32(data, startIndex));

		public float sendLevel = BitConverter.ToSingle(data, startIndex + 4);

		public ushort busNo = BitConverter.ToUInt16(data, startIndex + 8);

		public ushort busId = BitConverter.ToUInt16(data, startIndex + 10);
	}

	public struct CategoryInfo
	{
		public uint groupNo;

		public uint id;

		[MarshalAs(UnmanagedType.LPStr)]
		public string name;

		public uint numCueLimits;

		public float volume;

		public CategoryInfo(byte[] data, int startIndex)
		{
			if (IntPtr.Size == 4)
			{
				groupNo = BitConverter.ToUInt16(data, startIndex);
				id = BitConverter.ToUInt16(data, startIndex + 4);
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex + 8)));
				numCueLimits = BitConverter.ToUInt16(data, startIndex + 12);
				volume = BitConverter.ToSingle(data, startIndex + 16);
			}
			else
			{
				groupNo = BitConverter.ToUInt16(data, startIndex);
				id = BitConverter.ToUInt16(data, startIndex + 4);
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex + 8)));
				numCueLimits = BitConverter.ToUInt16(data, startIndex + 16);
				volume = BitConverter.ToSingle(data, startIndex + 20);
			}
		}
	}

	public enum AcfAisacType : uint
	{
		normal,
		autoModulation
	}

	public struct GlobalAisacInfo
	{
		[MarshalAs(UnmanagedType.LPStr)]
		public string name;

		public ushort index;

		public ushort numGraphs;

		public AcfAisacType type;

		public float randomRange;

		public ushort controlId;

		public ushort dummy;

		public GlobalAisacInfo(byte[] data, int startIndex)
		{
			if (IntPtr.Size == 4)
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex)));
				index = BitConverter.ToUInt16(data, startIndex + 4);
				numGraphs = BitConverter.ToUInt16(data, startIndex + 6);
				type = (AcfAisacType)Enum.ToObject(typeof(AcfAisacType), BitConverter.ToUInt32(data, startIndex + 8));
				randomRange = BitConverter.ToSingle(data, startIndex + 12);
				controlId = BitConverter.ToUInt16(data, startIndex + 16);
				dummy = BitConverter.ToUInt16(data, startIndex + 18);
			}
			else
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex)));
				index = BitConverter.ToUInt16(data, startIndex + 8);
				numGraphs = BitConverter.ToUInt16(data, startIndex + 10);
				type = (AcfAisacType)Enum.ToObject(typeof(AcfAisacType), BitConverter.ToUInt32(data, startIndex + 12));
				randomRange = BitConverter.ToSingle(data, startIndex + 16);
				controlId = BitConverter.ToUInt16(data, startIndex + 20);
				dummy = BitConverter.ToUInt16(data, startIndex + 22);
			}
		}
	}

	public enum AisacGraphType
	{
		none,
		volume,
		pitch,
		bandpassHigh,
		bandpassLow,
		biquadFreq,
		biquadQ,
		busSend0,
		busSend1,
		busSend2,
		busSend3,
		busSend4,
		busSend5,
		busSend6,
		busSend7,
		pan3dAngel,
		pan3dVolume,
		pan3dInteriorDistance,
		pan3dCenter,
		pan3dLfe,
		aisac0,
		aisac1,
		aisac2,
		aisac3,
		aisac4,
		aisac5,
		aisac6,
		aisac7,
		aisac8,
		aisac9,
		aisac10,
		aisac11,
		aisac12,
		aisac13,
		aisac14,
		aisac15,
		priority,
		preDelayTime,
		biquadGain,
		pan3dMixdownCenter,
		pan3dMixdownLfe,
		egAttack,
		egRelease,
		playbackRatio,
		drySendL,
		drySendR,
		drySendCenter,
		drySendLfe,
		drySendSl,
		drySendSr,
		drySendEx1,
		drySendEx2,
		panSpread
	}

	public struct AisacGraphInfo(byte[] data, int startIndex)
	{
		public AisacGraphType type = (AisacGraphType)Enum.ToObject(typeof(AisacGraphType), BitConverter.ToInt32(data, startIndex));
	}

	public enum CharacterEncoding : uint
	{
		utf8,
		sjis
	}

	public struct AcfInfo
	{
		[MarshalAs(UnmanagedType.LPStr)]
		public string name;

		public uint size;

		public uint version;

		public CharacterEncoding characterEncoding;

		public int numDspSettings;

		public int numCategories;

		public int numCategoriesPerPlayback;

		public int numReacts;

		public int numAisacControls;

		public int numGlobalAisacs;

		public int numGameVariables;

		public int maxBusesOfDspBusSettings;

		public int numBuses;

		public int numVoiceLimitGroups;

		public int numOutputPorts;

		public AcfInfo(byte[] data, int startIndex)
		{
			if (IntPtr.Size == 4)
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex)));
				size = BitConverter.ToUInt32(data, startIndex + 4);
				version = BitConverter.ToUInt32(data, startIndex + 8);
				characterEncoding = (CharacterEncoding)Enum.ToObject(typeof(CharacterEncoding), BitConverter.ToUInt32(data, startIndex + 12));
				numDspSettings = BitConverter.ToInt32(data, startIndex + 16);
				numCategories = BitConverter.ToInt32(data, startIndex + 20);
				numCategoriesPerPlayback = BitConverter.ToInt32(data, startIndex + 24);
				numReacts = BitConverter.ToInt32(data, startIndex + 28);
				numAisacControls = BitConverter.ToInt32(data, startIndex + 32);
				numGlobalAisacs = BitConverter.ToInt32(data, startIndex + 36);
				numGameVariables = BitConverter.ToInt32(data, startIndex + 40);
				maxBusesOfDspBusSettings = BitConverter.ToInt32(data, startIndex + 44);
				numBuses = BitConverter.ToInt32(data, startIndex + 48);
				numVoiceLimitGroups = BitConverter.ToInt32(data, startIndex + 52);
				numOutputPorts = BitConverter.ToInt32(data, startIndex + 56);
			}
			else
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex)));
				size = BitConverter.ToUInt32(data, startIndex + 8);
				version = BitConverter.ToUInt32(data, startIndex + 12);
				characterEncoding = (CharacterEncoding)Enum.ToObject(typeof(CharacterEncoding), BitConverter.ToUInt32(data, startIndex + 16));
				numDspSettings = BitConverter.ToInt32(data, startIndex + 20);
				numCategories = BitConverter.ToInt32(data, startIndex + 24);
				numCategoriesPerPlayback = BitConverter.ToInt32(data, startIndex + 28);
				numReacts = BitConverter.ToInt32(data, startIndex + 32);
				numAisacControls = BitConverter.ToInt32(data, startIndex + 36);
				numGlobalAisacs = BitConverter.ToInt32(data, startIndex + 40);
				numGameVariables = BitConverter.ToInt32(data, startIndex + 44);
				maxBusesOfDspBusSettings = BitConverter.ToInt32(data, startIndex + 48);
				numBuses = BitConverter.ToInt32(data, startIndex + 52);
				numVoiceLimitGroups = BitConverter.ToInt32(data, startIndex + 56);
				numOutputPorts = BitConverter.ToInt32(data, startIndex + 60);
			}
		}
	}

	public struct SelectorInfo
	{
		[MarshalAs(UnmanagedType.LPStr)]
		public string name;

		public ushort index;

		public ushort numLabels;

		public ushort globalLabelIndex;

		public SelectorInfo(byte[] data, int startIndex)
		{
			if (IntPtr.Size == 4)
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex)));
				index = BitConverter.ToUInt16(data, startIndex + 4);
				numLabels = BitConverter.ToUInt16(data, startIndex + 6);
				globalLabelIndex = BitConverter.ToUInt16(data, startIndex + 8);
			}
			else
			{
				name = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex)));
				index = BitConverter.ToUInt16(data, startIndex + 8);
				numLabels = BitConverter.ToUInt16(data, startIndex + 10);
				globalLabelIndex = BitConverter.ToUInt16(data, startIndex + 12);
			}
		}
	}

	public struct SelectorLabelInfo
	{
		[MarshalAs(UnmanagedType.LPStr)]
		public string selectorName;

		[MarshalAs(UnmanagedType.LPStr)]
		public string labelName;

		public SelectorLabelInfo(byte[] data, int startIndex)
		{
			if (IntPtr.Size == 4)
			{
				selectorName = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex)));
				labelName = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt32(data, startIndex + 4)));
			}
			else
			{
				selectorName = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex)));
				labelName = Marshal.PtrToStringAnsi(new IntPtr(BitConverter.ToInt64(data, startIndex + 8)));
			}
		}
	}

	public static int GetNumAisacControls()
	{
		return criAtomExAcf_GetNumAisacControls();
	}

	public static bool GetAisacControlInfo(ushort index, out CriAtomEx.AisacControlInfo info)
	{
		using CriStructMemory<CriAtomEx.AisacControlInfo> criStructMemory = new CriStructMemory<CriAtomEx.AisacControlInfo>();
		bool result = criAtomExAcf_GetAisacControlInfo(index, criStructMemory.ptr);
		info = new CriAtomEx.AisacControlInfo(criStructMemory.bytes, 0);
		return result;
	}

	public static int GetNumDspSettings()
	{
		return criAtomExAcf_GetNumDspSettings();
	}

	public static int GetNumDspSettings(IntPtr acfData, int size)
	{
		return criAtomExAcf_GetNumDspSettingsFromAcfData(acfData, size);
	}

	public static string GetDspSettingNameByIndex(ushort index)
	{
		IntPtr intPtr = criAtomExAcf_GetDspSettingNameByIndex(index);
		if (intPtr == IntPtr.Zero)
		{
			return null;
		}
		return Marshal.PtrToStringAnsi(intPtr);
	}

	public static string GetDspSettingNameByIndex(IntPtr acfData, int size, ushort index)
	{
		IntPtr intPtr = criAtomExAcf_GetDspSettingNameByIndexFromAcfData(acfData, size, index);
		if (intPtr == IntPtr.Zero)
		{
			return null;
		}
		return Marshal.PtrToStringAnsi(intPtr);
	}

	public static bool GetDspSettingInformation(string name, out AcfDspSettingInfo info)
	{
		using CriStructMemory<AcfDspSettingInfo> criStructMemory = new CriStructMemory<AcfDspSettingInfo>();
		bool result = criAtomExAcf_GetDspSettingInformation(name, criStructMemory.ptr);
		info = new AcfDspSettingInfo(criStructMemory.bytes, 0);
		return result;
	}

	public static bool GetDspSettingSnapshotInformation(ushort index, out AcfDspSettingSnapshotInfo info)
	{
		using CriStructMemory<AcfDspSettingSnapshotInfo> criStructMemory = new CriStructMemory<AcfDspSettingSnapshotInfo>();
		bool result = criAtomExAcf_GetDspSettingSnapshotInformation(index, criStructMemory.ptr);
		info = new AcfDspSettingSnapshotInfo(criStructMemory.bytes, 0);
		return result;
	}

	public static bool GetDspBusInformation(ushort index, out AcfDspBusInfo info)
	{
		return criAtomExAcf_GetDspBusInformation(index, out info);
	}

	public static bool GetDspBusLinkInformation(ushort index, out AcfDspBusLinkInfo info)
	{
		using CriStructMemory<AcfDspBusLinkInfo> criStructMemory = new CriStructMemory<AcfDspBusLinkInfo>();
		bool result = criAtomExAcf_GetDspBusLinkInformation(index, criStructMemory.ptr);
		info = new AcfDspBusLinkInfo(criStructMemory.bytes, 0);
		return result;
	}

	public static int GetNumCategories()
	{
		return criAtomExAcf_GetNumCategories();
	}

	public static int GetNumCategoriesPerPlayback()
	{
		return criAtomExAcf_GetNumCategoriesPerPlayback();
	}

	public static bool GetCategoryInfoByIndex(ushort index, out CategoryInfo info)
	{
		using CriStructMemory<CategoryInfo> criStructMemory = new CriStructMemory<CategoryInfo>();
		bool result = criAtomExAcf_GetCategoryInfo(index, criStructMemory.ptr);
		info = new CategoryInfo(criStructMemory.bytes, 0);
		return result;
	}

	public static bool GetCategoryInfoByName(string name, out CategoryInfo info)
	{
		using CriStructMemory<CategoryInfo> criStructMemory = new CriStructMemory<CategoryInfo>();
		bool result = criAtomExAcf_GetCategoryInfoByName(name, criStructMemory.ptr);
		info = new CategoryInfo(criStructMemory.bytes, 0);
		return result;
	}

	public static bool GetCategoryInfoById(uint id, out CategoryInfo info)
	{
		using CriStructMemory<CategoryInfo> criStructMemory = new CriStructMemory<CategoryInfo>();
		bool result = criAtomExAcf_GetCategoryInfoById(id, criStructMemory.ptr);
		info = new CategoryInfo(criStructMemory.bytes, 0);
		return result;
	}

	public static int GetNumGlobalAisacs()
	{
		return criAtomExAcf_GetNumGlobalAisacs();
	}

	public static bool GetGlobalAisacInfoByIndex(ushort index, out GlobalAisacInfo info)
	{
		using CriStructMemory<GlobalAisacInfo> criStructMemory = new CriStructMemory<GlobalAisacInfo>();
		bool result = criAtomExAcf_GetGlobalAisacInfo(index, criStructMemory.ptr);
		info = new GlobalAisacInfo(criStructMemory.bytes, 0);
		return result;
	}

	public static bool GetGlobalAisacInfoByName(string name, out GlobalAisacInfo info)
	{
		using CriStructMemory<GlobalAisacInfo> criStructMemory = new CriStructMemory<GlobalAisacInfo>();
		bool result = criAtomExAcf_GetGlobalAisacInfoByName(name, criStructMemory.ptr);
		info = new GlobalAisacInfo(criStructMemory.bytes, 0);
		return result;
	}

	public static bool GetGlobalAisacGraphInfo(GlobalAisacInfo aisacInfo, ushort graphIndex, out AisacGraphInfo graphInfo)
	{
		bool result = false;
		IntPtr intPtr = Marshal.AllocHGlobal(Marshal.SizeOf(typeof(GlobalAisacInfo)));
		Marshal.StructureToPtr(aisacInfo, intPtr, fDeleteOld: false);
		using (CriStructMemory<AisacGraphInfo> criStructMemory = new CriStructMemory<AisacGraphInfo>())
		{
			result = criAtomExAcf_GetGlobalAisacGraphInfo(intPtr, graphIndex, criStructMemory.ptr);
			graphInfo = new AisacGraphInfo(criStructMemory.bytes, 0);
		}
		Marshal.FreeHGlobal(intPtr);
		return result;
	}

	public static bool GetGlobalAisacValue(GlobalAisacInfo aisacInfo, float control, AisacGraphType type, out float value)
	{
		IntPtr intPtr = Marshal.AllocHGlobal(Marshal.SizeOf(typeof(GlobalAisacInfo)));
		Marshal.StructureToPtr(aisacInfo, intPtr, fDeleteOld: false);
		bool result = criAtomExAcf_GetGlobalAisacValue(intPtr, control, type, out value);
		Marshal.FreeHGlobal(intPtr);
		return result;
	}

	public static bool GetAcfInfo(out AcfInfo acfInfo)
	{
		using CriStructMemory<AcfInfo> criStructMemory = new CriStructMemory<AcfInfo>();
		bool result = criAtomExAcf_GetAcfInfo(criStructMemory.ptr);
		acfInfo = new AcfInfo(criStructMemory.bytes, 0);
		return result;
	}

	public static int GetNumSelectors()
	{
		return criAtomExAcf_GetNumSelectors();
	}

	public static bool GetSelectorInfoByIndex(ushort index, out SelectorInfo info)
	{
		using CriStructMemory<SelectorInfo> criStructMemory = new CriStructMemory<SelectorInfo>();
		bool result = criAtomExAcf_GetSelectorInfoByIndex(index, criStructMemory.ptr);
		info = new SelectorInfo(criStructMemory.bytes, 0);
		return result;
	}

	public static bool GetSelectorInfoByName(string name, out SelectorInfo info)
	{
		using CriStructMemory<SelectorInfo> criStructMemory = new CriStructMemory<SelectorInfo>();
		bool result = criAtomExAcf_GetSelectorInfoByName(name, criStructMemory.ptr);
		info = new SelectorInfo(criStructMemory.bytes, 0);
		return result;
	}

	public static bool GetSelectorLabelInfo(SelectorInfo selectorInfo, ushort labelIndex, out SelectorLabelInfo info)
	{
		bool result = false;
		IntPtr intPtr = Marshal.AllocHGlobal(Marshal.SizeOf(typeof(SelectorInfo)));
		Marshal.StructureToPtr(selectorInfo, intPtr, fDeleteOld: false);
		using (CriStructMemory<SelectorLabelInfo> criStructMemory = new CriStructMemory<SelectorLabelInfo>())
		{
			result = criAtomExAcf_GetSelectorLabelInfo(intPtr, labelIndex, criStructMemory.ptr);
			info = new SelectorLabelInfo(criStructMemory.bytes, 0);
		}
		Marshal.FreeHGlobal(intPtr);
		return result;
	}

	public static int GetNumBuses()
	{
		return criAtomExAcf_GetNumBuses();
	}

	public static int GetMaxBusesOfDspBusSettings()
	{
		return criAtomExAcf_GetMaxBusesOfDspBusSettings();
	}

	public static string FindBusName(string busName)
	{
		return criAtomExAcf_FindBusName(busName);
	}

	public static CriAtomExOutputPort GetOutputPort(string name)
	{
		return new CriAtomExOutputPort(criAtomExAcf_GetOutputPortHnByName(name));
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumAisacControls();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetAisacControlInfo(ushort index, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criAtomExAcf_GetAisacControlIdByName(string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern string criAtomExAcf_GetAisacControlNameById(uint id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumDspSettings();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumDspSettingsFromAcfData(IntPtr acf_data, int acf_data_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomExAcf_GetDspSettingNameByIndex(ushort index);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomExAcf_GetDspSettingNameByIndexFromAcfData(IntPtr acf_data, int acf_data_size, ushort index);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetDspSettingInformation(string name, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetDspSettingSnapshotInformation(ushort index, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetDspBusInformation(ushort index, out AcfDspBusInfo info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetDspFxType(ushort index);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern string criAtomExAcf_GetDspFxName(ushort index);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetDspFxParameters(ushort index, IntPtr parameters, int size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetDspBusLinkInformation(ushort index, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumCategoriesFromAcfData(IntPtr acf_data, int acf_data_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumCategories();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumCategoriesPerPlaybackFromAcfData(IntPtr acf_data, int acf_data_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumCategoriesPerPlayback();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetCategoryInfo(ushort index, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetCategoryInfoByName(string name, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetCategoryInfoById(uint id, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumGlobalAisacs();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetGlobalAisacInfo(ushort index, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetGlobalAisacInfoByName(string name, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetGlobalAisacGraphInfo(IntPtr aisac_info, ushort graph_index, IntPtr graph_info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetGlobalAisacValue(IntPtr aisac_info, float control, AisacGraphType type, out float value);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetAcfInfo(IntPtr acf_info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetAcfInfoFromAcfData(IntPtr acf_data, int acf_data_size, IntPtr acf_info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumSelectors();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetSelectorInfoByIndex(ushort index, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetSelectorInfoByName(string name, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern bool criAtomExAcf_GetSelectorLabelInfo(IntPtr selector_info, ushort label_index, IntPtr info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumBusesFromAcfData(IntPtr acf_data, int acf_data_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumBuses();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetMaxBusesOfDspBusSettingsFromAcfData(IntPtr acf_data, int acf_data_size);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetMaxBusesOfDspBusSettings();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern string criAtomExAcf_FindBusName(string bus_name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomExAcf_GetOutputPortHnByName(string name);
}
