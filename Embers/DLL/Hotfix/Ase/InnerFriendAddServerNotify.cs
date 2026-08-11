using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1116)]
[MemoryPackable(GenerateType.Object)]
public class InnerFriendAddServerNotify : MessageObject, IRequest, IMessage, IMemoryPackable<InnerFriendAddServerNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InnerFriendAddServerNotifyFormatter : MemoryPackFormatter<InnerFriendAddServerNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InnerFriendAddServerNotify value)
		{
			InnerFriendAddServerNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InnerFriendAddServerNotify value)
		{
			InnerFriendAddServerNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long UserId { get; set; }

	[MemoryPackOrder(0)]
	public UserFriendChangeNotify toClientNotify { get; set; }

	[MemoryPackOrder(1)]
	public int UserFriendCount { get; set; }

	[MemoryPackOrder(2)]
	public long FriendUserId { get; set; }

	public static InnerFriendAddServerNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InnerFriendAddServerNotify)) as InnerFriendAddServerNotify;
		}
		return new InnerFriendAddServerNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			toClientNotify = null;
			UserFriendCount = 0;
			FriendUserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InnerFriendAddServerNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InnerFriendAddServerNotify>())
		{
			MemoryPackFormatterProvider.Register(new InnerFriendAddServerNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InnerFriendAddServerNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InnerFriendAddServerNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InnerFriendAddServerNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(6, value.IsFromPool);
		writer.WritePackable<UserFriendChangeNotify>(value.toClientNotify);
		writer.WriteUnmanaged<int, long, int, long>(value.UserFriendCount, value.FriendUserId, value.RpcId, value.UserId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InnerFriendAddServerNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		UserFriendChangeNotify value3;
		int value4;
		long value5;
		int value6;
		long value7;
		if (memberCount == 6)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.toClientNotify;
				value4 = value.UserFriendCount;
				value5 = value.FriendUserId;
				value6 = value.RpcId;
				value7 = value.UserId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_0152;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<UserFriendChangeNotify>();
			reader.ReadUnmanaged<int, long, int, long>(out value4, out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 6)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InnerFriendAddServerNotify), 6, memberCount);
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
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.toClientNotify;
				value4 = value.UserFriendCount;
				value5 = value.FriendUserId;
				value6 = value.RpcId;
				value7 = value.UserId;
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
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									_ = 6;
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0152;
			}
		}
		value = new InnerFriendAddServerNotify
		{
			IsFromPool = value2,
			toClientNotify = value3,
			UserFriendCount = value4,
			FriendUserId = value5,
			RpcId = value6,
			UserId = value7
		};
		return;
		IL_0152:
		value.IsFromPool = value2;
		value.toClientNotify = value3;
		value.UserFriendCount = value4;
		value.FriendUserId = value5;
		value.RpcId = value6;
		value.UserId = value7;
	}
}
