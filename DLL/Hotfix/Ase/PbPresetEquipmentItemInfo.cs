using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(438)]
[MemoryPackable(GenerateType.Object)]
public class PbPresetEquipmentItemInfo : MessageObject, IMemoryPackable<PbPresetEquipmentItemInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbPresetEquipmentItemInfoFormatter : MemoryPackFormatter<PbPresetEquipmentItemInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbPresetEquipmentItemInfo value)
		{
			PbPresetEquipmentItemInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbPresetEquipmentItemInfo value)
		{
			PbPresetEquipmentItemInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int ThingType { get; set; }

	[MemoryPackOrder(1)]
	public int Position { get; set; }

	[MemoryPackOrder(2)]
	public long EquipmentUuid { get; set; }

	public static PbPresetEquipmentItemInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbPresetEquipmentItemInfo)) as PbPresetEquipmentItemInfo;
		}
		return new PbPresetEquipmentItemInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ThingType = 0;
			Position = 0;
			EquipmentUuid = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbPresetEquipmentItemInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbPresetEquipmentItemInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbPresetEquipmentItemInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbPresetEquipmentItemInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbPresetEquipmentItemInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbPresetEquipmentItemInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long>(4, value.IsFromPool, value.ThingType, value.Position, value.EquipmentUuid);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbPresetEquipmentItemInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ThingType;
				value4 = value.Position;
				value5 = value.EquipmentUuid;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00ea;
			}
			reader.ReadUnmanaged<bool, int, int, long>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbPresetEquipmentItemInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ThingType;
				value4 = value.Position;
				value5 = value.EquipmentUuid;
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
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00ea;
			}
		}
		value = new PbPresetEquipmentItemInfo
		{
			IsFromPool = value2,
			ThingType = value3,
			Position = value4,
			EquipmentUuid = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.ThingType = value3;
		value.Position = value4;
		value.EquipmentUuid = value5;
	}
}
