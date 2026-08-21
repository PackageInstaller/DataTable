using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10422)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightHandleInviteOpeRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<MultiFightHandleInviteOpeRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightHandleInviteOpeRequestFormatter : MemoryPackFormatter<MultiFightHandleInviteOpeRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightHandleInviteOpeRequest value)
		{
			MultiFightHandleInviteOpeRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightHandleInviteOpeRequest value)
		{
			MultiFightHandleInviteOpeRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(80)]
	public int LoginServerId { get; set; }

	[MemoryPackOrder(81)]
	public long LoginSecretKey { get; set; }

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(92)]
	public int UserrType { get; set; }

	[MemoryPackOrder(0)]
	public int Ope { get; set; }

	[MemoryPackOrder(1)]
	public long InviteUserId { get; set; }

	[MemoryPackOrder(2)]
	public long RoomId { get; set; }

	[MemoryPackOrder(3)]
	public int SelectModel { get; set; }

	public static MultiFightHandleInviteOpeRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightHandleInviteOpeRequest)) as MultiFightHandleInviteOpeRequest;
		}
		return new MultiFightHandleInviteOpeRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			UserrType = 0;
			Ope = 0;
			InviteUserId = 0L;
			RoomId = 0L;
			SelectModel = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightHandleInviteOpeRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightHandleInviteOpeRequest>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightHandleInviteOpeRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightHandleInviteOpeRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightHandleInviteOpeRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightHandleInviteOpeRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, int, long, long, int, int, long, int, long, int>(10, value.IsFromPool, value.Ope, value.InviteUserId, value.RoomId, value.SelectModel, value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId, value.UserrType);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightHandleInviteOpeRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		long value5;
		int value6;
		int value7;
		long value8;
		int value9;
		long value10;
		int value11;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Ope;
				value4 = value.InviteUserId;
				value5 = value.RoomId;
				value6 = value.SelectModel;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.ActorId;
				value11 = value.UserrType;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				goto IL_01fa;
			}
			reader.ReadUnmanaged<bool, int, long, long, int, int, long, int, long, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9, out value10, out value11);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightHandleInviteOpeRequest), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = 0L;
				value6 = 0;
				value7 = 0;
				value8 = 0L;
				value9 = 0;
				value10 = 0L;
				value11 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Ope;
				value4 = value.InviteUserId;
				value5 = value.RoomId;
				value6 = value.SelectModel;
				value7 = value.LoginServerId;
				value8 = value.LoginSecretKey;
				value9 = value.RpcId;
				value10 = value.ActorId;
				value11 = value.UserrType;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
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
										reader.ReadUnmanaged<long>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value11);
													_ = 10;
												}
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
				goto IL_01fa;
			}
		}
		value = new MultiFightHandleInviteOpeRequest
		{
			IsFromPool = value2,
			Ope = value3,
			InviteUserId = value4,
			RoomId = value5,
			SelectModel = value6,
			LoginServerId = value7,
			LoginSecretKey = value8,
			RpcId = value9,
			ActorId = value10,
			UserrType = value11
		};
		return;
		IL_01fa:
		value.IsFromPool = value2;
		value.Ope = value3;
		value.InviteUserId = value4;
		value.RoomId = value5;
		value.SelectModel = value6;
		value.LoginServerId = value7;
		value.LoginSecretKey = value8;
		value.RpcId = value9;
		value.ActorId = value10;
		value.UserrType = value11;
	}
}
