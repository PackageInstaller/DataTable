using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1075)]
[MemoryPackable(GenerateType.Object)]
public class InnerBattleDissolveMessage : MessageObject, IRequest, IMessage, IMemoryPackable<InnerBattleDissolveMessage>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerBattleDissolveMessageFormatter : MemoryPackFormatter<InnerBattleDissolveMessage>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerBattleDissolveMessage value)
		{
			InnerBattleDissolveMessage.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerBattleDissolveMessage value)
		{
			InnerBattleDissolveMessage.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long RoomId { get; set; }

	[MemoryPackOrder(1)]
	public bool Settle { get; set; }

	public static InnerBattleDissolveMessage Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerBattleDissolveMessage)) as InnerBattleDissolveMessage;
		}
		return new InnerBattleDissolveMessage();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			RoomId = 0L;
			Settle = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerBattleDissolveMessage()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerBattleDissolveMessage>())
		{
			MemoryPackFormatterProvider.Register(new InnerBattleDissolveMessageFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerBattleDissolveMessage[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerBattleDissolveMessage>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerBattleDissolveMessage? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, bool, int>(4, value.IsFromPool, value.RoomId, value.Settle, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerBattleDissolveMessage? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		bool value4;
		int value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.Settle;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<bool>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00ea;
			}
			reader.ReadUnmanaged<bool, long, bool, int>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerBattleDissolveMessage), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = false;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.Settle;
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
						reader.ReadUnmanaged<bool>(out value4);
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
		value = new InnerBattleDissolveMessage
		{
			IsFromPool = value2,
			RoomId = value3,
			Settle = value4,
			RpcId = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.RoomId = value3;
		value.Settle = value4;
		value.RpcId = value5;
	}
}
