using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(327)]
[MemoryPackable(GenerateType.Object)]
public class PbBattleFiledUserInfo : MessageObject, IMemoryPackable<PbBattleFiledUserInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbBattleFiledUserInfoFormatter : MemoryPackFormatter<PbBattleFiledUserInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbBattleFiledUserInfo value)
		{
			PbBattleFiledUserInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbBattleFiledUserInfo value)
		{
			PbBattleFiledUserInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public PbMultiFightUserBase UserBaseInfo { get; set; }

	[MemoryPackOrder(3)]
	public int SeatId { get; set; }

	[MemoryPackOrder(4)]
	public PbRoomRoleInfo Role { get; set; }

	[MemoryPackOrder(6)]
	public int SelectModel { get; set; }

	[MemoryPackOrder(7)]
	public List<PbRoomBattlePropInfo> BattleProp { get; set; } = new List<PbRoomBattlePropInfo>();

	[MemoryPackOrder(8)]
	public long UnionId { get; set; }

	[MemoryPackOrder(9)]
	public bool IsRobot { get; set; }

	[MemoryPackOrder(10)]
	public int HeroCardFrame { get; set; }

	[MemoryPackOrder(11)]
	public List<int> SelectBattleEmoji { get; set; } = new List<int>();

	public static PbBattleFiledUserInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbBattleFiledUserInfo)) as PbBattleFiledUserInfo;
		}
		return new PbBattleFiledUserInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			UserBaseInfo = null;
			SeatId = 0;
			Role = null;
			SelectModel = 0;
			BattleProp.Clear();
			UnionId = 0L;
			IsRobot = false;
			HeroCardFrame = 0;
			SelectBattleEmoji.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbBattleFiledUserInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbBattleFiledUserInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbBattleFiledUserInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbBattleFiledUserInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbBattleFiledUserInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRoomBattlePropInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRoomBattlePropInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbBattleFiledUserInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(11, value.IsFromPool, value.UserId);
		writer.WritePackable<PbMultiFightUserBase>(value.UserBaseInfo);
		writer.WriteUnmanaged<int>(value.SeatId);
		writer.WritePackable<PbRoomRoleInfo>(value.Role);
		writer.WriteUnmanaged<int>(value.SelectModel);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRoomBattlePropInfo>>(value.BattleProp));
		writer.WriteUnmanaged<long, bool, int>(value.UnionId, value.IsRobot, value.HeroCardFrame);
		writer.WriteValue<List<int>>(value.SelectBattleEmoji);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbBattleFiledUserInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		long value3;
		PbMultiFightUserBase value4;
		int value5;
		PbRoomRoleInfo value6;
		int value7;
		List<PbRoomBattlePropInfo> value8;
		long value9;
		bool value10;
		int value11;
		List<int> value12;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UserBaseInfo;
				value5 = value.SeatId;
				value6 = value.Role;
				value7 = value.SelectModel;
				value8 = value.BattleProp;
				value9 = value.UnionId;
				value10 = value.IsRobot;
				value11 = value.HeroCardFrame;
				value12 = value.SelectBattleEmoji;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadPackable(ref value6);
				reader.ReadUnmanaged<int>(out value7);
				ListFormatter.DeserializePackable(ref reader, ref value8);
				reader.ReadUnmanaged<long>(out value9);
				reader.ReadUnmanaged<bool>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				reader.ReadValue(ref value12);
				goto IL_0250;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			value4 = reader.ReadPackable<PbMultiFightUserBase>();
			reader.ReadUnmanaged<int>(out value5);
			value6 = reader.ReadPackable<PbRoomRoleInfo>();
			reader.ReadUnmanaged<int>(out value7);
			value8 = ListFormatter.DeserializePackable<PbRoomBattlePropInfo>(ref reader);
			reader.ReadUnmanaged<long, bool, int>(out value9, out value10, out value11);
			value12 = reader.ReadValue<List<int>>();
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbBattleFiledUserInfo), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = null;
				value5 = 0;
				value6 = null;
				value7 = 0;
				value8 = null;
				value9 = 0L;
				value10 = false;
				value11 = 0;
				value12 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.UserBaseInfo;
				value5 = value.SeatId;
				value6 = value.Role;
				value7 = value.SelectModel;
				value8 = value.BattleProp;
				value9 = value.UnionId;
				value10 = value.IsRobot;
				value11 = value.HeroCardFrame;
				value12 = value.SelectBattleEmoji;
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
							if (memberCount != 4)
							{
								reader.ReadPackable(ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										ListFormatter.DeserializePackable(ref reader, ref value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<bool>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value11);
													if (memberCount != 10)
													{
														reader.ReadValue(ref value12);
														_ = 11;
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
			}
			if (value != null)
			{
				goto IL_0250;
			}
		}
		value = new PbBattleFiledUserInfo
		{
			IsFromPool = value2,
			UserId = value3,
			UserBaseInfo = value4,
			SeatId = value5,
			Role = value6,
			SelectModel = value7,
			BattleProp = value8,
			UnionId = value9,
			IsRobot = value10,
			HeroCardFrame = value11,
			SelectBattleEmoji = value12
		};
		return;
		IL_0250:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.UserBaseInfo = value4;
		value.SeatId = value5;
		value.Role = value6;
		value.SelectModel = value7;
		value.BattleProp = value8;
		value.UnionId = value9;
		value.IsRobot = value10;
		value.HeroCardFrame = value11;
		value.SelectBattleEmoji = value12;
	}
}
