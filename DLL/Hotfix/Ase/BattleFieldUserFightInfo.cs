using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10515)]
[MemoryPackable(GenerateType.Object)]
public class BattleFieldUserFightInfo : MessageObject, IMemoryPackable<BattleFieldUserFightInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class BattleFieldUserFightInfoFormatter : MemoryPackFormatter<BattleFieldUserFightInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref BattleFieldUserFightInfo value)
		{
			BattleFieldUserFightInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref BattleFieldUserFightInfo value)
		{
			BattleFieldUserFightInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public List<PbBattleFiledUserInfo> Users { get; set; } = new List<PbBattleFiledUserInfo>();

	[MemoryPackOrder(1)]
	public long CheckCode { get; set; }

	[MemoryPackOrder(2)]
	public int Seed { get; set; }

	[MemoryPackOrder(3)]
	public long RoomId { get; set; }

	[MemoryPackOrder(4)]
	public int CopyId { get; set; }

	[MemoryPackOrder(5)]
	public int Difficult { get; set; }

	public static BattleFieldUserFightInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(BattleFieldUserFightInfo)) as BattleFieldUserFightInfo;
		}
		return new BattleFieldUserFightInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Users.Clear();
			CheckCode = 0L;
			Seed = 0;
			RoomId = 0L;
			CopyId = 0;
			Difficult = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static BattleFieldUserFightInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<BattleFieldUserFightInfo>())
		{
			MemoryPackFormatterProvider.Register(new BattleFieldUserFightInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<BattleFieldUserFightInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<BattleFieldUserFightInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbBattleFiledUserInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbBattleFiledUserInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref BattleFieldUserFightInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(7, value.IsFromPool);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbBattleFiledUserInfo>>(value.Users));
		writer.WriteUnmanaged<long, int, long, int, int>(value.CheckCode, value.Seed, value.RoomId, value.CopyId, value.Difficult);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref BattleFieldUserFightInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbBattleFiledUserInfo> value3;
		long value4;
		int value5;
		long value6;
		int value7;
		int value8;
		if (memberCount == 7)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Users;
				value4 = value.CheckCode;
				value5 = value.Seed;
				value6 = value.RoomId;
				value7 = value.CopyId;
				value8 = value.Difficult;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				reader.ReadUnmanaged<long>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				goto IL_017d;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbBattleFiledUserInfo>(ref reader);
			reader.ReadUnmanaged<long, int, long, int, int>(out value4, out value5, out value6, out value7, out value8);
		}
		else
		{
			if (memberCount > 7)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(BattleFieldUserFightInfo), 7, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0L;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Users;
				value4 = value.CheckCode;
				value5 = value.Seed;
				value6 = value.RoomId;
				value7 = value.CopyId;
				value8 = value.Difficult;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<long>(out value4);
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
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
		value = new BattleFieldUserFightInfo
		{
			IsFromPool = value2,
			Users = value3,
			CheckCode = value4,
			Seed = value5,
			RoomId = value6,
			CopyId = value7,
			Difficult = value8
		};
		return;
		IL_017d:
		value.IsFromPool = value2;
		value.Users = value3;
		value.CheckCode = value4;
		value.Seed = value5;
		value.RoomId = value6;
		value.CopyId = value7;
		value.Difficult = value8;
	}
}
