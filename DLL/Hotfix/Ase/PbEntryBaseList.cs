using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(375)]
[MemoryPackable(GenerateType.Object)]
public class PbEntryBaseList : MessageObject, IMemoryPackable<PbEntryBaseList>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbEntryBaseListFormatter : MemoryPackFormatter<PbEntryBaseList>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbEntryBaseList value)
		{
			PbEntryBaseList.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbEntryBaseList value)
		{
			PbEntryBaseList.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Idx { get; set; }

	[MemoryPackOrder(1)]
	public List<PbEntryBase> EntryResult { get; set; } = new List<PbEntryBase>();

	public static PbEntryBaseList Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbEntryBaseList)) as PbEntryBaseList;
		}
		return new PbEntryBaseList();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Idx = 0;
			EntryResult.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbEntryBaseList()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbEntryBaseList>())
		{
			MemoryPackFormatterProvider.Register(new PbEntryBaseListFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbEntryBaseList[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbEntryBaseList>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbEntryBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbEntryBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbEntryBaseList? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(3, value.IsFromPool, value.Idx);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEntryBase>>(value.EntryResult));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbEntryBaseList? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbEntryBase> value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Idx;
				value4 = value.EntryResult;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				goto IL_00c3;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbEntryBase>(ref reader);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbEntryBaseList), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Idx;
				value4 = value.EntryResult;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c3;
			}
		}
		value = new PbEntryBaseList
		{
			IsFromPool = value2,
			Idx = value3,
			EntryResult = value4
		};
		return;
		IL_00c3:
		value.IsFromPool = value2;
		value.Idx = value3;
		value.EntryResult = value4;
	}
}
