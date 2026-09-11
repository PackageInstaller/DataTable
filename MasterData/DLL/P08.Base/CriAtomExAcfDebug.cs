using System;
using System.Runtime.InteropServices;
using CriAtomDebugDetail;

public static class CriAtomExAcfDebug
{
	public struct CategoryInfo
	{
		public uint groupNo;

		public uint id;

		public string name;

		public uint numCueLimits;

		public float volume;
	}

	public struct DspBusInfo
	{
		public string name;

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
	}

	public struct AisacControlInfo
	{
		public string name;

		public uint id;
	}

	public enum AisacType
	{
		Normal,
		AutoModulation
	}

	public struct GlobalAisacInfo
	{
		public string name;

		public ushort index;

		public ushort numGraphs;

		public AisacType type;

		public float randomRange;

		public ushort controlId;
	}

	public struct SelectorInfo
	{
		public string name;

		public ushort index;

		public ushort numLabels;

		public ushort globalLabelIndex;
	}

	public struct SelectorLabelInfo
	{
		public string selectorName;

		public string labelName;
	}

	private struct CategoryInfoForMarshaling
	{
		public uint groupNo;

		public uint id;

		public IntPtr namePtr;

		public uint numCueLimits;

		public float volume;

		public void Convert(out CategoryInfo x)
		{
			x.groupNo = groupNo;
			x.id = id;
			x.name = Utility.PtrToStringAutoOrNull(namePtr);
			x.numCueLimits = numCueLimits;
			x.volume = volume;
		}
	}

	private struct DspBusInfoForMarshaling
	{
		public IntPtr namePtr;

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

		public CriAtomExAcf.DspBusOutputType outputType;

		public byte outputOptions;

		public void Convert(out DspBusInfo x)
		{
			x.name = Utility.PtrToStringAutoOrNull(namePtr);
			x.volume = volume;
			x.pan3dVolume = pan3dVolume;
			x.pan3dAngle = pan3dAngle;
			x.pan3dDistance = pan3dDistance;
			x.pan3dSpread = pan3dSpread;
			x.pan3dWideness = pan3dWideness;
			x.fxIndexes = fxIndexes;
			x.busLinkIndexes = busLinkIndexes;
			x.busNo = busNo;
			x.numFxes = numFxes;
			x.numBusLinks = numBusLinks;
		}
	}

	private struct AisacControlInfoForMarshaling
	{
		public IntPtr namePtr;

		public uint id;

		public void Convert(out AisacControlInfo x)
		{
			x.name = Utility.PtrToStringAutoOrNull(namePtr);
			x.id = id;
		}
	}

	private struct GlobalAisacInfoForMarshaling
	{
		public IntPtr namePtr;

		public ushort index;

		public ushort numGraphs;

		public uint type;

		public float randomRange;

		public ushort controlId;

		public ushort dummy;

		public void Convert(out GlobalAisacInfo x)
		{
			x.name = Utility.PtrToStringAutoOrNull(namePtr);
			x.index = index;
			x.numGraphs = numGraphs;
			x.type = (AisacType)type;
			x.randomRange = randomRange;
			x.controlId = controlId;
		}
	}

	private struct SelectorInfoForMarshaling
	{
		public IntPtr namePtr;

		public ushort index;

		public ushort numLabels;

		public ushort globalLabelIndex;

		public void Convert(out SelectorInfo x)
		{
			x.name = Utility.PtrToStringAutoOrNull(namePtr);
			x.index = index;
			x.numLabels = numLabels;
			x.globalLabelIndex = globalLabelIndex;
		}
	}

	private struct SelectorLabelInfoForMarshaling
	{
		public IntPtr selectorNamePtr;

		public IntPtr labelNamePtr;

		public void Convert(out SelectorLabelInfo x)
		{
			x.selectorName = Utility.PtrToStringAutoOrNull(selectorNamePtr);
			x.labelName = Utility.PtrToStringAutoOrNull(labelNamePtr);
		}
	}

	public static int GetNumCategories()
	{
		return criAtomExAcf_GetNumCategories();
	}

	public static bool GetCategoryInfoByIndex(ushort index, out CategoryInfo categoryInfo)
	{
		bool result = criAtomExAcf_GetCategoryInfo(index, out var categoryInfo2) != 0;
		categoryInfo2.Convert(out categoryInfo);
		return result;
	}

	public static bool GetCategoryInfoByName(string name, out CategoryInfo categoryInfo)
	{
		bool result = criAtomExAcf_GetCategoryInfoByName(name, out var categoryInfo2) != 0;
		categoryInfo2.Convert(out categoryInfo);
		return result;
	}

	public static bool GetCategoryInfoById(uint id, out CategoryInfo categoryInfo)
	{
		bool result = criAtomExAcf_GetCategoryInfoById(id, out var categoryInfo2) != 0;
		categoryInfo2.Convert(out categoryInfo);
		return result;
	}

	public static int GetNumBuses()
	{
		return criAtomExAcf_GetNumBuses();
	}

	public static bool GetDspBusInformation(ushort index, out DspBusInfo dspBusInfo)
	{
		bool result = criAtomExAcf_GetDspBusInformation(index, out var dspBusInfo2) != 0;
		dspBusInfo2.Convert(out dspBusInfo);
		return result;
	}

	public static int GetNumAisacControls()
	{
		return criAtomExAcf_GetNumAisacControls();
	}

	public static bool GetAisacControlInfo(ushort index, out AisacControlInfo info)
	{
		bool result = criAtomExAcf_GetAisacControlInfo(index, out var info2) != 0;
		info2.Convert(out info);
		return result;
	}

	public static uint GetAisacControlIdByName(string name)
	{
		return criAtomExAcf_GetAisacControlIdByName(name);
	}

	public static string GetAisacControlNameById(uint id)
	{
		return Utility.PtrToStringAutoOrNull(criAtomExAcf_GetAisacControlNameById(id));
	}

	public static int GetNumGlobalAisacs()
	{
		return criAtomExAcf_GetNumGlobalAisacs();
	}

	public static bool GetGlobalAisacInfo(ushort index, out GlobalAisacInfo info)
	{
		bool result = criAtomExAcf_GetGlobalAisacInfo(index, out var info2) != 0;
		info2.Convert(out info);
		return result;
	}

	public static bool GetGlobalAisacInfoByName(string name, out GlobalAisacInfo info)
	{
		bool result = criAtomExAcf_GetGlobalAisacInfoByName(name, out var info2) != 0;
		info2.Convert(out info);
		return result;
	}

	public static int GetNumSelectors()
	{
		return criAtomExAcf_GetNumSelectors();
	}

	public static bool GetSelectorInfoByIndex(ushort index, out SelectorInfo info)
	{
		bool result = criAtomExAcf_GetSelectorInfoByIndex(index, out var info2) != 0;
		info2.Convert(out info);
		return result;
	}

	public static bool GetSelectorInfoByName(string name, out SelectorInfo info)
	{
		bool result = criAtomExAcf_GetSelectorInfoByName(name, out var info2) != 0;
		info2.Convert(out info);
		return result;
	}

	public static bool GetSelectorLabelInfo(ref SelectorInfo selectorInfo, ushort index, out SelectorLabelInfo labelInfo)
	{
		SelectorInfoForMarshaling info = new SelectorInfoForMarshaling
		{
			index = selectorInfo.index,
			numLabels = selectorInfo.numLabels
		};
		bool result = criAtomExAcf_GetSelectorLabelInfo(ref info, index, out var label_info) != 0;
		label_info.Convert(out labelInfo);
		return result;
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumCategories();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetCategoryInfo(ushort index, out CategoryInfoForMarshaling categoryInfo);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetCategoryInfoByName(string name, out CategoryInfoForMarshaling categoryInfo);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetCategoryInfoById(uint id, out CategoryInfoForMarshaling categoryInfo);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumBuses();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetDspBusInformation(ushort index, out DspBusInfoForMarshaling dspBusInfo);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumAisacControls();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetAisacControlInfo(ushort index, out AisacControlInfoForMarshaling info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern uint criAtomExAcf_GetAisacControlIdByName(string name);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern IntPtr criAtomExAcf_GetAisacControlNameById(uint id);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumGlobalAisacs();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetGlobalAisacInfo(ushort index, out GlobalAisacInfoForMarshaling info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetGlobalAisacInfoByName(string name, out GlobalAisacInfoForMarshaling info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetNumSelectors();

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetSelectorInfoByIndex(ushort index, out SelectorInfoForMarshaling info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetSelectorInfoByName(string name, out SelectorInfoForMarshaling info);

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern int criAtomExAcf_GetSelectorLabelInfo(ref SelectorInfoForMarshaling info, ushort labelIndex, out SelectorLabelInfoForMarshaling label_info);
}
