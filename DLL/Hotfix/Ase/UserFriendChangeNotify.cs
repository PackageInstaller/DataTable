using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10189)]
[MemoryPackable(GenerateType.Object)]
public class UserFriendChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<UserFriendChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UserFriendChangeNotifyFormatter : MemoryPackFormatter<UserFriendChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UserFriendChangeNotify value)
		{
			UserFriendChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UserFriendChangeNotify value)
		{
			UserFriendChangeNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int ChangeState { get; set; }

	[MemoryPackOrder(1)]
	public PbFriendItemInfo FriendInfo { get; set; }

	[MemoryPackOrder(2)]
	public string VertifyMessage { get; set; }

	public static UserFriendChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UserFriendChangeNotify)) as UserFriendChangeNotify;
		}
		return new UserFriendChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			ChangeState = 0;
			FriendInfo = null;
			VertifyMessage = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UserFriendChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UserFriendChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new UserFriendChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UserFriendChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UserFriendChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UserFriendChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(6, value.IsFromPool, value.ChangeState);
		writer.WritePackable<PbFriendItemInfo>(value.FriendInfo);
		writer.WriteString(value.VertifyMessage);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UserFriendChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		PbFriendItemInfo value4;
		int value5;
		long value6;
		string vertifyMessage;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ChangeState;
				value4 = value.FriendInfo;
				vertifyMessage = value.VertifyMessage;
				value5 = value.RpcId;
				value6 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadPackable(ref value4);
				vertifyMessage = reader.ReadString();
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				goto IL_0157;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadPackable<PbFriendItemInfo>();
			vertifyMessage = reader.ReadString();
			reader.ReadUnmanaged<int, long>(out value5, out value6);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UserFriendChangeNotify), 6, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				vertifyMessage = null;
				value5 = 0;
				value6 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ChangeState;
				value4 = value.FriendInfo;
				vertifyMessage = value.VertifyMessage;
				value5 = value.RpcId;
				value6 = value.ActorId;
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
							vertifyMessage = reader.ReadString();
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value6);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0157;
			}
		}
		value = new UserFriendChangeNotify
		{
			IsFromPool = value2,
			ChangeState = value3,
			FriendInfo = value4,
			VertifyMessage = vertifyMessage,
			RpcId = value5,
			ActorId = value6
		};
		return;
		IL_0157:
		value.IsFromPool = value2;
		value.ChangeState = value3;
		value.FriendInfo = value4;
		value.VertifyMessage = vertifyMessage;
		value.RpcId = value5;
		value.ActorId = value6;
	}
}
