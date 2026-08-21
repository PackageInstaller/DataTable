using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(443)]
[MemoryPackable(GenerateType.Object)]
public class PbCampaignBuildingInfo : MessageObject, IMemoryPackable<PbCampaignBuildingInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCampaignBuildingInfoFormatter : MemoryPackFormatter<PbCampaignBuildingInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCampaignBuildingInfo value)
		{
			PbCampaignBuildingInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCampaignBuildingInfo value)
		{
			PbCampaignBuildingInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int BuildingId { get; set; }

	[MemoryPackOrder(2)]
	public int BuildingLevel { get; set; }

	[MemoryPackOrder(3)]
	public int PointId { get; set; }

	[MemoryPackOrder(4)]
	public bool IsUnlock { get; set; }

	[MemoryPackOrder(5)]
	public List<PbCampaignBuildingMaterialInfo> MaterialInfos { get; set; } = new List<PbCampaignBuildingMaterialInfo>();

	public static PbCampaignBuildingInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCampaignBuildingInfo)) as PbCampaignBuildingInfo;
		}
		return new PbCampaignBuildingInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			BuildingId = 0;
			BuildingLevel = 0;
			PointId = 0;
			IsUnlock = false;
			MaterialInfos.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCampaignBuildingInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCampaignBuildingInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCampaignBuildingInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCampaignBuildingInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCampaignBuildingInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCampaignBuildingMaterialInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCampaignBuildingMaterialInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCampaignBuildingInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, bool>(6, value.IsFromPool, value.BuildingId, value.BuildingLevel, value.PointId, value.IsUnlock);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCampaignBuildingMaterialInfo>>(value.MaterialInfos));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCampaignBuildingInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		bool value6;
		List<PbCampaignBuildingMaterialInfo> value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.BuildingId;
				value4 = value.BuildingLevel;
				value5 = value.PointId;
				value6 = value.IsUnlock;
				value7 = value.MaterialInfos;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<bool>(out value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				goto IL_014b;
			}
			reader.ReadUnmanaged<bool, int, int, int, bool>(out value2, out value3, out value4, out value5, out value6);
			value7 = ListFormatter.DeserializePackable<PbCampaignBuildingMaterialInfo>(ref reader);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCampaignBuildingInfo), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = false;
				value7 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.BuildingId;
				value4 = value.BuildingLevel;
				value5 = value.PointId;
				value6 = value.IsUnlock;
				value7 = value.MaterialInfos;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<bool>(out value6);
								if (memberCount != 5)
								{
									ListFormatter.DeserializePackable(ref reader, ref value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_014b;
			}
		}
		value = new PbCampaignBuildingInfo
		{
			IsFromPool = value2,
			BuildingId = value3,
			BuildingLevel = value4,
			PointId = value5,
			IsUnlock = value6,
			MaterialInfos = value7
		};
		return;
		IL_014b:
		value.IsFromPool = value2;
		value.BuildingId = value3;
		value.BuildingLevel = value4;
		value.PointId = value5;
		value.IsUnlock = value6;
		value.MaterialInfos = value7;
	}
}
