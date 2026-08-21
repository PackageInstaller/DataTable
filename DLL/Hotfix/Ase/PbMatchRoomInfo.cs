using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(340)]
[MemoryPackable(GenerateType.Object)]
public class PbMatchRoomInfo : MessageObject, IMemoryPackable<PbMatchRoomInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbMatchRoomInfoFormatter : MemoryPackFormatter<PbMatchRoomInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbMatchRoomInfo value)
		{
			PbMatchRoomInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbMatchRoomInfo value)
		{
			PbMatchRoomInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long RoomId { get; set; }

	[MemoryPackOrder(1)]
	public int CopyId { get; set; }

	[MemoryPackOrder(4)]
	public int Difficulty { get; set; }

	[MemoryPackOrder(3)]
	public int RewardTimes { get; set; }

	[MemoryPackOrder(7)]
	public List<PbTeamRoomUserInfo> Gamers { get; set; } = new List<PbTeamRoomUserInfo>();

	public static PbMatchRoomInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbMatchRoomInfo)) as PbMatchRoomInfo;
		}
		return new PbMatchRoomInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			RoomId = 0L;
			CopyId = 0;
			Difficulty = 0;
			RewardTimes = 0;
			Gamers.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbMatchRoomInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbMatchRoomInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbMatchRoomInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbMatchRoomInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbMatchRoomInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbTeamRoomUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbTeamRoomUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbMatchRoomInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, int>(7, value.IsFromPool, value.RoomId, value.CopyId, value.RewardTimes, value.Difficulty);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbTeamRoomUserInfo>>(value.Gamers));
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbMatchRoomInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		int value5;
		int value6;
		List<PbTeamRoomUserInfo> value7;
		int value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.CopyId;
				value5 = value.RewardTimes;
				value6 = value.Difficulty;
				value7 = value.Gamers;
				value8 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				reader.ReadUnmanaged<int>(out value8);
				goto IL_017d;
			}
			reader.ReadUnmanaged<bool, long, int, int, int>(out value2, out value3, out value4, out value5, out value6);
			value7 = ListFormatter.DeserializePackable<PbTeamRoomUserInfo>(ref reader);
			reader.ReadUnmanaged<int>(out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbMatchRoomInfo), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = null;
				value8 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoomId;
				value4 = value.CopyId;
				value5 = value.RewardTimes;
				value6 = value.Difficulty;
				value7 = value.Gamers;
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
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									ListFormatter.DeserializePackable(ref reader, ref value7);
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
				goto IL_017d;
			}
		}
		value = new PbMatchRoomInfo
		{
			IsFromPool = value2,
			RoomId = value3,
			CopyId = value4,
			RewardTimes = value5,
			Difficulty = value6,
			Gamers = value7,
			RpcId = value8
		};
		return;
		IL_017d:
		value.IsFromPool = value2;
		value.RoomId = value3;
		value.CopyId = value4;
		value.RewardTimes = value5;
		value.Difficulty = value6;
		value.Gamers = value7;
		value.RpcId = value8;
	}
}
