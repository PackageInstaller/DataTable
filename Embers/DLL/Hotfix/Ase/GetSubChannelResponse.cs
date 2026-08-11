using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10807)]
[MemoryPackable(GenerateType.Object)]
public class GetSubChannelResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<GetSubChannelResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetSubChannelResponseFormatter : MemoryPackFormatter<GetSubChannelResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetSubChannelResponse value)
		{
			GetSubChannelResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetSubChannelResponse value)
		{
			GetSubChannelResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int SubChannel { get; set; }

	[MemoryPackOrder(1)]
	public int UserNum { get; set; }

	public static GetSubChannelResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetSubChannelResponse)) as GetSubChannelResponse;
		}
		return new GetSubChannelResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			SubChannel = 0;
			UserNum = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetSubChannelResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetSubChannelResponse>())
		{
			MemoryPackFormatterProvider.Register(new GetSubChannelResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetSubChannelResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetSubChannelResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetSubChannelResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int>(6, value.IsFromPool, value.SubChannel, value.UserNum, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetSubChannelResponse? value)
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
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.SubChannel;
				value4 = value.UserNum;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_014b;
			}
			reader.ReadUnmanaged<bool, int, int, int, int>(out value2, out value3, out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetSubChannelResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.SubChannel;
				value4 = value.UserNum;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
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
									message = reader.ReadString();
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_014b;
			}
		}
		value = new GetSubChannelResponse
		{
			IsFromPool = value2,
			SubChannel = value3,
			UserNum = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_014b:
		value.IsFromPool = value2;
		value.SubChannel = value3;
		value.UserNum = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
