using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10025)]
[MemoryPackable(GenerateType.Object)]
public class C2S_LoadSuccess : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<C2S_LoadSuccess>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class C2S_LoadSuccessFormatter : MemoryPackFormatter<C2S_LoadSuccess>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref C2S_LoadSuccess value)
		{
			C2S_LoadSuccess.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref C2S_LoadSuccess value)
		{
			C2S_LoadSuccess.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int SeatId { get; set; }

	public static C2S_LoadSuccess Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(C2S_LoadSuccess)) as C2S_LoadSuccess;
		}
		return new C2S_LoadSuccess();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			Error = 0;
			Message = null;
			ActorId = 0L;
			SeatId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static C2S_LoadSuccess()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_LoadSuccess>())
		{
			MemoryPackFormatterProvider.Register(new C2S_LoadSuccessFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<C2S_LoadSuccess[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<C2S_LoadSuccess>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref C2S_LoadSuccess? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, long, int, int>(8, value.IsFromPool, value.SeatId, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.Error);
		writer.WriteString(value.Message);
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref C2S_LoadSuccess? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		int value6;
		int value7;
		long value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.SeatId;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				reader.ReadUnmanaged<long>(out value8);
				goto IL_01a9;
			}
			reader.ReadUnmanaged<bool, int, int, long, int, int>(out value2, out value3, out value4, out value5, out value6, out value7);
			message = reader.ReadString();
			reader.ReadUnmanaged<long>(out value8);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(C2S_LoadSuccess), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0;
				message = null;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.SeatId;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				value8 = value.ActorId;
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
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										message = reader.ReadString();
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value8);
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
				goto IL_01a9;
			}
		}
		value = new C2S_LoadSuccess
		{
			IsFromPool = value2,
			SeatId = value3,
			LoginServerId = value4,
			LoginSecretKey = value5,
			RpcId = value6,
			Error = value7,
			Message = message,
			ActorId = value8
		};
		return;
		IL_01a9:
		value.IsFromPool = value2;
		value.SeatId = value3;
		value.LoginServerId = value4;
		value.LoginSecretKey = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
		value.ActorId = value8;
	}
}
