using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(1057)]
[MemoryPackable(GenerateType.Object)]
public class UpdateTeamRoomStateRequest : MessageObject, IRequest, IMessage, IMemoryPackable<UpdateTeamRoomStateRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UpdateTeamRoomStateRequestFormatter : MemoryPackFormatter<UpdateTeamRoomStateRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UpdateTeamRoomStateRequest value)
		{
			UpdateTeamRoomStateRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UpdateTeamRoomStateRequest value)
		{
			UpdateTeamRoomStateRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long RoomId { get; set; }

	[MemoryPackOrder(2)]
	public int State { get; set; }

	[MemoryPackOrder(3)]
	public bool LeaveHalfway { get; set; }

	[MemoryPackOrder(4)]
	public bool IsWin { get; set; }

	public static UpdateTeamRoomStateRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UpdateTeamRoomStateRequest)) as UpdateTeamRoomStateRequest;
		}
		return new UpdateTeamRoomStateRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			RoomId = 0L;
			State = 0;
			LeaveHalfway = false;
			IsWin = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UpdateTeamRoomStateRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UpdateTeamRoomStateRequest>())
		{
			MemoryPackFormatterProvider.Register(new UpdateTeamRoomStateRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UpdateTeamRoomStateRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UpdateTeamRoomStateRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UpdateTeamRoomStateRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, long, int, bool, bool, int>(7, value.IsFromPool, value.UserId, value.RoomId, value.State, value.LeaveHalfway, value.IsWin, value.RpcId);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UpdateTeamRoomStateRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		int value5;
		bool value6;
		bool value7;
		int value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoomId;
				value5 = value.State;
				value6 = value.LeaveHalfway;
				value7 = value.IsWin;
				value8 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<bool>(out value6);
				reader.ReadUnmanaged<bool>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				goto IL_0172;
			}
			reader.ReadUnmanaged<bool, long, long, int, bool, bool, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UpdateTeamRoomStateRequest), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = 0;
				value6 = false;
				value7 = false;
				value8 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoomId;
				value5 = value.State;
				value6 = value.LeaveHalfway;
				value7 = value.IsWin;
				value8 = value.RpcId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<bool>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<bool>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										_ = 7;
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_0172;
			}
		}
		value = new UpdateTeamRoomStateRequest
		{
			IsFromPool = value2,
			UserId = value3,
			RoomId = value4,
			State = value5,
			LeaveHalfway = value6,
			IsWin = value7,
			RpcId = value8
		};
		return;
		IL_0172:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RoomId = value4;
		value.State = value5;
		value.LeaveHalfway = value6;
		value.IsWin = value7;
		value.RpcId = value8;
	}
}
