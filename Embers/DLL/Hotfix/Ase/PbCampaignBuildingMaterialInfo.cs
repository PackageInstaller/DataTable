using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(448)]
[MemoryPackable(GenerateType.Object)]
public class PbCampaignBuildingMaterialInfo : MessageObject, IMemoryPackable<PbCampaignBuildingMaterialInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCampaignBuildingMaterialInfoFormatter : MemoryPackFormatter<PbCampaignBuildingMaterialInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCampaignBuildingMaterialInfo value)
		{
			PbCampaignBuildingMaterialInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCampaignBuildingMaterialInfo value)
		{
			PbCampaignBuildingMaterialInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int ItemId { get; set; }

	[MemoryPackOrder(1)]
	public long Count { get; set; }

	public static PbCampaignBuildingMaterialInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCampaignBuildingMaterialInfo)) as PbCampaignBuildingMaterialInfo;
		}
		return new PbCampaignBuildingMaterialInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ItemId = 0;
			Count = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCampaignBuildingMaterialInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCampaignBuildingMaterialInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCampaignBuildingMaterialInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCampaignBuildingMaterialInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCampaignBuildingMaterialInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCampaignBuildingMaterialInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long>(3, value.IsFromPool, value.ItemId, value.Count);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCampaignBuildingMaterialInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ItemId;
				value4 = value.Count;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCampaignBuildingMaterialInfo), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ItemId;
				value4 = value.Count;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new PbCampaignBuildingMaterialInfo
		{
			IsFromPool = value2,
			ItemId = value3,
			Count = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.ItemId = value3;
		value.Count = value4;
	}
}
