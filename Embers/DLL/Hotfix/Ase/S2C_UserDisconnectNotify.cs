using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10030)]
[MemoryPackable(GenerateType.Object)]
public class S2C_UserDisconnectNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<S2C_UserDisconnectNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_UserDisconnectNotifyFormatter : MemoryPackFormatter<S2C_UserDisconnectNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_UserDisconnectNotify value)
		{
			S2C_UserDisconnectNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_UserDisconnectNotify value)
		{
			S2C_UserDisconnectNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long PlayerId { get; set; }

	[MemoryPackOrder(1)]
	public bool IsDisconnect { get; set; }

	[MemoryPackOrder(2)]
	public int Reason { get; set; }

	public static S2C_UserDisconnectNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_UserDisconnectNotify)) as S2C_UserDisconnectNotify;
		}
		return new S2C_UserDisconnectNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			ActorId = 0L;
			PlayerId = 0L;
			IsDisconnect = false;
			Reason = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_UserDisconnectNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_UserDisconnectNotify>())
		{
			MemoryPackFormatterProvider.Register(new S2C_UserDisconnectNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_UserDisconnectNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_UserDisconnectNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_UserDisconnectNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, bool, int, int, int>(8, value.IsFromPool, value.PlayerId, value.IsDisconnect, value.Reason, value.RpcId, value.Error);
		writer.WriteString(value.Message);
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_UserDisconnectNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		bool value4;
		int value5;
		int value6;
		int value7;
		long value8;
		string message;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PlayerId;
				value4 = value.IsDisconnect;
				value5 = value.Reason;
				value6 = value.RpcId;
				value7 = value.Error;
				message = value.Message;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<bool>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				message = reader.ReadString();
				reader.ReadUnmanaged<long>(out value8);
				goto IL_01a9;
			}
			reader.ReadUnmanaged<bool, long, bool, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7);
			message = reader.ReadString();
			reader.ReadUnmanaged<long>(out value8);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_UserDisconnectNotify), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = false;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				message = null;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PlayerId;
				value4 = value.IsDisconnect;
				value5 = value.Reason;
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
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<bool>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
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
		value = new S2C_UserDisconnectNotify
		{
			IsFromPool = value2,
			PlayerId = value3,
			IsDisconnect = value4,
			Reason = value5,
			RpcId = value6,
			Error = value7,
			Message = message,
			ActorId = value8
		};
		return;
		IL_01a9:
		value.IsFromPool = value2;
		value.PlayerId = value3;
		value.IsDisconnect = value4;
		value.Reason = value5;
		value.RpcId = value6;
		value.Error = value7;
		value.Message = message;
		value.ActorId = value8;
	}
}
