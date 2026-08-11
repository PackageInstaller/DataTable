using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(374)]
[MemoryPackable(GenerateType.Object)]
public class PbSuitBoxInfo : MessageObject, IMemoryPackable<PbSuitBoxInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbSuitBoxInfoFormatter : MemoryPackFormatter<PbSuitBoxInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbSuitBoxInfo value)
		{
			PbSuitBoxInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbSuitBoxInfo value)
		{
			PbSuitBoxInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long Uuid { get; set; }

	[MemoryPackOrder(1)]
	public int SuitBoxId { get; set; }

	public static PbSuitBoxInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbSuitBoxInfo)) as PbSuitBoxInfo;
		}
		return new PbSuitBoxInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Uuid = 0L;
			SuitBoxId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbSuitBoxInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbSuitBoxInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbSuitBoxInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbSuitBoxInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbSuitBoxInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbSuitBoxInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int>(3, value.IsFromPool, value.Uuid, value.SuitBoxId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbSuitBoxInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Uuid;
				value4 = value.SuitBoxId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, long, int>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbSuitBoxInfo), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Uuid;
				value4 = value.SuitBoxId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new PbSuitBoxInfo
		{
			IsFromPool = value2,
			Uuid = value3,
			SuitBoxId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.Uuid = value3;
		value.SuitBoxId = value4;
	}
}
