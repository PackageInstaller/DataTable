using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10039)]
[MemoryPackable(GenerateType.Object)]
public class C2H_GetDropGoodsRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2H_GetDropGoodsRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2H_GetDropGoodsRequestFormatter : MemoryPackFormatter<C2H_GetDropGoodsRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2H_GetDropGoodsRequest value)
		{
			C2H_GetDropGoodsRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2H_GetDropGoodsRequest value)
		{
			C2H_GetDropGoodsRequest.Deserialize(ref reader, ref value);
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
	public int ItemId { get; set; }

	[MemoryPackOrder(1)]
	public int DropItemType { get; set; }

	[MemoryPackOrder(2)]
	public int MapId { get; set; }

	[MemoryPackOrder(3)]
	public int ChestUid { get; set; }

	public static C2H_GetDropGoodsRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2H_GetDropGoodsRequest)) as C2H_GetDropGoodsRequest;
		}
		return new C2H_GetDropGoodsRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			ItemId = 0;
			DropItemType = 0;
			MapId = 0;
			ChestUid = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2H_GetDropGoodsRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_GetDropGoodsRequest>())
		{
			MemoryPackFormatterProvider.Register(new C2H_GetDropGoodsRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2H_GetDropGoodsRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2H_GetDropGoodsRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2H_GetDropGoodsRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int, int, long, int, long>(9, value.IsFromPool, value.ItemId, value.DropItemType, value.MapId, value.ChestUid, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2H_GetDropGoodsRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
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
				value3 = value.ItemId;
				value4 = value.DropItemType;
				value5 = value.MapId;
				value6 = value.ChestUid;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_01cc;
			}
			reader.ReadUnmanaged<bool, int, int, int, int, int, long, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9, out value10);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2H_GetDropGoodsRequest), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
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
				value3 = value.ItemId;
				value4 = value.DropItemType;
				value5 = value.MapId;
				value6 = value.ChestUid;
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
					reader.ReadUnmanaged<int>(out value3);
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
				goto IL_01cc;
			}
		}
		value = new C2H_GetDropGoodsRequest
		{
			IsFromPool = value2,
			ItemId = value3,
			DropItemType = value4,
			MapId = value5,
			ChestUid = value6,
			LoginServerId = value7,
			LoginSecretKey = value8,
			RpcId = value9,
			ActorId = value10
		};
		return;
		IL_01cc:
		value.IsFromPool = value2;
		value.ItemId = value3;
		value.DropItemType = value4;
		value.MapId = value5;
		value.ChestUid = value6;
		value.LoginServerId = value7;
		value.LoginSecretKey = value8;
		value.RpcId = value9;
		value.ActorId = value10;
	}
}
