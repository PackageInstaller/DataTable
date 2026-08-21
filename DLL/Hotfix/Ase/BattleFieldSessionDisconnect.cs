using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1022)]
[MemoryPackable(GenerateType.Object)]
public class BattleFieldSessionDisconnect : MessageObject, IActorLocationMessage, IActorRequest, IRequest, IMessage, IMemoryPackable<BattleFieldSessionDisconnect>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BattleFieldSessionDisconnectFormatter : MemoryPackFormatter<BattleFieldSessionDisconnect>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BattleFieldSessionDisconnect value)
		{
			BattleFieldSessionDisconnect.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BattleFieldSessionDisconnect value)
		{
			BattleFieldSessionDisconnect.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(93)]
	public long ActorId { get; set; }

	public static BattleFieldSessionDisconnect Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BattleFieldSessionDisconnect)) as BattleFieldSessionDisconnect;
		}
		return new BattleFieldSessionDisconnect();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BattleFieldSessionDisconnect()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BattleFieldSessionDisconnect>())
		{
			MemoryPackFormatterProvider.Register(new BattleFieldSessionDisconnectFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BattleFieldSessionDisconnect[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BattleFieldSessionDisconnect>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BattleFieldSessionDisconnect? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long>(3, value.IsFromPool, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BattleFieldSessionDisconnect? value)
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
				value4 = value.ActorId;
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
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BattleFieldSessionDisconnect), 3, memberCount);
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
				value4 = value.ActorId;
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
		value = new BattleFieldSessionDisconnect
		{
			IsFromPool = value2,
			RpcId = value3,
			ActorId = value4
		};
		return;
		IL_00bf:
		value.IsFromPool = value2;
		value.RpcId = value3;
		value.ActorId = value4;
	}
}
