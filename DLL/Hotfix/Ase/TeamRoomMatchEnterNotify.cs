using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10328)]
[MemoryPackable(GenerateType.Object)]
public class TeamRoomMatchEnterNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<TeamRoomMatchEnterNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class TeamRoomMatchEnterNotifyFormatter : MemoryPackFormatter<TeamRoomMatchEnterNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref TeamRoomMatchEnterNotify value)
		{
			TeamRoomMatchEnterNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref TeamRoomMatchEnterNotify value)
		{
			TeamRoomMatchEnterNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(92)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int EnterState { get; set; }

	[MemoryPackOrder(1)]
	public long RoomId { get; set; }

	[MemoryPackOrder(2)]
	public List<PbTeamRoomUserInfo> MatchUserInfos { get; set; } = new List<PbTeamRoomUserInfo>();

	[MemoryPackOrder(3)]
	public long PlayerId { get; set; }

	[MemoryPackOrder(4)]
	public long NewCapId { get; set; }

	public static TeamRoomMatchEnterNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(TeamRoomMatchEnterNotify)) as TeamRoomMatchEnterNotify;
		}
		return new TeamRoomMatchEnterNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			EnterState = 0;
			RoomId = 0L;
			MatchUserInfos.Clear();
			PlayerId = 0L;
			NewCapId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static TeamRoomMatchEnterNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<TeamRoomMatchEnterNotify>())
		{
			MemoryPackFormatterProvider.Register(new TeamRoomMatchEnterNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<TeamRoomMatchEnterNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<TeamRoomMatchEnterNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbTeamRoomUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbTeamRoomUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref TeamRoomMatchEnterNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long>(8, value.IsFromPool, value.EnterState, value.RoomId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbTeamRoomUserInfo>>(value.MatchUserInfos));
		writer.WriteUnmanaged<long, long, int, long>(value.PlayerId, value.NewCapId, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref TeamRoomMatchEnterNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		List<PbTeamRoomUserInfo> value5;
		long value6;
		long value7;
		int value8;
		long value9;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EnterState;
				value4 = value.RoomId;
				value5 = value.MatchUserInfos;
				value6 = value.PlayerId;
				value7 = value.NewCapId;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_01ab;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
			value5 = ListFormatter.DeserializePackable<PbTeamRoomUserInfo>(ref reader);
			reader.ReadUnmanaged<long, long, int, long>(out value6, out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(TeamRoomMatchEnterNotify), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0L;
				value5 = null;
				value6 = 0L;
				value7 = 0L;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.EnterState;
				value4 = value.RoomId;
				value5 = value.MatchUserInfos;
				value6 = value.PlayerId;
				value7 = value.NewCapId;
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
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value9);
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
				goto IL_01ab;
			}
		}
		value = new TeamRoomMatchEnterNotify
		{
			IsFromPool = value2,
			EnterState = value3,
			RoomId = value4,
			MatchUserInfos = value5,
			PlayerId = value6,
			NewCapId = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_01ab:
		value.IsFromPool = value2;
		value.EnterState = value3;
		value.RoomId = value4;
		value.MatchUserInfos = value5;
		value.PlayerId = value6;
		value.NewCapId = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
