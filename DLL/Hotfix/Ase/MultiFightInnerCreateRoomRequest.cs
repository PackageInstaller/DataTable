using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10438)]
[MemoryPackable(GenerateType.Object)]
public class MultiFightInnerCreateRoomRequest : MessageObject, IRequest, IMessage, IMemoryPackable<MultiFightInnerCreateRoomRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class MultiFightInnerCreateRoomRequestFormatter : MemoryPackFormatter<MultiFightInnerCreateRoomRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerCreateRoomRequest value)
		{
			MultiFightInnerCreateRoomRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerCreateRoomRequest value)
		{
			MultiFightInnerCreateRoomRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int CopyId { get; set; }

	[MemoryPackOrder(2)]
	public int Difficulty { get; set; }

	[MemoryPackOrder(6)]
	public long UserId { get; set; }

	[MemoryPackOrder(7)]
	public PbTeamRoomUserInfo MatchRoomUserInfo { get; set; }

	[MemoryPackOrder(8)]
	public string HallAddress { get; set; }

	[MemoryPackOrder(9)]
	public int ServerId { get; set; }

	[MemoryPackOrder(10)]
	public int RewardTimes { get; set; }

	public static MultiFightInnerCreateRoomRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(MultiFightInnerCreateRoomRequest)) as MultiFightInnerCreateRoomRequest;
		}
		return new MultiFightInnerCreateRoomRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			CopyId = 0;
			Difficulty = 0;
			UserId = 0L;
			MatchRoomUserInfo = null;
			HallAddress = null;
			ServerId = 0;
			RewardTimes = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static MultiFightInnerCreateRoomRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerCreateRoomRequest>())
		{
			MemoryPackFormatterProvider.Register(new MultiFightInnerCreateRoomRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<MultiFightInnerCreateRoomRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<MultiFightInnerCreateRoomRequest>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref MultiFightInnerCreateRoomRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, long>(10, value.IsFromPool, value.CopyId, value.Difficulty, value.UserId);
		writer.WritePackable<PbTeamRoomUserInfo>(value.MatchRoomUserInfo);
		writer.WriteString(value.HallAddress);
		writer.WriteUnmanaged<int, int, int, long>(value.ServerId, value.RewardTimes, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref MultiFightInnerCreateRoomRequest? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		PbTeamRoomUserInfo value6;
		int value7;
		int value8;
		int value9;
		long value10;
		string hallAddress;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Difficulty;
				value5 = value.UserId;
				value6 = value.MatchRoomUserInfo;
				hallAddress = value.HallAddress;
				value7 = value.ServerId;
				value8 = value.RewardTimes;
				value9 = value.RpcId;
				value10 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadPackable(ref value6);
				hallAddress = reader.ReadString();
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				goto IL_020a;
			}
			reader.ReadUnmanaged<bool, int, int, long>(out value2, out value3, out value4, out value5);
			value6 = reader.ReadPackable<PbTeamRoomUserInfo>();
			hallAddress = reader.ReadString();
			reader.ReadUnmanaged<int, int, int, long>(out value7, out value8, out value9, out value10);
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(MultiFightInnerCreateRoomRequest), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = null;
				hallAddress = null;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				value10 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.CopyId;
				value4 = value.Difficulty;
				value5 = value.UserId;
				value6 = value.MatchRoomUserInfo;
				hallAddress = value.HallAddress;
				value7 = value.ServerId;
				value8 = value.RewardTimes;
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
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadPackable(ref value6);
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
				goto IL_020a;
			}
		}
		value = new MultiFightInnerCreateRoomRequest
		{
			IsFromPool = value2,
			CopyId = value3,
			Difficulty = value4,
			UserId = value5,
			MatchRoomUserInfo = value6,
			HallAddress = hallAddress,
			ServerId = value7,
			RewardTimes = value8,
			RpcId = value9,
			ActorId = value10
		};
		return;
		IL_020a:
		value.IsFromPool = value2;
		value.CopyId = value3;
		value.Difficulty = value4;
		value.UserId = value5;
		value.MatchRoomUserInfo = value6;
		value.HallAddress = hallAddress;
		value.ServerId = value7;
		value.RewardTimes = value8;
		value.RpcId = value9;
		value.ActorId = value10;
	}
}
