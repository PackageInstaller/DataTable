using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10809)]
[MemoryPackable(GenerateType.Object)]
public class ChangeSubChannelResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<ChangeSubChannelResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class ChangeSubChannelResponseFormatter : MemoryPackFormatter<ChangeSubChannelResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref ChangeSubChannelResponse value)
		{
			ChangeSubChannelResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref ChangeSubChannelResponse value)
		{
			ChangeSubChannelResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int UserNum { get; set; }

	public static ChangeSubChannelResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(ChangeSubChannelResponse)) as ChangeSubChannelResponse;
		}
		return new ChangeSubChannelResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UserNum = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static ChangeSubChannelResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<ChangeSubChannelResponse>())
		{
			MemoryPackFormatterProvider.Register(new ChangeSubChannelResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<ChangeSubChannelResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<ChangeSubChannelResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref ChangeSubChannelResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int>(5, value.IsFromPool, value.UserNum, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref ChangeSubChannelResponse? value)
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
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserNum;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_011d;
			}
			reader.ReadUnmanaged<bool, int, int, int>(out value2, out value3, out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(ChangeSubChannelResponse), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserNum;
				value4 = value.RpcId;
				value5 = value.Error;
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
								message = reader.ReadString();
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_011d;
			}
		}
		value = new ChangeSubChannelResponse
		{
			IsFromPool = value2,
			UserNum = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_011d:
		value.IsFromPool = value2;
		value.UserNum = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
