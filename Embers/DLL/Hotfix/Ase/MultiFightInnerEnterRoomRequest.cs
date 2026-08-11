using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10450)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightInnerEnterRoomRequest : MessageObject, IRequest, IMessage, IMemoryPackable<MultiFightInnerEnterRoomRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightInnerEnterRoomRequestFormatter : MemoryPackFormatter<MultiFightInnerEnterRoomRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerEnterRoomRequest value)
		{
			MultiFightInnerEnterRoomRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerEnterRoomRequest value)
		{
			MultiFightInnerEnterRoomRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public long RoomId { get; set; }

	[MemoryPackOrder(2)]
	public PbTeamRoomUserInfo MatchRoomUserInfo { get; set; }

	[MemoryPackOrder(3)]
	public bool MatchEnter { get; set; }

	[MemoryPackOrder(4)]
	public string HallAddress { get; set; }

	[MemoryPackOrder(9)]
	public int ServerId { get; set; }

	public static MultiFightInnerEnterRoomRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightInnerEnterRoomRequest)) as MultiFightInnerEnterRoomRequest;
		}
		return new MultiFightInnerEnterRoomRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			UserId = 0L;
			RoomId = 0L;
			MatchRoomUserInfo = null;
			MatchEnter = false;
			HallAddress = null;
			ServerId = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightInnerEnterRoomRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerEnterRoomRequest>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightInnerEnterRoomRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerEnterRoomRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightInnerEnterRoomRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerEnterRoomRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, long>(9, value.IsFromPool, value.UserId, value.RoomId);
		writer.WritePackable<PbTeamRoomUserInfo>(value.MatchRoomUserInfo);
		writer.WriteUnmanaged<bool>(value.MatchEnter);
		writer.WriteString(value.HallAddress);
		writer.WriteUnmanaged<int, int, long>(value.ServerId, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerEnterRoomRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		long value4;
		PbTeamRoomUserInfo value5;
		bool value6;
		int value7;
		int value8;
		long value9;
		string hallAddress;
		if (memberCount == 9)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoomId;
				value5 = value.MatchRoomUserInfo;
				value6 = value.MatchEnter;
				hallAddress = value.HallAddress;
				value7 = value.ServerId;
				value8 = value.RpcId;
				value9 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadPackable(ref value5);
				reader.ReadUnmanaged<bool>(out value6);
				hallAddress = reader.ReadString();
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				goto IL_01e5;
			}
			reader.ReadUnmanaged<bool, long, long>(out value2, out value3, out value4);
			value5 = reader.ReadPackable<PbTeamRoomUserInfo>();
			reader.ReadUnmanaged<bool>(out value6);
			hallAddress = reader.ReadString();
			reader.ReadUnmanaged<int, int, long>(out value7, out value8, out value9);
		}
		else
		{
			if (memberCount > 9)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightInnerEnterRoomRequest), 9, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0L;
				value5 = null;
				value6 = false;
				hallAddress = null;
				value7 = 0;
				value8 = 0;
				value9 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.RoomId;
				value5 = value.MatchRoomUserInfo;
				value6 = value.MatchEnter;
				hallAddress = value.HallAddress;
				value7 = value.ServerId;
				value8 = value.RpcId;
				value9 = value.ActorId;
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
							reader.ReadPackable(ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<bool>(out value6);
								if (memberCount != 5)
								{
									hallAddress = reader.ReadString();
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value7);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value8);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value9);
												_ = 9;
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
				goto IL_01e5;
			}
		}
		value = new MultiFightInnerEnterRoomRequest
		{
			IsFromPool = value2,
			UserId = value3,
			RoomId = value4,
			MatchRoomUserInfo = value5,
			MatchEnter = value6,
			HallAddress = hallAddress,
			ServerId = value7,
			RpcId = value8,
			ActorId = value9
		};
		return;
		IL_01e5:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.RoomId = value4;
		value.MatchRoomUserInfo = value5;
		value.MatchEnter = value6;
		value.HallAddress = hallAddress;
		value.ServerId = value7;
		value.RpcId = value8;
		value.ActorId = value9;
	}
}
