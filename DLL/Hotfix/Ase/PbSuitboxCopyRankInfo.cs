using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(395)]
[MemoryPackable(GenerateType.Object)]
public class PbSuitboxCopyRankInfo : MessageObject, IMemoryPackable<PbSuitboxCopyRankInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbSuitboxCopyRankInfoFormatter : MemoryPackFormatter<PbSuitboxCopyRankInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbSuitboxCopyRankInfo value)
		{
			PbSuitboxCopyRankInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbSuitboxCopyRankInfo value)
		{
			PbSuitboxCopyRankInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public List<PbSuitboxCopyRankSingleUserInfo> Players { get; set; } = new List<PbSuitboxCopyRankSingleUserInfo>();

	[MemoryPackOrder(1)]
	public int Score { get; set; }

	[MemoryPackOrder(2)]
	public int Rank { get; set; }

	public static PbSuitboxCopyRankInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbSuitboxCopyRankInfo)) as PbSuitboxCopyRankInfo;
		}
		return new PbSuitboxCopyRankInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Players.Clear();
			Score = 0;
			Rank = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbSuitboxCopyRankInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbSuitboxCopyRankInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbSuitboxCopyRankInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbSuitboxCopyRankInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbSuitboxCopyRankInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbSuitboxCopyRankSingleUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbSuitboxCopyRankSingleUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbSuitboxCopyRankInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbSuitboxCopyRankSingleUserInfo>>(value.Players));
		writer.WriteUnmanaged<int, int>(value.Score, value.Rank);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbSuitboxCopyRankInfo? value)
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
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Players;
				value4 = value.Score;
				value5 = value.Rank;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00f4;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbSuitboxCopyRankSingleUserInfo>(ref reader);
			reader.ReadUnmanaged<int, int>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbSuitboxCopyRankInfo), 4, memberCount);
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
				value3 = value.Players;
				value4 = value.Score;
				value5 = value.Rank;
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
		value = new PbSuitboxCopyRankInfo
		{
			IsFromPool = value2,
			Players = value3,
			Score = value4,
			Rank = value5
		};
		return;
		IL_00f4:
		value.IsFromPool = value2;
		value.Players = value3;
		value.Score = value4;
		value.Rank = value5;
	}
}
