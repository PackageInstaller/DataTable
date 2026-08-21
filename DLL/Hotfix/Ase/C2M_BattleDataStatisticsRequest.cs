using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10168)]
[MemoryPackable(GenerateType.Object)]
public class C2M_BattleDataStatisticsRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2M_BattleDataStatisticsRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2M_BattleDataStatisticsRequestFormatter : MemoryPackFormatter<C2M_BattleDataStatisticsRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2M_BattleDataStatisticsRequest value)
		{
			C2M_BattleDataStatisticsRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2M_BattleDataStatisticsRequest value)
		{
			C2M_BattleDataStatisticsRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int CopyId { get; set; }

	[MemoryPackOrder(1)]
	public int Duration { get; set; }

	[MemoryPackOrder(2)]
	public List<PbBattleDataStatistics> BattleDataes { get; set; } = new List<PbBattleDataStatistics>();

	public static C2M_BattleDataStatisticsRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2M_BattleDataStatisticsRequest)) as C2M_BattleDataStatisticsRequest;
		}
		return new C2M_BattleDataStatisticsRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			CopyId = 0;
			Duration = 0;
			BattleDataes.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2M_BattleDataStatisticsRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2M_BattleDataStatisticsRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2M_BattleDataStatisticsRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2M_BattleDataStatisticsRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2M_BattleDataStatisticsRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbBattleDataStatistics>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbBattleDataStatistics>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2M_BattleDataStatisticsRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(8, value.IsFromPool, value.CopyId, value.Duration);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbBattleDataStatistics>>(value.BattleDataes));
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2M_BattleDataStatisticsRequest? value)
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
		int value8;
		long value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Duration;
				value5 = value.BattleDataes;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_01a9;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = ListFormatter.DeserializePackable<PbBattleDataStatistics>(ref reader);
			reader.ReadUnmanaged<int, long, int, long>(out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2M_BattleDataStatisticsRequest), 8, memberCount);
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
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Duration;
				value5 = value.BattleDataes;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
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
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value9);
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
				goto IL_01a9;
			}
		}
		value = new C2M_BattleDataStatisticsRequest
		{
			IsFromPool = value2,
			CopyId = value3,
			Duration = value4,
			BattleDataes = value5,
			LoginServerId = value6,
			LoginSecretKey = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_01a9:
		value.IsFromPool = value2;
		value.CopyId = value3;
		value.Duration = value4;
		value.BattleDataes = value5;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
