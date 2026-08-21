using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10687)]
[MemoryPackable(GenerateType.Object)]
public class InviteUserToUnionNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<InviteUserToUnionNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class InviteUserToUnionNotifyFormatter : MemoryPackFormatter<InviteUserToUnionNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref InviteUserToUnionNotify value)
		{
			InviteUserToUnionNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref InviteUserToUnionNotify value)
		{
			InviteUserToUnionNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UnionId { get; set; }

	[MemoryPackOrder(1)]
	public string UnionName { get; set; }

	[MemoryPackOrder(2)]
	public int UnionLevel { get; set; }

	[MemoryPackOrder(3)]
	public string UserName { get; set; }

	[MemoryPackOrder(4)]
	public long SendUserId { get; set; }

	public static InviteUserToUnionNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(InviteUserToUnionNotify)) as InviteUserToUnionNotify;
		}
		return new InviteUserToUnionNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UnionId = 0L;
			UnionName = null;
			UnionLevel = 0;
			UserName = null;
			SendUserId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static InviteUserToUnionNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<InviteUserToUnionNotify>())
		{
			MemoryPackFormatterProvider.Register(new InviteUserToUnionNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<InviteUserToUnionNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<InviteUserToUnionNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref InviteUserToUnionNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(8, value.IsFromPool, value.UnionId);
		writer.WriteString(value.UnionName);
		writer.WriteUnmanaged<int>(value.UnionLevel);
		writer.WriteString(value.UserName);
		writer.WriteUnmanaged<long, int, long>(value.SendUserId, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref InviteUserToUnionNotify? value)
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
		int value6;
		long value7;
		string unionName;
		string userName;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				unionName = value.UnionName;
				value4 = value.UnionLevel;
				userName = value.UserName;
				value5 = value.SendUserId;
				value6 = value.RpcId;
				value7 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				unionName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				userName = reader.ReadString();
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				goto IL_01b3;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			unionName = reader.ReadString();
			reader.ReadUnmanaged<int>(out value4);
			userName = reader.ReadString();
			reader.ReadUnmanaged<long, int, long>(out value5, out value6, out value7);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(InviteUserToUnionNotify), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				unionName = null;
				value4 = 0;
				userName = null;
				value5 = 0L;
				value6 = 0;
				value7 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UnionId;
				unionName = value.UnionName;
				value4 = value.UnionLevel;
				userName = value.UserName;
				value5 = value.SendUserId;
				value6 = value.RpcId;
				value7 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						unionName = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								userName = reader.ReadString();
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value5);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value6);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value7);
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
				goto IL_01b3;
			}
		}
		value = new InviteUserToUnionNotify
		{
			IsFromPool = value2,
			UnionId = value3,
			UnionName = unionName,
			UnionLevel = value4,
			UserName = userName,
			SendUserId = value5,
			RpcId = value6,
			ActorId = value7
		};
		return;
		IL_01b3:
		value.IsFromPool = value2;
		value.UnionId = value3;
		value.UnionName = unionName;
		value.UnionLevel = value4;
		value.UserName = userName;
		value.SendUserId = value5;
		value.RpcId = value6;
		value.ActorId = value7;
	}
}
