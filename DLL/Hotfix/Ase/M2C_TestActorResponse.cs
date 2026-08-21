using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10047)]
[MemoryPackable(GenerateType.Object)]
public class M2C_TestActorResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<M2C_TestActorResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class M2C_TestActorResponseFormatter : MemoryPackFormatter<M2C_TestActorResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref M2C_TestActorResponse value)
		{
			M2C_TestActorResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref M2C_TestActorResponse value)
		{
			M2C_TestActorResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public string Info { get; set; }

	public static M2C_TestActorResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(M2C_TestActorResponse)) as M2C_TestActorResponse;
		}
		return new M2C_TestActorResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Info = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static M2C_TestActorResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<M2C_TestActorResponse>())
		{
			MemoryPackFormatterProvider.Register(new M2C_TestActorResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<M2C_TestActorResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<M2C_TestActorResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref M2C_TestActorResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(5, value.IsFromPool);
		writer.WriteString(value.Info);
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref M2C_TestActorResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		string info;
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				info = value.Info;
				value3 = value.RpcId;
				value4 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				info = reader.ReadString();
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				message = reader.ReadString();
				goto IL_0129;
			}
			reader.ReadUnmanaged<bool>(out value2);
			info = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value3, out value4);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(M2C_TestActorResponse), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				info = null;
				value3 = 0;
				value4 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				info = value.Info;
				value3 = value.RpcId;
				value4 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					info = reader.ReadString();
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
		value = new M2C_TestActorResponse
		{
			IsFromPool = value2,
			Info = info,
			RpcId = value3,
			Error = value4,
			Message = message
		};
		return;
		IL_0129:
		value.IsFromPool = value2;
		value.Info = info;
		value.RpcId = value3;
		value.Error = value4;
		value.Message = message;
	}
}
