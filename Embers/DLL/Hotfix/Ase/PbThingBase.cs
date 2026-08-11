using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(318)]
[MemoryPackable(GenerateType.Object)]
public class PbThingBase : MessageObject, IMemoryPackable<PbThingBase>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbThingBaseFormatter : MemoryPackFormatter<PbThingBase>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbThingBase value)
		{
			PbThingBase.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbThingBase value)
		{
			PbThingBase.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	[MemoryPackOrder(1)]
	public int Id { get; set; }

	[MemoryPackOrder(2)]
	public long Count { get; set; }

	public static PbThingBase Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbThingBase)) as PbThingBase;
		}
		return new PbThingBase();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Type = 0;
			Id = 0;
			Count = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbThingBase()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbThingBase>())
		{
			MemoryPackFormatterProvider.Register(new PbThingBaseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbThingBase[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbThingBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbThingBase? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long>(4, value.IsFromPool, value.Type, value.Id, value.Count);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbThingBase? value)
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
				value3 = value.Type;
				value4 = value.Id;
				value5 = value.Count;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbThingBase), 4, memberCount);
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
				value3 = value.Type;
				value4 = value.Id;
				value5 = value.Count;
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
		value = new PbThingBase
		{
			IsFromPool = value2,
			Type = value3,
			Id = value4,
			Count = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.Type = value3;
		value.Id = value4;
		value.Count = value5;
	}
}
