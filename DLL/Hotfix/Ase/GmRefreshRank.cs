using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1138)]
[MemoryPackable(GenerateType.Object)]
public class GmRefreshRank : MessageObject, IRequest, IMessage, IMemoryPackable<GmRefreshRank>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GmRefreshRankFormatter : MemoryPackFormatter<GmRefreshRank>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GmRefreshRank value)
		{
			GmRefreshRank.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GmRefreshRank value)
		{
			GmRefreshRank.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long RankType { get; set; }

	public static GmRefreshRank Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GmRefreshRank)) as GmRefreshRank;
		}
		return new GmRefreshRank();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			RankType = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GmRefreshRank()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GmRefreshRank>())
		{
			MemoryPackFormatterProvider.Register(new GmRefreshRankFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GmRefreshRank[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GmRefreshRank>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GmRefreshRank? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int>(3, value.IsFromPool, value.RankType, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GmRefreshRank? value)
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
				value3 = value.RankType;
				value4 = value.RpcId;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GmRefreshRank), 3, memberCount);
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
				value3 = value.RankType;
				value4 = value.RpcId;
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
		value = new GmRefreshRank
		{
			IsFromPool = value2,
			RankType = value3,
			RpcId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.RankType = value3;
		value.RpcId = value4;
	}
}
