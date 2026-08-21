using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1067)]
[MemoryPackable(GenerateType.Object)]
public class InnerReloginChangeSessionInfoRequest : MessageObject, IRequest, IMessage, IMemoryPackable<InnerReloginChangeSessionInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerReloginChangeSessionInfoRequestFormatter : MemoryPackFormatter<InnerReloginChangeSessionInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerReloginChangeSessionInfoRequest value)
		{
			InnerReloginChangeSessionInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerReloginChangeSessionInfoRequest value)
		{
			InnerReloginChangeSessionInfoRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long GateSessionId { get; set; }

	[MemoryPackOrder(2)]
	public string GateAddress { get; set; }

	[MemoryPackOrder(3)]
	public string ClientAddress { get; set; }

	public static InnerReloginChangeSessionInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerReloginChangeSessionInfoRequest)) as InnerReloginChangeSessionInfoRequest;
		}
		return new InnerReloginChangeSessionInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			GateSessionId = 0L;
			GateAddress = null;
			ClientAddress = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerReloginChangeSessionInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerReloginChangeSessionInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new InnerReloginChangeSessionInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerReloginChangeSessionInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerReloginChangeSessionInfoRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerReloginChangeSessionInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long>(6, value.IsFromPool, value.UserId, value.GateSessionId);
		writer.WriteString(value.GateAddress);
		writer.WriteString(value.ClientAddress);
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerReloginChangeSessionInfoRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		int value5;
		string gateAddress;
		string clientAddress;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.GateSessionId;
				gateAddress = value.GateAddress;
				clientAddress = value.ClientAddress;
				value5 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				gateAddress = reader.ReadString();
				clientAddress = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				goto IL_0159;
			}
			reader.ReadUnmanaged<bool, long, long>(out value2, out value3, out value4);
			gateAddress = reader.ReadString();
			clientAddress = reader.ReadString();
			reader.ReadUnmanaged<int>(out value5);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerReloginChangeSessionInfoRequest), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				gateAddress = null;
				clientAddress = null;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.GateSessionId;
				gateAddress = value.GateAddress;
				clientAddress = value.ClientAddress;
				value5 = value.RpcId;
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
							gateAddress = reader.ReadString();
							if (memberCount != 4)
							{
								clientAddress = reader.ReadString();
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value5);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0159;
			}
		}
		value = new InnerReloginChangeSessionInfoRequest
		{
			IsFromPool = value2,
			UserId = value3,
			GateSessionId = value4,
			GateAddress = gateAddress,
			ClientAddress = clientAddress,
			RpcId = value5
		};
		return;
		IL_0159:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.GateSessionId = value4;
		value.GateAddress = gateAddress;
		value.ClientAddress = clientAddress;
		value.RpcId = value5;
	}
}
