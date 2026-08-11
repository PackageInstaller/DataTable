using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10324)]
[MemoryPackable(GenerateType.Object)]
public class C2H_ReplaceArmourEntryRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2H_ReplaceArmourEntryRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2H_ReplaceArmourEntryRequestFormatter : MemoryPackFormatter<C2H_ReplaceArmourEntryRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2H_ReplaceArmourEntryRequest value)
		{
			C2H_ReplaceArmourEntryRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2H_ReplaceArmourEntryRequest value)
		{
			C2H_ReplaceArmourEntryRequest.Deserialize(ref reader, ref value);
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
	public long EquipUuid { get; set; }

	[MemoryPackOrder(1)]
	public int EntryIndex { get; set; }

	[MemoryPackOrder(2)]
	public int PoolIndex { get; set; }

	[MemoryPackOrder(3)]
	public int Type { get; set; }

	public static C2H_ReplaceArmourEntryRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2H_ReplaceArmourEntryRequest)) as C2H_ReplaceArmourEntryRequest;
		}
		return new C2H_ReplaceArmourEntryRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			EquipUuid = 0L;
			EntryIndex = 0;
			PoolIndex = 0;
			Type = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2H_ReplaceArmourEntryRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_ReplaceArmourEntryRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2H_ReplaceArmourEntryRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_ReplaceArmourEntryRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2H_ReplaceArmourEntryRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2H_ReplaceArmourEntryRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, int, int, long, int, long>(9, value.IsFromPool, value.EquipUuid, value.EntryIndex, value.PoolIndex, value.Type, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2H_ReplaceArmourEntryRequest? value)
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
		int value6;
		int value7;
		long value8;
		int value9;
		long value10;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EquipUuid;
				value4 = value.EntryIndex;
				value5 = value.PoolIndex;
				value6 = value.Type;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_01cd;
			}
			reader.ReadUnmanaged<bool, long, int, int, int, int, long, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9, out value10);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2H_ReplaceArmourEntryRequest), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0L;
				value9 = 0;
				value10 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.EquipUuid;
				value4 = value.EntryIndex;
				value5 = value.PoolIndex;
				value6 = value.Type;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.ActorId;
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
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value10);
												_ = 9;
											}
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
				goto IL_01cd;
			}
		}
		value = new C2H_ReplaceArmourEntryRequest
		{
			IsFromPool = value2,
			EquipUuid = value3,
			EntryIndex = value4,
			PoolIndex = value5,
			Type = value6,
			LoginServerId = value7,
			LoginSecretKey = value8,
			RpcId = value9,
			ActorId = value10
		};
		return;
		IL_01cd:
		value.IsFromPool = value2;
		value.EquipUuid = value3;
		value.EntryIndex = value4;
		value.PoolIndex = value5;
		value.Type = value6;
		value.LoginServerId = value7;
		value.LoginSecretKey = value8;
		value.RpcId = value9;
		value.ActorId = value10;
	}
}
