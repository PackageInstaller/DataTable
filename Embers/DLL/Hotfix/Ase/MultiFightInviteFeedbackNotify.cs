using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10437)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightInviteFeedbackNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<MultiFightInviteFeedbackNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightInviteFeedbackNotifyFormatter : MemoryPackFormatter<MultiFightInviteFeedbackNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightInviteFeedbackNotify value)
		{
			MultiFightInviteFeedbackNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightInviteFeedbackNotify value)
		{
			MultiFightInviteFeedbackNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long FriendId { get; set; }

	[MemoryPackOrder(1)]
	public string UserName { get; set; }

	public static MultiFightInviteFeedbackNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightInviteFeedbackNotify)) as MultiFightInviteFeedbackNotify;
		}
		return new MultiFightInviteFeedbackNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			FriendId = 0L;
			UserName = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightInviteFeedbackNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInviteFeedbackNotify>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightInviteFeedbackNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInviteFeedbackNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightInviteFeedbackNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightInviteFeedbackNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(5, value.IsFromPool, value.FriendId);
		writer.WriteString(value.UserName);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightInviteFeedbackNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		long value5;
		string userName;
		if (memberCount == 5)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FriendId;
				userName = value.UserName;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				userName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_0122;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			userName = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 5)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightInviteFeedbackNotify), 5, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				userName = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.FriendId;
				userName = value.UserName;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						userName = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value5);
								_ = 5;
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0122;
			}
		}
		value = new MultiFightInviteFeedbackNotify
		{
			IsFromPool = value2,
			FriendId = value3,
			UserName = userName,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_0122:
		value.IsFromPool = value2;
		value.FriendId = value3;
		value.UserName = userName;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
