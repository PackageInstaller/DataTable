using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10019)]
[MemoryPackable(GenerateType.Object)]
public class MatchRoomUserChangeNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<MatchRoomUserChangeNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MatchRoomUserChangeNotifyFormatter : MemoryPackFormatter<MatchRoomUserChangeNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MatchRoomUserChangeNotify value)
		{
			MatchRoomUserChangeNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MatchRoomUserChangeNotify value)
		{
			MatchRoomUserChangeNotify.Deserialize(ref reader, ref value);
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
	public PbTeamRoomUserInfo MatchUserInfo { get; set; }

	[MemoryPackOrder(3)]
	public long PlayerId { get; set; }

	[MemoryPackOrder(4)]
	public long NewCapId { get; set; }

	[MemoryPackOrder(5)]
	public int SeatId { get; set; }

	[MemoryPackOrder(6)]
	public long UnionId { get; set; }

	public static MatchRoomUserChangeNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MatchRoomUserChangeNotify)) as MatchRoomUserChangeNotify;
		}
		return new MatchRoomUserChangeNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			EnterState = 0;
			RoomId = 0L;
			MatchUserInfo = null;
			PlayerId = 0L;
			NewCapId = 0L;
			SeatId = 0;
			UnionId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MatchRoomUserChangeNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MatchRoomUserChangeNotify>())
		{
			MemoryPackFormatterProvider.Register(new MatchRoomUserChangeNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MatchRoomUserChangeNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MatchRoomUserChangeNotify>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MatchRoomUserChangeNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, long>(10, value.IsFromPool, value.EnterState, value.RoomId);
		writer.WritePackable<PbTeamRoomUserInfo>(value.MatchUserInfo);
		writer.WriteUnmanaged<long, long, int, long, int, long>(value.PlayerId, value.NewCapId, value.SeatId, value.UnionId, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MatchRoomUserChangeNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		long value4;
		PbTeamRoomUserInfo value5;
		long value6;
		long value7;
		int value8;
		long value9;
		int value10;
		long value11;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.EnterState;
				value4 = value.RoomId;
				value5 = value.MatchUserInfo;
				value6 = value.PlayerId;
				value7 = value.NewCapId;
				value8 = value.SeatId;
				value9 = value.UnionId;
				value10 = value.RpcId;
				value11 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadPackable(ref value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<long>(out value11);
				goto IL_0207;
			}
			reader.ReadUnmanaged<bool, int, long>(out value2, out value3, out value4);
			value5 = reader.ReadPackable<PbTeamRoomUserInfo>();
			reader.ReadUnmanaged<long, long, int, long, int, long>(out value6, out value7, out value8, out value9, out value10, out value11);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MatchRoomUserChangeNotify), 10, memberCount);
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
				value10 = 0;
				value11 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.EnterState;
				value4 = value.RoomId;
				value5 = value.MatchUserInfo;
				value6 = value.PlayerId;
				value7 = value.NewCapId;
				value8 = value.SeatId;
				value9 = value.UnionId;
				value10 = value.RpcId;
				value11 = value.ActorId;
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
							reader.ReadPackable(ref value5);
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
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value11);
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
				goto IL_0207;
			}
		}
		value = new MatchRoomUserChangeNotify
		{
			IsFromPool = value2,
			EnterState = value3,
			RoomId = value4,
			MatchUserInfo = value5,
			PlayerId = value6,
			NewCapId = value7,
			SeatId = value8,
			UnionId = value9,
			RpcId = value10,
			ActorId = value11
		};
		return;
		IL_0207:
		value.IsFromPool = value2;
		value.EnterState = value3;
		value.RoomId = value4;
		value.MatchUserInfo = value5;
		value.PlayerId = value6;
		value.NewCapId = value7;
		value.SeatId = value8;
		value.UnionId = value9;
		value.RpcId = value10;
		value.ActorId = value11;
	}
}
