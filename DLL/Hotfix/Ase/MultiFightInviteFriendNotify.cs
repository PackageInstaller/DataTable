using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10421)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightInviteFriendNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<MultiFightInviteFriendNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightInviteFriendNotifyFormatter : MemoryPackFormatter<MultiFightInviteFriendNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightInviteFriendNotify value)
		{
			MultiFightInviteFriendNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightInviteFriendNotify value)
		{
			MultiFightInviteFriendNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long FriendId { get; set; }

	[MemoryPackOrder(1)]
	public long RoomId { get; set; }

	[MemoryPackOrder(2)]
	public string UserName { get; set; }

	[MemoryPackOrder(3)]
	public int CopyId { get; set; }

	[MemoryPackOrder(4)]
	public int Difficult { get; set; }

	public static MultiFightInviteFriendNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightInviteFriendNotify)) as MultiFightInviteFriendNotify;
		}
		return new MultiFightInviteFriendNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			FriendId = 0L;
			RoomId = 0L;
			UserName = null;
			CopyId = 0;
			Difficult = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightInviteFriendNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInviteFriendNotify>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightInviteFriendNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInviteFriendNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightInviteFriendNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightInviteFriendNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long>(8, value.IsFromPool, value.FriendId, value.RoomId);
		writer.WriteString(value.UserName);
		writer.WriteUnmanaged<int, int, int, long>(value.CopyId, value.Difficult, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightInviteFriendNotify? value)
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
		int value7;
		long value8;
		string userName;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FriendId;
				value4 = value.RoomId;
				userName = value.UserName;
				value5 = value.CopyId;
				value6 = value.Difficult;
				value7 = value.RpcId;
				value8 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				userName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				goto IL_01aa;
			}
			reader.ReadUnmanaged<bool, long, long>(out value2, out value3, out value4);
			userName = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, long>(out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightInviteFriendNotify), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				userName = null;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.FriendId;
				value4 = value.RoomId;
				userName = value.UserName;
				value5 = value.CopyId;
				value6 = value.Difficult;
				value7 = value.RpcId;
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
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							userName = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
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
				goto IL_01aa;
			}
		}
		value = new MultiFightInviteFriendNotify
		{
			IsFromPool = value2,
			FriendId = value3,
			RoomId = value4,
			UserName = userName,
			CopyId = value5,
			Difficult = value6,
			RpcId = value7,
			ActorId = value8
		};
		return;
		IL_01aa:
		value.IsFromPool = value2;
		value.FriendId = value3;
		value.RoomId = value4;
		value.UserName = userName;
		value.CopyId = value5;
		value.Difficult = value6;
		value.RpcId = value7;
		value.ActorId = value8;
	}
}
