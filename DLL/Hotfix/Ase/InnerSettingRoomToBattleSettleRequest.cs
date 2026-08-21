using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1136)]
[MemoryPackable(GenerateType.Object)]
public class InnerSettingRoomToBattleSettleRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerSettingRoomToBattleSettleRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerSettingRoomToBattleSettleRequestFormatter : MemoryPackFormatter<InnerSettingRoomToBattleSettleRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerSettingRoomToBattleSettleRequest value)
		{
			InnerSettingRoomToBattleSettleRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerSettingRoomToBattleSettleRequest value)
		{
			InnerSettingRoomToBattleSettleRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	public static InnerSettingRoomToBattleSettleRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerSettingRoomToBattleSettleRequest)) as InnerSettingRoomToBattleSettleRequest;
		}
		return new InnerSettingRoomToBattleSettleRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerSettingRoomToBattleSettleRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerSettingRoomToBattleSettleRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerSettingRoomToBattleSettleRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerSettingRoomToBattleSettleRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerSettingRoomToBattleSettleRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerSettingRoomToBattleSettleRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long>(3, value.IsFromPool, value.RpcId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerSettingRoomToBattleSettleRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		if (memberCount == 3)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
				value4 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				goto IL_00bf;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
		}
		else
		{
			if (memberCount > 3)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerSettingRoomToBattleSettleRequest), 3, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
				value4 = value.UserId;
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
						_ = 3;
					}
				}
			}
			if (value != null)
			{
				goto IL_00bf;
			}
		}
		value = new InnerSettingRoomToBattleSettleRequest
		{
			IsFromPool = value2,
			RpcId = value3,
			UserId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.RpcId = value3;
		value.UserId = value4;
	}
}
