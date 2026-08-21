using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1114)]
[MemoryPackable(GenerateType.Object)]
public class InnerBattleSendEmoteClientMessageRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerBattleSendEmoteClientMessageRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerBattleSendEmoteClientMessageRequestFormatter : MemoryPackFormatter<InnerBattleSendEmoteClientMessageRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerBattleSendEmoteClientMessageRequest value)
		{
			InnerBattleSendEmoteClientMessageRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerBattleSendEmoteClientMessageRequest value)
		{
			InnerBattleSendEmoteClientMessageRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public long BattleActorId { get; set; }

	[MemoryPackOrder(1)]
	public int Index { get; set; }

	public static InnerBattleSendEmoteClientMessageRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerBattleSendEmoteClientMessageRequest)) as InnerBattleSendEmoteClientMessageRequest;
		}
		return new InnerBattleSendEmoteClientMessageRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			BattleActorId = 0L;
			Index = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerBattleSendEmoteClientMessageRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerBattleSendEmoteClientMessageRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerBattleSendEmoteClientMessageRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerBattleSendEmoteClientMessageRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerBattleSendEmoteClientMessageRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerBattleSendEmoteClientMessageRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, long>(5, value.IsFromPool, value.BattleActorId, value.Index, value.RpcId, value.UserId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerBattleSendEmoteClientMessageRequest? value)
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
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.BattleActorId;
				value4 = value.Index;
				value5 = value.RpcId;
				value6 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0119;
			}
			reader.ReadUnmanaged<bool, long, int, int, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerBattleSendEmoteClientMessageRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.BattleActorId;
				value4 = value.Index;
				value5 = value.RpcId;
				value6 = value.UserId;
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
								reader.ReadUnmanaged<long>(out value6);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0119;
			}
		}
		value = new InnerBattleSendEmoteClientMessageRequest
		{
			IsFromPool = value2,
			BattleActorId = value3,
			Index = value4,
			RpcId = value5,
			UserId = value6
		};
		return;
		IL_0119:
		value.IsFromPool = value2;
		value.BattleActorId = value3;
		value.Index = value4;
		value.RpcId = value5;
		value.UserId = value6;
	}
}
