using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1061)]
[MemoryPackable(GenerateType.Object)]
public class A2H_RankListSettleNotify : MessageObject, IRequest, IMessage, IMemoryPackable<A2H_RankListSettleNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class A2H_RankListSettleNotifyFormatter : MemoryPackFormatter<A2H_RankListSettleNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref A2H_RankListSettleNotify value)
		{
			A2H_RankListSettleNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref A2H_RankListSettleNotify value)
		{
			A2H_RankListSettleNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(1)]
	public long UserId { get; set; }

	[MemoryPackOrder(2)]
	public int RankId { get; set; }

	[MemoryPackOrder(3)]
	public int Rank { get; set; }

	[MemoryPackOrder(4)]
	public int RankMainType { get; set; }

	[MemoryPackOrder(5)]
	public int ConfigRankId { get; set; }

	[MemoryPackOrder(6)]
	public int RewardRankId { get; set; }

	public static A2H_RankListSettleNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(A2H_RankListSettleNotify)) as A2H_RankListSettleNotify;
		}
		return new A2H_RankListSettleNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			RankId = 0;
			Rank = 0;
			RankMainType = 0;
			ConfigRankId = 0;
			RewardRankId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static A2H_RankListSettleNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<A2H_RankListSettleNotify>())
		{
			MemoryPackFormatterProvider.Register(new A2H_RankListSettleNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<A2H_RankListSettleNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<A2H_RankListSettleNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref A2H_RankListSettleNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, int, int, int, int>(8, value.IsFromPool, value.UserId, value.RankId, value.Rank, value.RankMainType, value.ConfigRankId, value.RewardRankId, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref A2H_RankListSettleNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		int value6;
		int value7;
		int value8;
		int value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RankId;
				value5 = value.Rank;
				value6 = value.RankMainType;
				value7 = value.ConfigRankId;
				value8 = value.RewardRankId;
				value9 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				goto IL_019c;
			}
			reader.ReadUnmanaged<bool, long, int, int, int, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(A2H_RankListSettleNotify), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RankId;
				value5 = value.Rank;
				value6 = value.RankMainType;
				value7 = value.ConfigRankId;
				value8 = value.RewardRankId;
				value9 = value.RpcId;
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
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											_ = 8;
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_019c;
			}
		}
		value = new A2H_RankListSettleNotify
		{
			IsFromPool = value2,
			UserId = value3,
			RankId = value4,
			Rank = value5,
			RankMainType = value6,
			ConfigRankId = value7,
			RewardRankId = value8,
			RpcId = value9
		};
		return;
		IL_019c:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RankId = value4;
		value.Rank = value5;
		value.RankMainType = value6;
		value.ConfigRankId = value7;
		value.RewardRankId = value8;
		value.RpcId = value9;
	}
}
