using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1032)]
[MemoryPackable(GenerateType.Object)]
public class B2G_CreateUnitResponse : MessageObject, IResponse, IMessage, IMemoryPackable<B2G_CreateUnitResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class B2G_CreateUnitResponseFormatter : MemoryPackFormatter<B2G_CreateUnitResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref B2G_CreateUnitResponse value)
		{
			B2G_CreateUnitResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref B2G_CreateUnitResponse value)
		{
			B2G_CreateUnitResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(3)]
	public long UnitId { get; set; }

	[MemoryPackOrder(4)]
	public long Key { get; set; }

	public static B2G_CreateUnitResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(B2G_CreateUnitResponse)) as B2G_CreateUnitResponse;
		}
		return new B2G_CreateUnitResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UnitId = 0L;
			Key = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static B2G_CreateUnitResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<B2G_CreateUnitResponse>())
		{
			MemoryPackFormatterProvider.Register(new B2G_CreateUnitResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<B2G_CreateUnitResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<B2G_CreateUnitResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref B2G_CreateUnitResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long, int, int>(6, value.IsFromPool, value.UnitId, value.Key, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref B2G_CreateUnitResponse? value)
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
		int value6;
		string message;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnitId;
				value4 = value.Key;
				value5 = value.RpcId;
				value6 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				message = reader.ReadString();
				goto IL_014d;
			}
			reader.ReadUnmanaged<bool, long, long, int, int>(out value2, out value3, out value4, out value5, out value6);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(B2G_CreateUnitResponse), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
				value6 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnitId;
				value4 = value.Key;
				value5 = value.RpcId;
				value6 = value.Error;
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
						reader.ReadUnmanaged<long>(out value4);
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
				goto IL_014d;
			}
		}
		value = new B2G_CreateUnitResponse
		{
			IsFromPool = value2,
			UnitId = value3,
			Key = value4,
			RpcId = value5,
			Error = value6,
			Message = message
		};
		return;
		IL_014d:
		value.IsFromPool = value2;
		value.UnitId = value3;
		value.Key = value4;
		value.RpcId = value5;
		value.Error = value6;
		value.Message = message;
	}
}
