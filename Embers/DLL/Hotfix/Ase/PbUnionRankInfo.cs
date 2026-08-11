using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(381)]
[MemoryPackable(GenerateType.Object)]
public class PbUnionRankInfo : MessageObject, IMemoryPackable<PbUnionRankInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbUnionRankInfoFormatter : MemoryPackFormatter<PbUnionRankInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbUnionRankInfo value)
		{
			PbUnionRankInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbUnionRankInfo value)
		{
			PbUnionRankInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public PbUnionBaseInfo UnionInfo { get; set; }

	[MemoryPackOrder(1)]
	public int WeeklyActivePoinit { get; set; }

	[MemoryPackOrder(2)]
	public int Rank { get; set; }

	public static PbUnionRankInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbUnionRankInfo)) as PbUnionRankInfo;
		}
		return new PbUnionRankInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UnionInfo = null;
			WeeklyActivePoinit = 0;
			Rank = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbUnionRankInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionRankInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbUnionRankInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbUnionRankInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbUnionRankInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbUnionRankInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		writer.WritePackable<PbUnionBaseInfo>(value.UnionInfo);
		writer.WriteUnmanaged<int, int>(value.WeeklyActivePoinit, value.Rank);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbUnionRankInfo? value)
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
				value4 = value.WeeklyActivePoinit;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbUnionRankInfo), 4, memberCount);
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
				value4 = value.WeeklyActivePoinit;
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
		value = new PbUnionRankInfo
		{
			IsFromPool = value2,
			UnionInfo = value3,
			WeeklyActivePoinit = value4,
			Rank = value5
		};
		return;
		IL_00f4:
		value.IsFromPool = value2;
		value.UnionInfo = value3;
		value.WeeklyActivePoinit = value4;
		value.Rank = value5;
	}
}
