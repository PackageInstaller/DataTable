using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10692)]
[MemoryPackable(GenerateType.Object)]
public class UnionRecruitMemberNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<UnionRecruitMemberNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UnionRecruitMemberNotifyFormatter : MemoryPackFormatter<UnionRecruitMemberNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UnionRecruitMemberNotify value)
		{
			UnionRecruitMemberNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UnionRecruitMemberNotify value)
		{
			UnionRecruitMemberNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int Channel { get; set; }

	[MemoryPackOrder(1)]
	public string Content { get; set; }

	[MemoryPackOrder(2)]
	public PbChatUserInfo UserInfo { get; set; }

	[MemoryPackOrder(6)]
	public long SendUserId { get; set; }

	[MemoryPackOrder(7)]
	public long UnionId { get; set; }

	[MemoryPackOrder(8)]
	public string UnionName { get; set; }

	[MemoryPackOrder(9)]
	public int UnionLevel { get; set; }

	public static UnionRecruitMemberNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UnionRecruitMemberNotify)) as UnionRecruitMemberNotify;
		}
		return new UnionRecruitMemberNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Channel = 0;
			Content = null;
			UserInfo = null;
			SendUserId = 0L;
			UnionId = 0L;
			UnionName = null;
			UnionLevel = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UnionRecruitMemberNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UnionRecruitMemberNotify>())
		{
			MemoryPackFormatterProvider.Register(new UnionRecruitMemberNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UnionRecruitMemberNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UnionRecruitMemberNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UnionRecruitMemberNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(10, value.IsFromPool, value.Channel);
		writer.WriteString(value.Content);
		writer.WritePackable<PbChatUserInfo>(value.UserInfo);
		writer.WriteUnmanaged<long, long>(value.SendUserId, value.UnionId);
		writer.WriteString(value.UnionName);
		writer.WriteUnmanaged<int, int, long>(value.UnionLevel, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UnionRecruitMemberNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		PbChatUserInfo value4;
		long value5;
		long value6;
		int value7;
		int value8;
		long value9;
		string content;
		string unionName;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Channel;
				content = value.Content;
				value4 = value.UserInfo;
				value5 = value.SendUserId;
				value6 = value.UnionId;
				unionName = value.UnionName;
				value7 = value.UnionLevel;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				content = reader.ReadString();
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				unionName = reader.ReadString();
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_0214;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			content = reader.ReadString();
			value4 = reader.ReadPackable<PbChatUserInfo>();
			reader.ReadUnmanaged<long, long>(out value5, out value6);
			unionName = reader.ReadString();
			reader.ReadUnmanaged<int, int, long>(out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UnionRecruitMemberNotify), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				content = null;
				value4 = null;
				value5 = 0L;
				value6 = 0L;
				unionName = null;
				value7 = 0;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Channel;
				content = value.Content;
				value4 = value.UserInfo;
				value5 = value.SendUserId;
				value6 = value.UnionId;
				unionName = value.UnionName;
				value7 = value.UnionLevel;
				value8 = value.RpcId;
				value9 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						content = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadPackable(ref value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value5);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value6);
									if (memberCount != 6)
									{
										unionName = reader.ReadString();
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value7);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value8);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value9);
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
				goto IL_0214;
			}
		}
		value = new UnionRecruitMemberNotify
		{
			IsFromPool = value2,
			Channel = value3,
			Content = content,
			UserInfo = value4,
			SendUserId = value5,
			UnionId = value6,
			UnionName = unionName,
			UnionLevel = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_0214:
		value.IsFromPool = value2;
		value.Channel = value3;
		value.Content = content;
		value.UserInfo = value4;
		value.SendUserId = value5;
		value.UnionId = value6;
		value.UnionName = unionName;
		value.UnionLevel = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
