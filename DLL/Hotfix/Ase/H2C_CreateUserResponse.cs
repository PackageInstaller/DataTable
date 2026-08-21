using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10004)]
[MemoryPackable(GenerateType.Object)]
public class H2C_CreateUserResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_CreateUserResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_CreateUserResponseFormatter : MemoryPackFormatter<H2C_CreateUserResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_CreateUserResponse value)
		{
			H2C_CreateUserResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_CreateUserResponse value)
		{
			H2C_CreateUserResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public int UserId { get; set; }

	[MemoryPackOrder(1)]
	public UserBaseInfo UserBaseInfo { get; set; }

	[MemoryPackOrder(2)]
	public long ServerTime { get; set; }

	[MemoryPackOrder(3)]
	public long ServerOpenTime { get; set; }

	public static H2C_CreateUserResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_CreateUserResponse)) as H2C_CreateUserResponse;
		}
		return new H2C_CreateUserResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UserId = 0;
			UserBaseInfo = null;
			ServerTime = 0L;
			ServerOpenTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_CreateUserResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_CreateUserResponse>())
		{
			MemoryPackFormatterProvider.Register(new H2C_CreateUserResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_CreateUserResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_CreateUserResponse>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_CreateUserResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(8, value.IsFromPool, value.UserId);
		writer.WritePackable<UserBaseInfo>(value.UserBaseInfo);
		writer.WriteUnmanaged<long, long, int, int>(value.ServerTime, value.ServerOpenTime, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_CreateUserResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		UserBaseInfo value4;
		long value5;
		long value6;
		int value7;
		int value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UserBaseInfo;
				value5 = value.ServerTime;
				value6 = value.ServerOpenTime;
				value7 = value.RpcId;
				value8 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				message = reader.ReadString();
				goto IL_01ae;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadPackable<UserBaseInfo>();
			reader.ReadUnmanaged<long, long, int, int>(out value5, out value6, out value7, out value8);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_CreateUserResponse), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0L;
				value6 = 0L;
				value7 = 0;
				value8 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UserBaseInfo;
				value5 = value.ServerTime;
				value6 = value.ServerOpenTime;
				value7 = value.RpcId;
				value8 = value.Error;
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
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											message = reader.ReadString();
											_ = 8;
										}
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_01ae;
			}
		}
		value = new H2C_CreateUserResponse
		{
			IsFromPool = value2,
			UserId = value3,
			UserBaseInfo = value4,
			ServerTime = value5,
			ServerOpenTime = value6,
			RpcId = value7,
			Error = value8,
			Message = message
		};
		return;
		IL_01ae:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.UserBaseInfo = value4;
		value.ServerTime = value5;
		value.ServerOpenTime = value6;
		value.RpcId = value7;
		value.Error = value8;
		value.Message = message;
	}
}
