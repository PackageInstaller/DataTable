using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(341)]
[MemoryPackable(GenerateType.Object)]
public class PbMultiFightFriendInfo : MessageObject, IMemoryPackable<PbMultiFightFriendInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbMultiFightFriendInfoFormatter : MemoryPackFormatter<PbMultiFightFriendInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbMultiFightFriendInfo value)
		{
			PbMultiFightFriendInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbMultiFightFriendInfo value)
		{
			PbMultiFightFriendInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public PbFriendItemInfo FrienInfo { get; set; }

	[MemoryPackOrder(2)]
	public int FightState { get; set; }

	public static PbMultiFightFriendInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbMultiFightFriendInfo)) as PbMultiFightFriendInfo;
		}
		return new PbMultiFightFriendInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			FrienInfo = null;
			FightState = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbMultiFightFriendInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbMultiFightFriendInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbMultiFightFriendInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbMultiFightFriendInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbMultiFightFriendInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbMultiFightFriendInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(4, value.IsFromPool, value.UserId);
		writer.WritePackable<PbFriendItemInfo>(value.FrienInfo);
		writer.WriteUnmanaged<int>(value.FightState);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbMultiFightFriendInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		PbFriendItemInfo value4;
		int value5;
		if (memberCount == 4)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.FrienInfo;
				value5 = value.FightState;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				goto IL_00f5;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadPackable<PbFriendItemInfo>();
			reader.ReadUnmanaged<int>(out value5);
		}
		else
		{
			if (memberCount > 4)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbMultiFightFriendInfo), 4, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.FrienInfo;
				value5 = value.FightState;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							_ = 4;
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_00f5;
			}
		}
		value = new PbMultiFightFriendInfo
		{
			IsFromPool = value2,
			UserId = value3,
			FrienInfo = value4,
			FightState = value5
		};
		return;
		IL_00f5:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.FrienInfo = value4;
		value.FightState = value5;
	}
}
