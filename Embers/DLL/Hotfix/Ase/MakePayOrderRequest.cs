using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10790)]
[MemoryPackable(GenerateType.Object)]
public class MakePayOrderRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<MakePayOrderRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MakePayOrderRequestFormatter : MemoryPackFormatter<MakePayOrderRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MakePayOrderRequest value)
		{
			MakePayOrderRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MakePayOrderRequest value)
		{
			MakePayOrderRequest.Deserialize(ref reader, ref value);
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
	public string Uid { get; set; }

	[MemoryPackOrder(1)]
	public string CName { get; set; }

	[MemoryPackOrder(2)]
	public int GoodsId { get; set; }

	public static MakePayOrderRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MakePayOrderRequest)) as MakePayOrderRequest;
		}
		return new MakePayOrderRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			Uid = null;
			CName = null;
			GoodsId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MakePayOrderRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MakePayOrderRequest>())
		{
			MemoryPackFormatterProvider.Register(new MakePayOrderRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MakePayOrderRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MakePayOrderRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MakePayOrderRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		writer.WriteString(value.Uid);
		writer.WriteString(value.CName);
		writer.WriteUnmanaged<int, int, long, int, long>(value.GoodsId, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MakePayOrderRequest? value)
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
		string uid;
		string cName;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				uid = value.Uid;
				cName = value.CName;
				value3 = value.GoodsId;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				uid = reader.ReadString();
				cName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_01a9;
			}
			reader.ReadUnmanaged<bool>(out value2);
			uid = reader.ReadString();
			cName = reader.ReadString();
			reader.ReadUnmanaged<int, int, long, int, long>(out value3, out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MakePayOrderRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				uid = null;
				cName = null;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				uid = value.Uid;
				cName = value.CName;
				value3 = value.GoodsId;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					uid = reader.ReadString();
					if (memberCount != 2)
					{
						cName = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value3);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value4);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value5);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value6);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value7);
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
				goto IL_01a9;
			}
		}
		value = new MakePayOrderRequest
		{
			IsFromPool = value2,
			Uid = uid,
			CName = cName,
			GoodsId = value3,
			LoginServerId = value4,
			LoginSecretKey = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_01a9:
		value.IsFromPool = value2;
		value.Uid = uid;
		value.CName = cName;
		value.GoodsId = value3;
		value.LoginServerId = value4;
		value.LoginSecretKey = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
