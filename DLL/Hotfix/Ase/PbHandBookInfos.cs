using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(402)]
[MemoryPackable(GenerateType.Object)]
public class PbHandBookInfos : MessageObject, IMemoryPackable<PbHandBookInfos>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbHandBookInfosFormatter : MemoryPackFormatter<PbHandBookInfos>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbHandBookInfos value)
		{
			PbHandBookInfos.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbHandBookInfos value)
		{
			PbHandBookInfos.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	[MemoryPackOrder(1)]
	public List<long> UnlockIds { get; set; } = new List<long>();

	public static PbHandBookInfos Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbHandBookInfos)) as PbHandBookInfos;
		}
		return new PbHandBookInfos();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Type = 0;
			UnlockIds.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbHandBookInfos()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbHandBookInfos>())
		{
			MemoryPackFormatterProvider.Register(new PbHandBookInfosFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbHandBookInfos[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbHandBookInfos>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbHandBookInfos? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(3, value.IsFromPool, value.Type);
		writer.WriteValue<List<long>>(value.UnlockIds);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbHandBookInfos? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<long> value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.UnlockIds;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadValue(ref value4);
				goto IL_00c3;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadValue<List<long>>();
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbHandBookInfos), 3, memberCount);
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
				value3 = value.Type;
				value4 = value.UnlockIds;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadValue(ref value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00c3;
			}
		}
		value = new PbHandBookInfos
		{
			IsFromPool = value2,
			Type = value3,
			UnlockIds = value4
		};
		return;
		IL_00c3:
		value.IsFromPool = value2;
		value.Type = value3;
		value.UnlockIds = value4;
	}
}
