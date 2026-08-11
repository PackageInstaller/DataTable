using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(414)]
[MemoryPackable(GenerateType.Object)]
public class PbUnionCopyRankInfo : MessageObject, IMemoryPackable<PbUnionCopyRankInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbUnionCopyRankInfoFormatter : MemoryPackFormatter<PbUnionCopyRankInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbUnionCopyRankInfo value)
		{
			PbUnionCopyRankInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbUnionCopyRankInfo value)
		{
			PbUnionCopyRankInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public PbUnionBaseInfo UnionInfo { get; set; }

	[MemoryPackOrder(1)]
	public int Score { get; set; }

	[MemoryPackOrder(2)]
	public int Rank { get; set; }

	public static PbUnionCopyRankInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbUnionCopyRankInfo)) as PbUnionCopyRankInfo;
		}
		return new PbUnionCopyRankInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UnionInfo = null;
			Score = 0;
			Rank = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbUnionCopyRankInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionCopyRankInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbUnionCopyRankInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionCopyRankInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbUnionCopyRankInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbUnionCopyRankInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		writer.WritePackable<PbUnionBaseInfo>(value.UnionInfo);
		writer.WriteUnmanaged<int, int>(value.Score, value.Rank);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbUnionCopyRankInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbUnionBaseInfo value3;
		int value4;
		int value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionInfo;
				value4 = value.Score;
				value5 = value.Rank;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00f4;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbUnionBaseInfo>();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbUnionCopyRankInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionInfo;
				value4 = value.Score;
				value5 = value.Rank;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
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
				goto IL_00f4;
			}
		}
		value = new PbUnionCopyRankInfo
		{
			IsFromPool = value2,
			UnionInfo = value3,
			Score = value4,
			Rank = value5
		};
		return;
		IL_00f4:
		value.IsFromPool = value2;
		value.UnionInfo = value3;
		value.Score = value4;
		value.Rank = value5;
	}
}
