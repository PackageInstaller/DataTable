using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10617)]
[MemoryPackable(GenerateType.Object)]
public class BattleRecruitMemberNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<BattleRecruitMemberNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BattleRecruitMemberNotifyFormatter : MemoryPackFormatter<BattleRecruitMemberNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BattleRecruitMemberNotify value)
		{
			BattleRecruitMemberNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BattleRecruitMemberNotify value)
		{
			BattleRecruitMemberNotify.Deserialize(ref reader, ref value);
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
	public int CopyId { get; set; }

	[MemoryPackOrder(8)]
	public int UserCount { get; set; }

	[MemoryPackOrder(9)]
	public long RoomId { get; set; }

	public static BattleRecruitMemberNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BattleRecruitMemberNotify)) as BattleRecruitMemberNotify;
		}
		return new BattleRecruitMemberNotify();
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
			CopyId = 0;
			UserCount = 0;
			RoomId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BattleRecruitMemberNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BattleRecruitMemberNotify>())
		{
			MemoryPackFormatterProvider.Register(new BattleRecruitMemberNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BattleRecruitMemberNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BattleRecruitMemberNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BattleRecruitMemberNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(10, value.IsFromPool, value.Channel);
		writer.WriteString(value.Content);
		writer.WritePackable<PbChatUserInfo>(value.UserInfo);
		writer.WriteUnmanaged<long, int, int, long, int, long>(value.SendUserId, value.CopyId, value.UserCount, value.RoomId, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BattleRecruitMemberNotify? value)
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
		int value6;
		int value7;
		long value8;
		int value9;
		long value10;
		string content;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Channel;
				content = value.Content;
				value4 = value.UserInfo;
				value5 = value.SendUserId;
				value6 = value.CopyId;
				value7 = value.UserCount;
				value8 = value.RoomId;
				value9 = value.RpcId;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				content = reader.ReadString();
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_0208;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			content = reader.ReadString();
			value4 = reader.ReadPackable<PbChatUserInfo>();
			reader.ReadUnmanaged<long, int, int, long, int, long>(out value5, out value6, out value7, out value8, out value9, out value10);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BattleRecruitMemberNotify), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				content = null;
				value4 = null;
				value5 = 0L;
				value6 = 0;
				value7 = 0;
				value8 = 0L;
				value9 = 0;
				value10 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Channel;
				content = value.Content;
				value4 = value.UserInfo;
				value5 = value.SendUserId;
				value6 = value.CopyId;
				value7 = value.UserCount;
				value8 = value.RoomId;
				value9 = value.RpcId;
				value10 = value.ActorId;
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
									reader.ReadUnmanaged<int>(out value6);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value8);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value9);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value10);
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
				goto IL_0208;
			}
		}
		value = new BattleRecruitMemberNotify
		{
			IsFromPool = value2,
			Channel = value3,
			Content = content,
			UserInfo = value4,
			SendUserId = value5,
			CopyId = value6,
			UserCount = value7,
			RoomId = value8,
			RpcId = value9,
			ActorId = value10
		};
		return;
		IL_0208:
		value.IsFromPool = value2;
		value.Channel = value3;
		value.Content = content;
		value.UserInfo = value4;
		value.SendUserId = value5;
		value.CopyId = value6;
		value.UserCount = value7;
		value.RoomId = value8;
		value.RpcId = value9;
		value.ActorId = value10;
	}
}
