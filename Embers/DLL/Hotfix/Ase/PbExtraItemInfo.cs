using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(406)]
[MemoryPackable(GenerateType.Object)]
public class PbExtraItemInfo : MessageObject, IMemoryPackable<PbExtraItemInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbExtraItemInfoFormatter : MemoryPackFormatter<PbExtraItemInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbExtraItemInfo value)
		{
			PbExtraItemInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbExtraItemInfo value)
		{
			PbExtraItemInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public long ExpireTime { get; set; }

	public static PbExtraItemInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbExtraItemInfo)) as PbExtraItemInfo;
		}
		return new PbExtraItemInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			ExpireTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbExtraItemInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbExtraItemInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbExtraItemInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbExtraItemInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbExtraItemInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbExtraItemInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long>(3, value.IsFromPool, value.Id, value.ExpireTime);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbExtraItemInfo? value)
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
				value3 = value.Id;
				value4 = value.ExpireTime;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbExtraItemInfo), 3, memberCount);
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
				value3 = value.Id;
				value4 = value.ExpireTime;
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
		value = new PbExtraItemInfo
		{
			IsFromPool = value2,
			Id = value3,
			ExpireTime = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.Id = value3;
		value.ExpireTime = value4;
	}
}
