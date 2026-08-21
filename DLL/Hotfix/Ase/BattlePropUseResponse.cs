using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10550)]
[MemoryPackable(GenerateType.Object)]
public class BattlePropUseResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<BattlePropUseResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BattlePropUseResponseFormatter : MemoryPackFormatter<BattlePropUseResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BattlePropUseResponse value)
		{
			BattlePropUseResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BattlePropUseResponse value)
		{
			BattlePropUseResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	public static BattlePropUseResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BattlePropUseResponse)) as BattlePropUseResponse;
		}
		return new BattlePropUseResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BattlePropUseResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BattlePropUseResponse>())
		{
			MemoryPackFormatterProvider.Register(new BattlePropUseResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BattlePropUseResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BattlePropUseResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BattlePropUseResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(4, value.IsFromPool, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BattlePropUseResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		string message;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
				value4 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				message = reader.ReadString();
				goto IL_00ef;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BattlePropUseResponse), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RpcId;
				value4 = value.Error;
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
							message = reader.ReadString();
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00ef;
			}
		}
		value = new BattlePropUseResponse
		{
			IsFromPool = value2,
			RpcId = value3,
			Error = value4,
			Message = message
		};
		return;
		IL_00ef:
		value.IsFromPool = value2;
		value.RpcId = value3;
		value.Error = value4;
		value.Message = message;
	}
}
