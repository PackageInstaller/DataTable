using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10065)]
[MemoryPackable(GenerateType.Object)]
public class C2M_LeaveBattleFieldRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2M_LeaveBattleFieldRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2M_LeaveBattleFieldRequestFormatter : MemoryPackFormatter<C2M_LeaveBattleFieldRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2M_LeaveBattleFieldRequest value)
		{
			C2M_LeaveBattleFieldRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2M_LeaveBattleFieldRequest value)
		{
			C2M_LeaveBattleFieldRequest.Deserialize(ref reader, ref value);
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

	public static C2M_LeaveBattleFieldRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2M_LeaveBattleFieldRequest)) as C2M_LeaveBattleFieldRequest;
		}
		return new C2M_LeaveBattleFieldRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2M_LeaveBattleFieldRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2M_LeaveBattleFieldRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2M_LeaveBattleFieldRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2M_LeaveBattleFieldRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2M_LeaveBattleFieldRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2M_LeaveBattleFieldRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long, int, long>(5, value.IsFromPool, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2M_LeaveBattleFieldRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		int value5;
		long value6;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0119;
			}
			reader.ReadUnmanaged<bool, int, long, int, long>(out value2, out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2M_LeaveBattleFieldRequest), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.LoginServerId;
				value4 = value.LoginSecretKey;
				value5 = value.RpcId;
				value6 = value.ActorId;
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
		value = new C2M_LeaveBattleFieldRequest
		{
			IsFromPool = value2,
			LoginServerId = value3,
			LoginSecretKey = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0119:
		value.IsFromPool = value2;
		value.LoginServerId = value3;
		value.LoginSecretKey = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
