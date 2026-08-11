using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(352)]
[MemoryPackable(GenerateType.Object)]
public class PbCopyPassTimesInfo : MessageObject, IMemoryPackable<PbCopyPassTimesInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCopyPassTimesInfoFormatter : MemoryPackFormatter<PbCopyPassTimesInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCopyPassTimesInfo value)
		{
			PbCopyPassTimesInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCopyPassTimesInfo value)
		{
			PbCopyPassTimesInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int CopyType { get; set; }

	[MemoryPackOrder(1)]
	public int CopyNumber { get; set; }

	[MemoryPackOrder(2)]
	public int FightCount { get; set; }

	public static PbCopyPassTimesInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCopyPassTimesInfo)) as PbCopyPassTimesInfo;
		}
		return new PbCopyPassTimesInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			CopyType = 0;
			CopyNumber = 0;
			FightCount = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCopyPassTimesInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyPassTimesInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCopyPassTimesInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyPassTimesInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCopyPassTimesInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCopyPassTimesInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(4, value.IsFromPool, value.CopyType, value.CopyNumber, value.FightCount);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCopyPassTimesInfo? value)
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
				value3 = value.CopyType;
				value4 = value.CopyNumber;
				value5 = value.FightCount;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCopyPassTimesInfo), 4, memberCount);
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
				value3 = value.CopyType;
				value4 = value.CopyNumber;
				value5 = value.FightCount;
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
		value = new PbCopyPassTimesInfo
		{
			IsFromPool = value2,
			CopyType = value3,
			CopyNumber = value4,
			FightCount = value5
		};
		return;
		IL_00e9:
		value.IsFromPool = value2;
		value.CopyType = value3;
		value.CopyNumber = value4;
		value.FightCount = value5;
	}
}
