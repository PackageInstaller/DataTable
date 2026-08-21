using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10006)]
[MemoryPackable(GenerateType.Object)]
public class H2C_LoginHall : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_LoginHall>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_LoginHallFormatter : MemoryPackFormatter<H2C_LoginHall>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_LoginHall value)
		{
			H2C_LoginHall.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_LoginHall value)
		{
			H2C_LoginHall.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public UserBaseInfo UserBaseInfo { get; set; }

	[MemoryPackOrder(2)]
	public long ServerTime { get; set; }

	[MemoryPackOrder(3)]
	public long ReloginKey { get; set; }

	[MemoryPackOrder(4)]
	public long ServerOpneTime { get; set; }

	public static H2C_LoginHall Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_LoginHall)) as H2C_LoginHall;
		}
		return new H2C_LoginHall();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			UserId = 0L;
			UserBaseInfo = null;
			ServerTime = 0L;
			ReloginKey = 0L;
			ServerOpneTime = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_LoginHall()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_LoginHall>())
		{
			MemoryPackFormatterProvider.Register(new H2C_LoginHallFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_LoginHall[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_LoginHall>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_LoginHall? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(9, value.IsFromPool, value.UserId);
		writer.WritePackable<UserBaseInfo>(value.UserBaseInfo);
		writer.WriteUnmanaged<long, long, long, int, int>(value.ServerTime, value.ReloginKey, value.ServerOpneTime, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_LoginHall? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		UserBaseInfo value4;
		long value5;
		long value6;
		long value7;
		int value8;
		int value9;
		string message;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UserBaseInfo;
				value5 = value.ServerTime;
				value6 = value.ReloginKey;
				value7 = value.ServerOpneTime;
				value8 = value.RpcId;
				value9 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				message = reader.ReadString();
				goto IL_01df;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadPackable<UserBaseInfo>();
			reader.ReadUnmanaged<long, long, long, int, int>(out value5, out value6, out value7, out value8, out value9);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_LoginHall), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0L;
				value6 = 0L;
				value7 = 0L;
				value8 = 0;
				value9 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UserBaseInfo;
				value5 = value.ServerTime;
				value6 = value.ReloginKey;
				value7 = value.ServerOpneTime;
				value8 = value.RpcId;
				value9 = value.Error;
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
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												message = reader.ReadString();
												_ = 9;
											}
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
				goto IL_01df;
			}
		}
		value = new H2C_LoginHall
		{
			IsFromPool = value2,
			UserId = value3,
			UserBaseInfo = value4,
			ServerTime = value5,
			ReloginKey = value6,
			ServerOpneTime = value7,
			RpcId = value8,
			Error = value9,
			Message = message
		};
		return;
		IL_01df:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.UserBaseInfo = value4;
		value.ServerTime = value5;
		value.ReloginKey = value6;
		value.ServerOpneTime = value7;
		value.RpcId = value8;
		value.Error = value9;
		value.Message = message;
	}
}
