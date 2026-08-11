using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10198)]
[MemoryPackable(GenerateType.Object)]
public class C2S_RefineUpEquipmentRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2S_RefineUpEquipmentRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2S_RefineUpEquipmentRequestFormatter : MemoryPackFormatter<C2S_RefineUpEquipmentRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2S_RefineUpEquipmentRequest value)
		{
			C2S_RefineUpEquipmentRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2S_RefineUpEquipmentRequest value)
		{
			C2S_RefineUpEquipmentRequest.Deserialize(ref reader, ref value);
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
	public long EquipId { get; set; }

	[MemoryPackOrder(1)]
	public long EquipUuid { get; set; }

	[MemoryPackOrder(2)]
	public List<long> Equips { get; set; } = new List<long>();

	public static C2S_RefineUpEquipmentRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2S_RefineUpEquipmentRequest)) as C2S_RefineUpEquipmentRequest;
		}
		return new C2S_RefineUpEquipmentRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			EquipId = 0L;
			EquipUuid = 0L;
			Equips.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2S_RefineUpEquipmentRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_RefineUpEquipmentRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2S_RefineUpEquipmentRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_RefineUpEquipmentRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2S_RefineUpEquipmentRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2S_RefineUpEquipmentRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long>(8, value.IsFromPool, value.EquipId, value.EquipUuid);
		writer.WriteValue<List<long>>(value.Equips);
		writer.WriteUnmanaged<int, long, int, long>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2S_RefineUpEquipmentRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		List<long> value5;
		int value6;
		long value7;
		int value8;
		long value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EquipId;
				value4 = value.EquipUuid;
				value5 = value.Equips;
				value6 = value.LoginServerId;
				value7 = value.LoginSecretKey;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadValue(ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_01ab;
			}
			reader.ReadUnmanaged<bool, long, long>(out value2, out value3, out value4);
			value5 = reader.ReadValue<List<long>>();
			reader.ReadUnmanaged<int, long, int, long>(out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2S_RefineUpEquipmentRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = null;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.EquipId;
				value4 = value.EquipUuid;
				value5 = value.Equips;
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
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadValue(ref value5);
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
				goto IL_01ab;
			}
		}
		value = new C2S_RefineUpEquipmentRequest
		{
			IsFromPool = value2,
			EquipId = value3,
			EquipUuid = value4,
			Equips = value5,
			LoginServerId = value6,
			LoginSecretKey = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_01ab:
		value.IsFromPool = value2;
		value.EquipId = value3;
		value.EquipUuid = value4;
		value.Equips = value5;
		value.LoginServerId = value6;
		value.LoginSecretKey = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
