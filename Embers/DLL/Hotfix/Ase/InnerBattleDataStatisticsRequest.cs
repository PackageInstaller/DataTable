using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1080)]
[MemoryPackable(GenerateType.Object)]
public class InnerBattleDataStatisticsRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerBattleDataStatisticsRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerBattleDataStatisticsRequestFormatter : MemoryPackFormatter<InnerBattleDataStatisticsRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerBattleDataStatisticsRequest value)
		{
			InnerBattleDataStatisticsRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerBattleDataStatisticsRequest value)
		{
			InnerBattleDataStatisticsRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public int CopyId { get; set; }

	[MemoryPackOrder(1)]
	public int Duration { get; set; }

	[MemoryPackOrder(2)]
	public List<PbBattleDataStatistics> BattleDataes { get; set; } = new List<PbBattleDataStatistics>();

	public static InnerBattleDataStatisticsRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerBattleDataStatisticsRequest)) as InnerBattleDataStatisticsRequest;
		}
		return new InnerBattleDataStatisticsRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			CopyId = 0;
			Duration = 0;
			BattleDataes.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerBattleDataStatisticsRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerBattleDataStatisticsRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerBattleDataStatisticsRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerBattleDataStatisticsRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerBattleDataStatisticsRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbBattleDataStatistics>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbBattleDataStatistics>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerBattleDataStatisticsRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(6, value.IsFromPool, value.CopyId, value.Duration);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbBattleDataStatistics>>(value.BattleDataes));
		writer.WriteUnmanaged<int, long>(value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerBattleDataStatisticsRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		List<PbBattleDataStatistics> value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Duration;
				value5 = value.BattleDataes;
				value6 = value.RpcId;
				value7 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0152;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = ListFormatter.DeserializePackable<PbBattleDataStatistics>(ref reader);
			reader.ReadUnmanaged<int, long>(out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerBattleDataStatisticsRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Duration;
				value5 = value.BattleDataes;
				value6 = value.RpcId;
				value7 = value.UserId;
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
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0152;
			}
		}
		value = new InnerBattleDataStatisticsRequest
		{
			IsFromPool = value2,
			CopyId = value3,
			Duration = value4,
			BattleDataes = value5,
			RpcId = value6,
			UserId = value7
		};
		return;
		IL_0152:
		value.IsFromPool = value2;
		value.CopyId = value3;
		value.Duration = value4;
		value.BattleDataes = value5;
		value.RpcId = value6;
		value.UserId = value7;
	}
}
