using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10514)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightReconnectIntoBattleFieldNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<MultiFightReconnectIntoBattleFieldNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightReconnectIntoBattleFieldNotifyFormatter : MemoryPackFormatter<MultiFightReconnectIntoBattleFieldNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightReconnectIntoBattleFieldNotify value)
		{
			MultiFightReconnectIntoBattleFieldNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightReconnectIntoBattleFieldNotify value)
		{
			MultiFightReconnectIntoBattleFieldNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public string Address { get; set; }

	[MemoryPackOrder(1)]
	public long LoginKey { get; set; }

	[MemoryPackOrder(2)]
	public int KcpConnectId { get; set; }

	public static MultiFightReconnectIntoBattleFieldNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightReconnectIntoBattleFieldNotify)) as MultiFightReconnectIntoBattleFieldNotify;
		}
		return new MultiFightReconnectIntoBattleFieldNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Address = null;
			LoginKey = 0L;
			KcpConnectId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightReconnectIntoBattleFieldNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightReconnectIntoBattleFieldNotify>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightReconnectIntoBattleFieldNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightReconnectIntoBattleFieldNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightReconnectIntoBattleFieldNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightReconnectIntoBattleFieldNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WriteString(value.Address);
		writer.WriteUnmanaged<long, int, int, long>(value.LoginKey, value.KcpConnectId, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightReconnectIntoBattleFieldNotify? value)
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
		string address;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				address = value.Address;
				value3 = value.LoginKey;
				value4 = value.KcpConnectId;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				address = reader.ReadString();
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0150;
			}
			reader.ReadUnmanaged<bool>(out value2);
			address = reader.ReadString();
			reader.ReadUnmanaged<long, int, int, long>(out value3, out value4, out value5, out value6);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightReconnectIntoBattleFieldNotify), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				address = null;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				address = value.Address;
				value3 = value.LoginKey;
				value4 = value.KcpConnectId;
				value5 = value.RpcId;
				value6 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					address = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value6);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0150;
			}
		}
		value = new MultiFightReconnectIntoBattleFieldNotify
		{
			IsFromPool = value2,
			Address = address,
			LoginKey = value3,
			KcpConnectId = value4,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0150:
		value.IsFromPool = value2;
		value.Address = address;
		value.LoginKey = value3;
		value.KcpConnectId = value4;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
