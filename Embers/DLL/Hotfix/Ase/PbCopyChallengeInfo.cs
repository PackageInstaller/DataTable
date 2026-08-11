using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(422)]
[MemoryPackable(GenerateType.Object)]
public class PbCopyChallengeInfo : MessageObject, IMemoryPackable<PbCopyChallengeInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCopyChallengeInfoFormatter : MemoryPackFormatter<PbCopyChallengeInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCopyChallengeInfo value)
		{
			PbCopyChallengeInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCopyChallengeInfo value)
		{
			PbCopyChallengeInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Id { get; set; }

	[MemoryPackOrder(1)]
	public long Score { get; set; }

	[MemoryPackOrder(2)]
	public long Value1 { get; set; }

	[MemoryPackOrder(3)]
	public string Value2 { get; set; }

	public static PbCopyChallengeInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCopyChallengeInfo)) as PbCopyChallengeInfo;
		}
		return new PbCopyChallengeInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Id = 0;
			Score = 0L;
			Value1 = 0L;
			Value2 = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCopyChallengeInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyChallengeInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCopyChallengeInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCopyChallengeInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCopyChallengeInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCopyChallengeInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long, long>(5, value.IsFromPool, value.Id, value.Score, value.Value1);
		writer.WriteString(value.Value2);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCopyChallengeInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		long value5;
		string value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Score;
				value5 = value.Value1;
				value6 = value.Value2;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				value6 = reader.ReadString();
				goto IL_011f;
			}
			reader.ReadUnmanaged<bool, int, long, long>(out value2, out value3, out value4, out value5);
			value6 = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCopyChallengeInfo), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0L;
				value6 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Id;
				value4 = value.Score;
				value5 = value.Value1;
				value6 = value.Value2;
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
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								value6 = reader.ReadString();
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_011f;
			}
		}
		value = new PbCopyChallengeInfo
		{
			IsFromPool = value2,
			Id = value3,
			Score = value4,
			Value1 = value5,
			Value2 = value6
		};
		return;
		IL_011f:
		value.IsFromPool = value2;
		value.Id = value3;
		value.Score = value4;
		value.Value1 = value5;
		value.Value2 = value6;
	}
}
