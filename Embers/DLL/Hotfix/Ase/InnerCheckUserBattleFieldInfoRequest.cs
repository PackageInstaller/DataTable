using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1065)]
[MemoryPackable(GenerateType.Object)]
public class InnerCheckUserBattleFieldInfoRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerCheckUserBattleFieldInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerCheckUserBattleFieldInfoRequestFormatter : MemoryPackFormatter<InnerCheckUserBattleFieldInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerCheckUserBattleFieldInfoRequest value)
		{
			InnerCheckUserBattleFieldInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerCheckUserBattleFieldInfoRequest value)
		{
			InnerCheckUserBattleFieldInfoRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long RoomId { get; set; }

	public static InnerCheckUserBattleFieldInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerCheckUserBattleFieldInfoRequest)) as InnerCheckUserBattleFieldInfoRequest;
		}
		return new InnerCheckUserBattleFieldInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			RoomId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerCheckUserBattleFieldInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerCheckUserBattleFieldInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerCheckUserBattleFieldInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerCheckUserBattleFieldInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerCheckUserBattleFieldInfoRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerCheckUserBattleFieldInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, int>(4, value.IsFromPool, value.UserId, value.RoomId, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerCheckUserBattleFieldInfoRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		int value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoomId;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00eb;
			}
			reader.ReadUnmanaged<bool, long, long, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerCheckUserBattleFieldInfoRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoomId;
				value5 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
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
				goto IL_00eb;
			}
		}
		value = new InnerCheckUserBattleFieldInfoRequest
		{
			IsFromPool = value2,
			UserId = value3,
			RoomId = value4,
			RpcId = value5
		};
		return;
		IL_00eb:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RoomId = value4;
		value.RpcId = value5;
	}
}
