using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1133)]
[MemoryPackable(GenerateType.Object)]
public class InnerMultiFightInviteFriendNotify : MessageObject, IRequest, IMessage, IMemoryPackable<InnerMultiFightInviteFriendNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerMultiFightInviteFriendNotifyFormatter : MemoryPackFormatter<InnerMultiFightInviteFriendNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerMultiFightInviteFriendNotify value)
		{
			InnerMultiFightInviteFriendNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerMultiFightInviteFriendNotify value)
		{
			InnerMultiFightInviteFriendNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long BeInvitedUserId { get; set; }

	[MemoryPackOrder(1)]
	public long RoomId { get; set; }

	[MemoryPackOrder(2)]
	public int CopyId { get; set; }

	[MemoryPackOrder(3)]
	public long InviteUserId { get; set; }

	[MemoryPackOrder(4)]
	public string InviteUserName { get; set; }

	public static InnerMultiFightInviteFriendNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerMultiFightInviteFriendNotify)) as InnerMultiFightInviteFriendNotify;
		}
		return new InnerMultiFightInviteFriendNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			BeInvitedUserId = 0L;
			RoomId = 0L;
			CopyId = 0;
			InviteUserId = 0L;
			InviteUserName = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerMultiFightInviteFriendNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerMultiFightInviteFriendNotify>())
		{
			MemoryPackFormatterProvider.Register(new InnerMultiFightInviteFriendNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerMultiFightInviteFriendNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerMultiFightInviteFriendNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerMultiFightInviteFriendNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long, int, long>(7, value.IsFromPool, value.BeInvitedUserId, value.RoomId, value.CopyId, value.InviteUserId);
		writer.WriteString(value.InviteUserName);
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerMultiFightInviteFriendNotify? value)
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
		long value6;
		int value7;
		string inviteUserName;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.BeInvitedUserId;
				value4 = value.RoomId;
				value5 = value.CopyId;
				value6 = value.InviteUserId;
				inviteUserName = value.InviteUserName;
				value7 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				inviteUserName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value7);
				goto IL_017f;
			}
			reader.ReadUnmanaged<bool, long, long, int, long>(out value2, out value3, out value4, out value5, out value6);
			inviteUserName = reader.ReadString();
			reader.ReadUnmanaged<int>(out value7);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerMultiFightInviteFriendNotify), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
				inviteUserName = null;
				value7 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.BeInvitedUserId;
				value4 = value.RoomId;
				value5 = value.CopyId;
				value6 = value.InviteUserId;
				inviteUserName = value.InviteUserName;
				value7 = value.RpcId;
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
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									inviteUserName = reader.ReadString();
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_017f;
			}
		}
		value = new InnerMultiFightInviteFriendNotify
		{
			IsFromPool = value2,
			BeInvitedUserId = value3,
			RoomId = value4,
			CopyId = value5,
			InviteUserId = value6,
			InviteUserName = inviteUserName,
			RpcId = value7
		};
		return;
		IL_017f:
		value.IsFromPool = value2;
		value.BeInvitedUserId = value3;
		value.RoomId = value4;
		value.CopyId = value5;
		value.InviteUserId = value6;
		value.InviteUserName = inviteUserName;
		value.RpcId = value7;
	}
}
