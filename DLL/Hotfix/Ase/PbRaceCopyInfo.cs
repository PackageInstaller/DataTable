using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(392)]
[MemoryPackable(GenerateType.Object)]
public class PbRaceCopyInfo : MessageObject, IMemoryPackable<PbRaceCopyInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbRaceCopyInfoFormatter : MemoryPackFormatter<PbRaceCopyInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbRaceCopyInfo value)
		{
			PbRaceCopyInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbRaceCopyInfo value)
		{
			PbRaceCopyInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int CopyType { get; set; }

	[MemoryPackOrder(1)]
	public int Score { get; set; }

	public static PbRaceCopyInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbRaceCopyInfo)) as PbRaceCopyInfo;
		}
		return new PbRaceCopyInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			CopyType = 0;
			Score = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbRaceCopyInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbRaceCopyInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbRaceCopyInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbRaceCopyInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbRaceCopyInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbRaceCopyInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int>(3, value.IsFromPool, value.CopyType, value.Score);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbRaceCopyInfo? value)
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
				value3 = value.CopyType;
				value4 = value.Score;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbRaceCopyInfo), 3, memberCount);
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
				value3 = value.CopyType;
				value4 = value.Score;
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
		value = new PbRaceCopyInfo
		{
			IsFromPool = value2,
			CopyType = value3,
			Score = value4
		};
		return;
		IL_00be:
		value.IsFromPool = value2;
		value.CopyType = value3;
		value.Score = value4;
	}
}
