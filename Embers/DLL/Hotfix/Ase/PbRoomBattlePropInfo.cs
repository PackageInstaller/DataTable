using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(403)]
[MemoryPackable(GenerateType.Object)]
public class PbRoomBattlePropInfo : MessageObject, IMemoryPackable<PbRoomBattlePropInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbRoomBattlePropInfoFormatter : MemoryPackFormatter<PbRoomBattlePropInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbRoomBattlePropInfo value)
		{
			PbRoomBattlePropInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbRoomBattlePropInfo value)
		{
			PbRoomBattlePropInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public int Count { get; set; }

	[MemoryPackOrder(2)]
	public int Level { get; set; }

	public static PbRoomBattlePropInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbRoomBattlePropInfo)) as PbRoomBattlePropInfo;
		}
		return new PbRoomBattlePropInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			Count = 0;
			Level = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbRoomBattlePropInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbRoomBattlePropInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbRoomBattlePropInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbRoomBattlePropInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbRoomBattlePropInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbRoomBattlePropInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.Id, value.Count, value.Level);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbRoomBattlePropInfo? value)
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
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Count;
				value5 = value.Level;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00e9;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbRoomBattlePropInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Count;
				value5 = value.Level;
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
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00e9;
			}
		}
		value = new PbRoomBattlePropInfo
		{
			IsFromPool = value2,
			Id = value3,
			Count = value4,
			Level = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Count = value4;
		value.Level = value5;
	}
}
