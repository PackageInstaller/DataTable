using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10797)]
[MemoryPackable(GenerateType.Object)]
public class UserInfohNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<UserInfohNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UserInfohNotifyFormatter : MemoryPackFormatter<UserInfohNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UserInfohNotify value)
		{
			UserInfohNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UserInfohNotify value)
		{
			UserInfohNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public UserBaseInfo UserBaseInfo { get; set; }

	public static UserInfohNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UserInfohNotify)) as UserInfohNotify;
		}
		return new UserInfohNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserBaseInfo = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UserInfohNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UserInfohNotify>())
		{
			MemoryPackFormatterProvider.Register(new UserInfohNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UserInfohNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UserInfohNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UserInfohNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(4, value.IsFromPool);
		writer.WritePackable<UserBaseInfo>(value.UserBaseInfo);
		writer.WriteUnmanaged<int, long>(value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UserInfohNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		UserBaseInfo value3;
		int value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserBaseInfo;
				value4 = value.RpcId;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<UserBaseInfo>();
			reader.ReadUnmanaged<int, long>(out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UserInfohNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserBaseInfo;
				value4 = value.RpcId;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f5;
			}
		}
		value = new UserInfohNotify
		{
			IsFromPool = value2,
			UserBaseInfo = value3,
			RpcId = value4,
			ActorId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.UserBaseInfo = value3;
		value.RpcId = value4;
		value.ActorId = value5;
	}
}
