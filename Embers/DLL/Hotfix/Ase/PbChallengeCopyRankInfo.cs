using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(396)]
[MemoryPackable(GenerateType.Object)]
public class PbChallengeCopyRankInfo : MessageObject, IMemoryPackable<PbChallengeCopyRankInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbChallengeCopyRankInfoFormatter : MemoryPackFormatter<PbChallengeCopyRankInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbChallengeCopyRankInfo value)
		{
			PbChallengeCopyRankInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbChallengeCopyRankInfo value)
		{
			PbChallengeCopyRankInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public List<PbSuitboxCopyRankSingleUserInfo> Players { get; set; } = new List<PbSuitboxCopyRankSingleUserInfo>();

	[MemoryPackOrder(1)]
	public int Score { get; set; }

	[MemoryPackOrder(2)]
	public int Rank { get; set; }

	[MemoryPackOrder(3)]
	public int CopyType { get; set; }

	public static PbChallengeCopyRankInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbChallengeCopyRankInfo)) as PbChallengeCopyRankInfo;
		}
		return new PbChallengeCopyRankInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Players.Clear();
			Score = 0;
			Rank = 0;
			CopyType = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbChallengeCopyRankInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbChallengeCopyRankInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbChallengeCopyRankInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbChallengeCopyRankInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbChallengeCopyRankInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbSuitboxCopyRankSingleUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbSuitboxCopyRankSingleUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbChallengeCopyRankInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbSuitboxCopyRankSingleUserInfo>>(value.Players));
		writer.WriteUnmanaged<int, int, int>(value.Score, value.Rank, value.CopyType);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbChallengeCopyRankInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbSuitboxCopyRankSingleUserInfo> value3;
		int value4;
		int value5;
		int value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Players;
				value4 = value.Score;
				value5 = value.Rank;
				value6 = value.CopyType;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				goto IL_0122;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbSuitboxCopyRankSingleUserInfo>(ref reader);
			reader.ReadUnmanaged<int, int, int>(out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbChallengeCopyRankInfo), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				value6 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Players;
				value4 = value.Score;
				value5 = value.Rank;
				value6 = value.CopyType;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0122;
			}
		}
		value = new PbChallengeCopyRankInfo
		{
			IsFromPool = value2,
			Players = value3,
			Score = value4,
			Rank = value5,
			CopyType = value6
		};
		return;
		IL_0122:
		value.IsFromPool = value2;
		value.Players = value3;
		value.Score = value4;
		value.Rank = value5;
		value.CopyType = value6;
	}
}
