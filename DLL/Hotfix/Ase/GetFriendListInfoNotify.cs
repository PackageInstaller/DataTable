using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10811)]
[MemoryPackable(GenerateType.Object)]
public class GetFriendListInfoNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<GetFriendListInfoNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class GetFriendListInfoNotifyFormatter : MemoryPackFormatter<GetFriendListInfoNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref GetFriendListInfoNotify value)
		{
			GetFriendListInfoNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref GetFriendListInfoNotify value)
		{
			GetFriendListInfoNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int FriendListType { get; set; }

	[MemoryPackOrder(1)]
	public List<PbFriendItemInfo> Friends { get; set; } = new List<PbFriendItemInfo>();

	public static GetFriendListInfoNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(GetFriendListInfoNotify)) as GetFriendListInfoNotify;
		}
		return new GetFriendListInfoNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ActorId = 0L;
			FriendListType = 0;
			Friends.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static GetFriendListInfoNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<GetFriendListInfoNotify>())
		{
			MemoryPackFormatterProvider.Register(new GetFriendListInfoNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<GetFriendListInfoNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<GetFriendListInfoNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbFriendItemInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbFriendItemInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref GetFriendListInfoNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(4, value.IsFromPool, value.FriendListType);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbFriendItemInfo>>(value.Friends));
		writer.WriteUnmanaged<long>(value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref GetFriendListInfoNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		List<PbFriendItemInfo> value4;
		long value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.FriendListType;
				value4 = value.Friends;
				value5 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				reader.ReadUnmanaged<long>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = ListFormatter.DeserializePackable<PbFriendItemInfo>(ref reader);
			reader.ReadUnmanaged<long>(out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(GetFriendListInfoNotify), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.FriendListType;
				value4 = value.Friends;
				value5 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
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
		value = new GetFriendListInfoNotify
		{
			IsFromPool = value2,
			FriendListType = value3,
			Friends = value4,
			ActorId = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.FriendListType = value3;
		value.Friends = value4;
		value.ActorId = value5;
	}
}
