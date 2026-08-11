using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(5002)]
[MemoryPackable(GenerateType.Object)]
public class PbEntryBase : MessageObject, IMemoryPackable<PbEntryBase>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbEntryBaseFormatter : MemoryPackFormatter<PbEntryBase>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbEntryBase value)
		{
			PbEntryBase.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbEntryBase value)
		{
			PbEntryBase.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public int Level { get; set; }

	public static PbEntryBase Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbEntryBase)) as PbEntryBase;
		}
		return new PbEntryBase();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			Level = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbEntryBase()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbEntryBase>())
		{
			MemoryPackFormatterProvider.Register(new PbEntryBaseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbEntryBase[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbEntryBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbEntryBase? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int>(3, value.IsFromPool, value.Id, value.Level);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbEntryBase? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Level;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00be;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbEntryBase), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Level;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00be;
			}
		}
		value = new PbEntryBase
		{
			IsFromPool = value2,
			Id = value3,
			Level = value4
		};
		return;
		IL_00be:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Level = value4;
	}
}
