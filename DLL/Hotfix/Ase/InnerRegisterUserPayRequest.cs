using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1147)]
[MemoryPackable(GenerateType.Object)]
public class InnerRegisterUserPayRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerRegisterUserPayRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerRegisterUserPayRequestFormatter : MemoryPackFormatter<InnerRegisterUserPayRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerRegisterUserPayRequest value)
		{
			InnerRegisterUserPayRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerRegisterUserPayRequest value)
		{
			InnerRegisterUserPayRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int GoodsId { get; set; }

	[MemoryPackOrder(2)]
	public int Money { get; set; }

	[MemoryPackOrder(3)]
	public string CUid { get; set; }

	[MemoryPackOrder(4)]
	public string CName { get; set; }

	[MemoryPackOrder(5)]
	public string HallAddress { get; set; }

	[MemoryPackOrder(6)]
	public long ChannelId { get; set; }

	public static InnerRegisterUserPayRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerRegisterUserPayRequest)) as InnerRegisterUserPayRequest;
		}
		return new InnerRegisterUserPayRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			GoodsId = 0;
			Money = 0;
			CUid = null;
			CName = null;
			HallAddress = null;
			ChannelId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerRegisterUserPayRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerRegisterUserPayRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerRegisterUserPayRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerRegisterUserPayRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerRegisterUserPayRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerRegisterUserPayRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, int>(10, value.IsFromPool, value.UserId, value.GoodsId, value.Money);
		writer.WriteString(value.CUid);
		writer.WriteString(value.CName);
		writer.WriteString(value.HallAddress);
		writer.WriteUnmanaged<long, int, long>(value.ChannelId, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerRegisterUserPayRequest? value)
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
		int value7;
		long value8;
		string cUid;
		string cName;
		string hallAddress;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.GoodsId;
				value5 = value.Money;
				cUid = value.CUid;
				cName = value.CName;
				hallAddress = value.HallAddress;
				value6 = value.ChannelId;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				cUid = reader.ReadString();
				cName = reader.ReadString();
				hallAddress = reader.ReadString();
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_0211;
			}
			reader.ReadUnmanaged<bool, long, int, int>(out value2, out value3, out value4, out value5);
			cUid = reader.ReadString();
			cName = reader.ReadString();
			hallAddress = reader.ReadString();
			reader.ReadUnmanaged<long, int, long>(out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerRegisterUserPayRequest), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				cUid = null;
				cName = null;
				hallAddress = null;
				value6 = 0L;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.GoodsId;
				value5 = value.Money;
				cUid = value.CUid;
				cName = value.CName;
				hallAddress = value.HallAddress;
				value6 = value.ChannelId;
				value7 = value.RpcId;
				value8 = value.ActorId;
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
								cUid = reader.ReadString();
								if (memberCount != 5)
								{
									cName = reader.ReadString();
									if (memberCount != 6)
									{
										hallAddress = reader.ReadString();
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value6);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value7);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value8);
													_ = 10;
												}
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
				goto IL_0211;
			}
		}
		value = new InnerRegisterUserPayRequest
		{
			IsFromPool = value2,
			UserId = value3,
			GoodsId = value4,
			Money = value5,
			CUid = cUid,
			CName = cName,
			HallAddress = hallAddress,
			ChannelId = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_0211:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.GoodsId = value4;
		value.Money = value5;
		value.CUid = cUid;
		value.CName = cName;
		value.HallAddress = hallAddress;
		value.ChannelId = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
