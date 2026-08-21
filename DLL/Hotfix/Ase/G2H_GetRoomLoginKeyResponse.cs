using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1026)]
[MemoryPackable(GenerateType.Object)]
public class G2H_GetRoomLoginKeyResponse : MessageObject, IResponse, IMessage, IMemoryPackable<G2H_GetRoomLoginKeyResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class G2H_GetRoomLoginKeyResponseFormatter : MemoryPackFormatter<G2H_GetRoomLoginKeyResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref G2H_GetRoomLoginKeyResponse value)
		{
			G2H_GetRoomLoginKeyResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref G2H_GetRoomLoginKeyResponse value)
		{
			G2H_GetRoomLoginKeyResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long Key { get; set; }

	public static G2H_GetRoomLoginKeyResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(G2H_GetRoomLoginKeyResponse)) as G2H_GetRoomLoginKeyResponse;
		}
		return new G2H_GetRoomLoginKeyResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Key = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static G2H_GetRoomLoginKeyResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<G2H_GetRoomLoginKeyResponse>())
		{
			MemoryPackFormatterProvider.Register(new G2H_GetRoomLoginKeyResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<G2H_GetRoomLoginKeyResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<G2H_GetRoomLoginKeyResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref G2H_GetRoomLoginKeyResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, int>(5, value.IsFromPool, value.Key, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref G2H_GetRoomLoginKeyResponse? value)
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
		string message;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Key;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				message = reader.ReadString();
				goto IL_011e;
			}
			reader.ReadUnmanaged<bool, long, int, int>(out value2, out value3, out value4, out value5);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(G2H_GetRoomLoginKeyResponse), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Key;
				value4 = value.RpcId;
				value5 = value.Error;
				message = value.Message;
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
								message = reader.ReadString();
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_011e;
			}
		}
		value = new G2H_GetRoomLoginKeyResponse
		{
			IsFromPool = value2,
			Key = value3,
			RpcId = value4,
			Error = value5,
			Message = message
		};
		return;
		IL_011e:
		value.IsFromPool = value2;
		value.Key = value3;
		value.RpcId = value4;
		value.Error = value5;
		value.Message = message;
	}
}
