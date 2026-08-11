using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1071)]
[MemoryPackable(GenerateType.Object)]
public class InnerDisconnectBackToMatchRoomRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerDisconnectBackToMatchRoomRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerDisconnectBackToMatchRoomRequestFormatter : MemoryPackFormatter<InnerDisconnectBackToMatchRoomRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerDisconnectBackToMatchRoomRequest value)
		{
			InnerDisconnectBackToMatchRoomRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerDisconnectBackToMatchRoomRequest value)
		{
			InnerDisconnectBackToMatchRoomRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int Relogin { get; set; }

	public static InnerDisconnectBackToMatchRoomRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerDisconnectBackToMatchRoomRequest)) as InnerDisconnectBackToMatchRoomRequest;
		}
		return new InnerDisconnectBackToMatchRoomRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Relogin = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerDisconnectBackToMatchRoomRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerDisconnectBackToMatchRoomRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerDisconnectBackToMatchRoomRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerDisconnectBackToMatchRoomRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerDisconnectBackToMatchRoomRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerDisconnectBackToMatchRoomRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int>(4, value.IsFromPool, value.UserId, value.Relogin, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerDisconnectBackToMatchRoomRequest? value)
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
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Relogin;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00ea;
			}
			reader.ReadUnmanaged<bool, long, int, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerDisconnectBackToMatchRoomRequest), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Relogin;
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
				goto IL_00ea;
			}
		}
		value = new InnerDisconnectBackToMatchRoomRequest
		{
			IsFromPool = value2,
			UserId = value3,
			Relogin = value4,
			RpcId = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Relogin = value4;
		value.RpcId = value5;
	}
}
