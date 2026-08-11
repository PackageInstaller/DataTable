using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(325)]
[MemoryPackable(GenerateType.Object)]
public class PbCreateBattleUserInfo : MessageObject, IMemoryPackable<PbCreateBattleUserInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbCreateBattleUserInfoFormatter : MemoryPackFormatter<PbCreateBattleUserInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbCreateBattleUserInfo value)
		{
			PbCreateBattleUserInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbCreateBattleUserInfo value)
		{
			PbCreateBattleUserInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int SeatId { get; set; }

	[MemoryPackOrder(2)]
	public bool RobotFlag { get; set; }

	public static PbCreateBattleUserInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbCreateBattleUserInfo)) as PbCreateBattleUserInfo;
		}
		return new PbCreateBattleUserInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			SeatId = 0;
			RobotFlag = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbCreateBattleUserInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbCreateBattleUserInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbCreateBattleUserInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbCreateBattleUserInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbCreateBattleUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbCreateBattleUserInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, bool>(4, value.IsFromPool, value.UserId, value.SeatId, value.RobotFlag);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbCreateBattleUserInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		int value4;
		bool value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.SeatId;
				value5 = value.RobotFlag;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<bool>(out value5);
				goto IL_00ea;
			}
			reader.ReadUnmanaged<bool, long, int, bool>(out value2, out value3, out value4, out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbCreateBattleUserInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = false;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.SeatId;
				value5 = value.RobotFlag;
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
							reader.ReadUnmanaged<bool>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00ea;
			}
		}
		value = new PbCreateBattleUserInfo
		{
			IsFromPool = value2,
			UserId = value3,
			SeatId = value4,
			RobotFlag = value5
		};
		return;
		IL_00ea:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.SeatId = value4;
		value.RobotFlag = value5;
	}
}
