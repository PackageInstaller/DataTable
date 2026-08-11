using System;
using System.Collections.Generic;

namespace UnityEngine.InputSystem.HID;

internal static class HIDParser
{
	private struct HIDReportData
	{
		public int reportId;

		public HID.HIDReportType reportType;

		public int currentBitOffset;

		public static int FindOrAddReport(int? reportId, HID.HIDReportType reportType, List<HIDReportData> reports)
		{
			int num = 1;
			if (reportId.HasValue)
			{
				num = reportId.Value;
			}
			for (int i = 0; i < reports.Count; i++)
			{
				if (reports[i].reportId == num && reports[i].reportType == reportType)
				{
					return i;
				}
			}
			reports.Add(new HIDReportData
			{
				reportId = num,
				reportType = reportType
			});
			return reports.Count - 1;
		}
	}

	private enum HIDItemTypeAndTag
	{
		Input = 128,
		Output = 144,
		Feature = 176,
		Collection = 160,
		EndCollection = 192,
		UsagePage = 4,
		LogicalMinimum = 20,
		LogicalMaximum = 36,
		PhysicalMinimum = 52,
		PhysicalMaximum = 68,
		UnitExponent = 84,
		Unit = 100,
		ReportSize = 116,
		ReportID = 132,
		ReportCount = 148,
		Push = 164,
		Pop = 180,
		Usage = 8,
		UsageMinimum = 24,
		UsageMaximum = 40,
		DesignatorIndex = 56,
		DesignatorMinimum = 72,
		DesignatorMaximum = 88,
		StringIndex = 120,
		StringMinimum = 136,
		StringMaximum = 152,
		Delimiter = 168
	}

	private struct HIDItemStateLocal
	{
		public int? usage;

		public int? usageMinimum;

		public int? usageMaximum;

		public int? designatorIndex;

		public int? designatorMinimum;

		public int? designatorMaximum;

		public int? stringIndex;

		public int? stringMinimum;

		public int? stringMaximum;

		public List<int> usageList;

		public static void Reset(ref HIDItemStateLocal state)
		{
			List<int> list = state.usageList;
			state = default(HIDItemStateLocal);
			if (list != null)
			{
				list.Clear();
				state.usageList = list;
			}
		}

		public void SetUsage(int value)
		{
			if (usage.HasValue)
			{
				if (usageList == null)
				{
					usageList = new List<int>();
				}
				usageList.Add(usage.Value);
			}
			usage = value;
		}

		public int GetUsage(int index)
		{
			if (usageMinimum.HasValue && usageMaximum.HasValue)
			{
				int value = usageMinimum.Value;
				int value2 = usageMaximum.Value;
				int num = value2 - value;
				if (num < 0)
				{
					return 0;
				}
				if (index >= num)
				{
					return value2;
				}
				return value + index;
			}
			if (usageList != null && usageList.Count > 0)
			{
				int count = usageList.Count;
				if (index >= count)
				{
					return usage.Value;
				}
				return usageList[index];
			}
			if (usage.HasValue)
			{
				return usage.Value;
			}
			return 0;
		}
	}

	private struct HIDItemStateGlobal
	{
		public int? usagePage;

		public int? logicalMinimum;

		public int? logicalMaximum;

		public int? physicalMinimum;

		public int? physicalMaximum;

		public int? unitExponent;

		public int? unit;

		public int? reportSize;

		public int? reportCount;

		public int? reportId;

		public HID.UsagePage GetUsagePage(int index, ref HIDItemStateLocal localItemState)
		{
			if (!usagePage.HasValue)
			{
				return (HID.UsagePage)(localItemState.GetUsage(index) >> 16);
			}
			return (HID.UsagePage)usagePage.Value;
		}

		public int GetPhysicalMin()
		{
			if (!physicalMinimum.HasValue || !physicalMaximum.HasValue || (physicalMinimum.Value == 0 && physicalMaximum.Value == 0))
			{
				return logicalMinimum ?? 0;
			}
			return physicalMinimum.Value;
		}

		public int GetPhysicalMax()
		{
			if (!physicalMinimum.HasValue || !physicalMaximum.HasValue || (physicalMinimum.Value == 0 && physicalMaximum.Value == 0))
			{
				return logicalMaximum ?? 0;
			}
			return physicalMaximum.Value;
		}
	}

	public unsafe static bool ParseReportDescriptor(byte[] buffer, ref HID.HIDDeviceDescriptor deviceDescriptor)
	{
		if (buffer == null)
		{
			throw new ArgumentNullException("buffer");
		}
		fixed (byte* bufferPtr = buffer)
		{
			return ParseReportDescriptor(bufferPtr, buffer.Length, ref deviceDescriptor);
		}
	}

	public unsafe static bool ParseReportDescriptor(byte* bufferPtr, int bufferLength, ref HID.HIDDeviceDescriptor deviceDescriptor)
	{
		HIDItemStateLocal localItemState = default(HIDItemStateLocal);
		HIDItemStateGlobal hIDItemStateGlobal = default(HIDItemStateGlobal);
		List<HIDReportData> list = new List<HIDReportData>();
		List<HID.HIDElementDescriptor> list2 = new List<HID.HIDElementDescriptor>();
		List<HID.HIDCollectionDescriptor> list3 = new List<HID.HIDCollectionDescriptor>();
		int num = -1;
		byte* ptr = bufferPtr + bufferLength;
		byte* ptr2 = bufferPtr;
		while (ptr2 < ptr)
		{
			byte num2 = *ptr2;
			if (num2 == 254)
			{
				throw new NotImplementedException("long item support");
			}
			byte b = (byte)(num2 & 3);
			byte b2 = (byte)(num2 & 0xFC);
			ptr2++;
			switch (b2)
			{
			case 4:
				hIDItemStateGlobal.usagePage = ReadData(b, ptr2, ptr);
				break;
			case 148:
				hIDItemStateGlobal.reportCount = ReadData(b, ptr2, ptr);
				break;
			case 116:
				hIDItemStateGlobal.reportSize = ReadData(b, ptr2, ptr);
				break;
			case 132:
				hIDItemStateGlobal.reportId = ReadData(b, ptr2, ptr);
				break;
			case 20:
				hIDItemStateGlobal.logicalMinimum = ReadData(b, ptr2, ptr);
				break;
			case 36:
				hIDItemStateGlobal.logicalMaximum = ReadData(b, ptr2, ptr);
				break;
			case 52:
				hIDItemStateGlobal.physicalMinimum = ReadData(b, ptr2, ptr);
				break;
			case 68:
				hIDItemStateGlobal.physicalMaximum = ReadData(b, ptr2, ptr);
				break;
			case 84:
				hIDItemStateGlobal.unitExponent = ReadData(b, ptr2, ptr);
				break;
			case 100:
				hIDItemStateGlobal.unit = ReadData(b, ptr2, ptr);
				break;
			case 8:
				localItemState.SetUsage(ReadData(b, ptr2, ptr));
				break;
			case 24:
				localItemState.usageMinimum = ReadData(b, ptr2, ptr);
				break;
			case 40:
				localItemState.usageMaximum = ReadData(b, ptr2, ptr);
				break;
			case 160:
			{
				int parent = num;
				num = list3.Count;
				list3.Add(new HID.HIDCollectionDescriptor
				{
					type = (HID.HIDCollectionType)ReadData(b, ptr2, ptr),
					parent = parent,
					usagePage = hIDItemStateGlobal.GetUsagePage(0, ref localItemState),
					usage = localItemState.GetUsage(0),
					firstChild = list2.Count
				});
				HIDItemStateLocal.Reset(ref localItemState);
				break;
			}
			case 192:
			{
				if (num == -1)
				{
					return false;
				}
				HID.HIDCollectionDescriptor value2 = list3[num];
				value2.childCount = list2.Count - value2.firstChild;
				list3[num] = value2;
				num = value2.parent;
				HIDItemStateLocal.Reset(ref localItemState);
				break;
			}
			case 128:
			case 144:
			case 176:
			{
				HID.HIDReportType reportType = b2 switch
				{
					144 => HID.HIDReportType.Output, 
					128 => HID.HIDReportType.Input, 
					_ => HID.HIDReportType.Feature, 
				};
				int index = HIDReportData.FindOrAddReport(hIDItemStateGlobal.reportId, reportType, list);
				HIDReportData value = list[index];
				if (value.currentBitOffset == 0 && hIDItemStateGlobal.reportId.HasValue)
				{
					value.currentBitOffset = 8;
				}
				int num3 = hIDItemStateGlobal.reportCount ?? 1;
				int flags = ReadData(b, ptr2, ptr);
				for (int i = 0; i < num3; i++)
				{
					HID.HIDElementDescriptor item = new HID.HIDElementDescriptor
					{
						usage = (localItemState.GetUsage(i) & 0xFFFF),
						usagePage = hIDItemStateGlobal.GetUsagePage(i, ref localItemState),
						reportType = reportType,
						reportSizeInBits = (hIDItemStateGlobal.reportSize ?? 8),
						reportOffsetInBits = value.currentBitOffset,
						reportId = (hIDItemStateGlobal.reportId ?? 1),
						flags = (HID.HIDElementFlags)flags,
						logicalMin = (hIDItemStateGlobal.logicalMinimum ?? 0),
						logicalMax = (hIDItemStateGlobal.logicalMaximum ?? 0),
						physicalMin = hIDItemStateGlobal.GetPhysicalMin(),
						physicalMax = hIDItemStateGlobal.GetPhysicalMax(),
						unitExponent = (hIDItemStateGlobal.unitExponent ?? 0),
						unit = (hIDItemStateGlobal.unit ?? 0)
					};
					value.currentBitOffset += item.reportSizeInBits;
					list2.Add(item);
				}
				list[index] = value;
				HIDItemStateLocal.Reset(ref localItemState);
				break;
			}
			}
			ptr2 = ((b != 3) ? (ptr2 + (int)b) : (ptr2 + 4));
		}
		deviceDescriptor.elements = list2.ToArray();
		deviceDescriptor.collections = list3.ToArray();
		foreach (HID.HIDCollectionDescriptor item2 in list3)
		{
			if (item2.parent == -1 && item2.type == HID.HIDCollectionType.Application)
			{
				deviceDescriptor.usage = item2.usage;
				deviceDescriptor.usagePage = item2.usagePage;
				break;
			}
		}
		return true;
	}

	private unsafe static int ReadData(int itemSize, byte* currentPtr, byte* endPtr)
	{
		switch (itemSize)
		{
		case 0:
			return 0;
		case 1:
			if (currentPtr >= endPtr)
			{
				return 0;
			}
			return *currentPtr;
		case 2:
		{
			if (currentPtr + 2 >= endPtr)
			{
				return 0;
			}
			byte b4 = *currentPtr;
			return (currentPtr[1] << 8) | b4;
		}
		case 3:
		{
			if (currentPtr + 4 >= endPtr)
			{
				return 0;
			}
			byte b = *currentPtr;
			byte b2 = currentPtr[1];
			byte b3 = currentPtr[2];
			return (currentPtr[3] << 24) | (b3 << 24) | (b2 << 8) | b;
		}
		default:
			return 0;
		}
	}
}
