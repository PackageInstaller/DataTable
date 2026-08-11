using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1132)]
[MemoryPackable(GenerateType.Object)]
public class InnerChatCheckResponse : MessageObject, IResponse, IMessage, IMemoryPackable<InnerChatCheckResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerChatCheckResponseFormatter : MemoryPackFormatter<InnerChatCheckResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerChatCheckResponse value)
		{
			InnerChatCheckResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerChatCheckResponse value)
		{
			InnerChatCheckResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int ChatTimes { get; set; }

	[MemoryPackOrder(1)]
	public long LastChatTime { get; set; }

	[MemoryPackOrder(2)]
	public bool CanSend { get; set; }

	public static InnerChatCheckResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerChatCheckResponse)) as InnerChatCheckResponse;
		}
		return new InnerChatCheckResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			ChatTimes = 0;
			LastChatTime = 0L;
			CanSend = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerChatCheckResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerChatCheckResponse>())
		{
			MemoryPackFormatterProvider.Register(new InnerChatCheckResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerChatCheckResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerChatCheckResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerChatCheckResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long, bool, int, int>(7, value.IsFromPool, value.ChatTimes, value.LastChatTime, value.CanSend, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerChatCheckResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		bool value5;
		int value6;
		int value7;
		string message;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ChatTimes;
				value4 = value.LastChatTime;
				value5 = value.CanSend;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<bool>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				goto IL_0177;
			}
			reader.ReadUnmanaged<bool, int, long, bool, int, int>(out value2, out value3, out value4, out value5, out value6, out value7);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerChatCheckResponse), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = false;
				value6 = 0;
				value7 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ChatTimes;
				value4 = value.LastChatTime;
				value5 = value.CanSend;
				value6 = value.RpcId;
				value7 = value.Error;
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
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<bool>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										message = reader.ReadString();
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0177;
			}
		}
		value = new InnerChatCheckResponse
		{
			IsFromPool = value2,
			ChatTimes = value3,
			LastChatTime = value4,
			CanSend = value5,
			RpcId = value6,
			Error = value7,
			Message = message
		};
		return;
		IL_0177:
		value.IsFromPool = value2;
		value.ChatTimes = value3;
		value.LastChatTime = value4;
		value.CanSend = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
	}
}
