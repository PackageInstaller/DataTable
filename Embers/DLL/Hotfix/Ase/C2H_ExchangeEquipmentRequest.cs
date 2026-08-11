using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10080)]
[MemoryPackable(GenerateType.Object)]
public class C2H_ExchangeEquipmentRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2H_ExchangeEquipmentRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2H_ExchangeEquipmentRequestFormatter : MemoryPackFormatter<C2H_ExchangeEquipmentRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2H_ExchangeEquipmentRequest value)
		{
			C2H_ExchangeEquipmentRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2H_ExchangeEquipmentRequest value)
		{
			C2H_ExchangeEquipmentRequest.Deserialize(ref reader, ref value);
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
	public int Typ { get; set; }

	[MemoryPackOrder(1)]
	public int SelectRoleId { get; set; }

	[MemoryPackOrder(2)]
	public long SelectEquipUuid { get; set; }

	public static C2H_ExchangeEquipmentRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2H_ExchangeEquipmentRequest)) as C2H_ExchangeEquipmentRequest;
		}
		return new C2H_ExchangeEquipmentRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			Typ = 0;
			SelectRoleId = 0;
			SelectEquipUuid = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2H_ExchangeEquipmentRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_ExchangeEquipmentRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2H_ExchangeEquipmentRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_ExchangeEquipmentRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2H_ExchangeEquipmentRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2H_ExchangeEquipmentRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, long, int, long, int, long>(8, value.IsFromPool, value.Typ, value.SelectRoleId, value.SelectEquipUuid, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2H_ExchangeEquipmentRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		int value6;
		long value7;
		int value8;
		long value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Typ;
				value4 = value.SelectRoleId;
				value5 = value.SelectEquipUuid;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_019e;
			}
			reader.ReadUnmanaged<bool, int, int, long, int, long, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2H_ExchangeEquipmentRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Typ;
				value4 = value.SelectRoleId;
				value5 = value.SelectEquipUuid;
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
							reader.ReadUnmanaged<long>(out value5);
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
				goto IL_019e;
			}
		}
		value = new C2H_ExchangeEquipmentRequest
		{
			IsFromPool = value2,
			Typ = value3,
			SelectRoleId = value4,
			SelectEquipUuid = value5,
			LoginServerId = value6,
			LoginSecretKey = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_019e:
		value.IsFromPool = value2;
		value.Typ = value3;
		value.SelectRoleId = value4;
		value.SelectEquipUuid = value5;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
