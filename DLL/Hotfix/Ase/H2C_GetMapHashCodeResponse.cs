using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10167)]
[MemoryPackable(GenerateType.Object)]
public class H2C_GetMapHashCodeResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_GetMapHashCodeResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_GetMapHashCodeResponseFormatter : MemoryPackFormatter<H2C_GetMapHashCodeResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_GetMapHashCodeResponse value)
		{
			H2C_GetMapHashCodeResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_GetMapHashCodeResponse value)
		{
			H2C_GetMapHashCodeResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public string HashCode { get; set; }

	public static H2C_GetMapHashCodeResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_GetMapHashCodeResponse)) as H2C_GetMapHashCodeResponse;
		}
		return new H2C_GetMapHashCodeResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			HashCode = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_GetMapHashCodeResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_GetMapHashCodeResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2C_GetMapHashCodeResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_GetMapHashCodeResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_GetMapHashCodeResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_GetMapHashCodeResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WriteString(value.HashCode);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_GetMapHashCodeResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		string hashCode;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				hashCode = value.HashCode;
				value3 = value.RpcId;
				value4 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				hashCode = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				message = reader.ReadString();
				goto IL_0129;
			}
			reader.ReadUnmanaged<bool>(out value2);
			hashCode = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value3, out value4);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_GetMapHashCodeResponse), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				hashCode = null;
				value3 = 0;
				value4 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				hashCode = value.HashCode;
				value3 = value.RpcId;
				value4 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					hashCode = reader.ReadString();
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value3);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
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
				goto IL_0129;
			}
		}
		value = new H2C_GetMapHashCodeResponse
		{
			IsFromPool = value2,
			HashCode = hashCode,
			RpcId = value3,
			Error = value4,
			Message = message
		};
		return;
		IL_0129:
		value.IsFromPool = value2;
		value.HashCode = hashCode;
		value.RpcId = value3;
		value.Error = value4;
		value.Message = message;
	}
}
