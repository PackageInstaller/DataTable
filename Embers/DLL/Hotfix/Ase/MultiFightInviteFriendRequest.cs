using System.Collections.Generic;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10419)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightInviteFriendRequest : MessageObject, IActorLocationRequest, IActorRequest, IRequest, IMessage, IMemoryPackable<MultiFightInviteFriendRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightInviteFriendRequestFormatter : MemoryPackFormatter<MultiFightInviteFriendRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightInviteFriendRequest value)
		{
			MultiFightInviteFriendRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightInviteFriendRequest value)
		{
			MultiFightInviteFriendRequest.Deserialize(ref reader, ref value);
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

	[MemoryPackOrder(91)]
	public long UserId { get; set; }

	[MemoryPackOrder(92)]
	public int ServerType { get; set; }

	[MemoryPackOrder(0)]
	public List<long> FriendIds { get; set; } = new List<long>();

	public static MultiFightInviteFriendRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightInviteFriendRequest)) as MultiFightInviteFriendRequest;
		}
		return new MultiFightInviteFriendRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			LoginServerId = 0;
			LoginSecretKey = 0L;
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			ServerType = 0;
			FriendIds.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightInviteFriendRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInviteFriendRequest>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightInviteFriendRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInviteFriendRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightInviteFriendRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<long>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<long>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightInviteFriendRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(8, value.IsFromPool);
		writer.WriteValue<List<long>>(value.FriendIds);
		writer.WriteUnmanaged<int, long, int, long, long, int>(value.LoginServerId, value.LoginSecretKey, value.RpcId, value.ActorId, value.UserId, value.ServerType);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightInviteFriendRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<long> value3;
		int value4;
		long value5;
		int value6;
		long value7;
		long value8;
		int value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FriendIds;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
				value8 = value.UserId;
				value9 = value.ServerType;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadValue(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				goto IL_01a9;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadValue<List<long>>();
			reader.ReadUnmanaged<int, long, int, long, long, int>(out value4, out value5, out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightInviteFriendRequest), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
				value8 = 0L;
				value9 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.FriendIds;
				value4 = value.LoginServerId;
				value5 = value.LoginSecretKey;
				value6 = value.RpcId;
				value7 = value.ActorId;
				value8 = value.UserId;
				value9 = value.ServerType;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadValue(ref value3);
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
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
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
		value = new MultiFightInviteFriendRequest
		{
			IsFromPool = value2,
			FriendIds = value3,
			LoginServerId = value4,
			LoginSecretKey = value5,
			RpcId = value6,
			ActorId = value7,
			UserId = value8,
			ServerType = value9
		};
		return;
		IL_01a9:
		value.IsFromPool = value2;
		value.FriendIds = value3;
		value.LoginServerId = value4;
		value.LoginSecretKey = value5;
		value.RpcId = value6;
		value.ActorId = value7;
		value.UserId = value8;
		value.ServerType = value9;
	}
}
