using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1087)]
[MemoryPackable(GenerateType.Object)]
public class InnerCreateUnionResponse : MessageObject, IResponse, IMessage, IMemoryPackable<InnerCreateUnionResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerCreateUnionResponseFormatter : MemoryPackFormatter<InnerCreateUnionResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerCreateUnionResponse value)
		{
			InnerCreateUnionResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerCreateUnionResponse value)
		{
			InnerCreateUnionResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public CreateUnionResponse outResponse { get; set; }

	public static InnerCreateUnionResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerCreateUnionResponse)) as InnerCreateUnionResponse;
		}
		return new InnerCreateUnionResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			outResponse = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerCreateUnionResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerCreateUnionResponse>())
		{
			MemoryPackFormatterProvider.Register(new InnerCreateUnionResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerCreateUnionResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerCreateUnionResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerCreateUnionResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WritePackable<CreateUnionResponse>(value.outResponse);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerCreateUnionResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		CreateUnionResponse value3;
		int value4;
		int value5;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.outResponse;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_012b;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<CreateUnionResponse>();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerCreateUnionResponse), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.outResponse;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
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
				goto IL_012b;
			}
		}
		value = new InnerCreateUnionResponse
		{
			IsFromPool = value2,
			outResponse = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_012b:
		value.IsFromPool = value2;
		value.outResponse = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
