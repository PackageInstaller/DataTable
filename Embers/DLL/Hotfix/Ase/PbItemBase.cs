using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(209)]
[MemoryPackable(GenerateType.Object)]
public class PbItemBase : MessageObject, IMemoryPackable<PbItemBase>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbItemBaseFormatter : MemoryPackFormatter<PbItemBase>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbItemBase value)
		{
			PbItemBase.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbItemBase value)
		{
			PbItemBase.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int ItemType { get; set; }

	[MemoryPackOrder(1)]
	public int ItemId { get; set; }

	[MemoryPackOrder(2)]
	public long ItemCount { get; set; }

	public static PbItemBase Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbItemBase)) as PbItemBase;
		}
		return new PbItemBase();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ItemType = 0;
			ItemId = 0;
			ItemCount = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbItemBase()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbItemBase>())
		{
			MemoryPackFormatterProvider.Register(new PbItemBaseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbItemBase[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbItemBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbItemBase? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long>(4, value.IsFromPool, value.ItemType, value.ItemId, value.ItemCount);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbItemBase? value)
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
				value3 = value.ItemType;
				value4 = value.ItemId;
				value5 = value.ItemCount;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbItemBase), 4, memberCount);
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
				value3 = value.ItemType;
				value4 = value.ItemId;
				value5 = value.ItemCount;
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
		value = new PbItemBase
		{
			IsFromPool = value2,
			ItemType = value3,
			ItemId = value4,
			ItemCount = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.ItemType = value3;
		value.ItemId = value4;
		value.ItemCount = value5;
	}
}
