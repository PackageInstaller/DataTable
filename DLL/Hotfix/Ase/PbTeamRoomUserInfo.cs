using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(339)]
[MemoryPackable(GenerateType.Object)]
public class PbTeamRoomUserInfo : MessageObject, IMemoryPackable<PbTeamRoomUserInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbTeamRoomUserInfoFormatter : MemoryPackFormatter<PbTeamRoomUserInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbTeamRoomUserInfo value)
		{
			PbTeamRoomUserInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbTeamRoomUserInfo value)
		{
			PbTeamRoomUserInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int SeatId { get; set; }

	[MemoryPackOrder(3)]
	public int Vit { get; set; }

	[MemoryPackOrder(4)]
	public PbMultiFightUserBase UserBaseInfo { get; set; }

	[MemoryPackOrder(5)]
	public PbRoomRoleInfo RoleInfo { get; set; }

	[MemoryPackOrder(10)]
	public int SelectModel { get; set; }

	[MemoryPackOrder(11)]
	public int CapFlag { get; set; }

	[MemoryPackOrder(13)]
	public int State { get; set; }

	[MemoryPackOrder(14)]
	public int TicketCount { get; set; }

	[MemoryPackOrder(15)]
	public long LastVitRecoverTime { get; set; }

	[MemoryPackOrder(16)]
	public int RewardCount { get; set; }

	[MemoryPackOrder(17)]
	public long UnionId { get; set; }

	[MemoryPackOrder(18)]
	public List<PbRoomBattlePropInfo> BattleProp { get; set; } = new List<PbRoomBattlePropInfo>();

	[MemoryPackOrder(19)]
	public bool IsFirst { get; set; }

	[MemoryPackOrder(20)]
	public int HeroCardFrame { get; set; }

	[MemoryPackOrder(21)]
	public List<int> SelectBattleEmojis { get; set; } = new List<int>();

	public static PbTeamRoomUserInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbTeamRoomUserInfo)) as PbTeamRoomUserInfo;
		}
		return new PbTeamRoomUserInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			SeatId = 0;
			Vit = 0;
			UserBaseInfo = null;
			RoleInfo = null;
			SelectModel = 0;
			CapFlag = 0;
			State = 0;
			TicketCount = 0;
			LastVitRecoverTime = 0L;
			RewardCount = 0;
			UnionId = 0L;
			BattleProp.Clear();
			IsFirst = false;
			HeroCardFrame = 0;
			SelectBattleEmojis.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbTeamRoomUserInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbTeamRoomUserInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbTeamRoomUserInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbTeamRoomUserInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbTeamRoomUserInfo>());
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
	public static void Serialize(ref MemoryPackWriter writer, ref PbTeamRoomUserInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, int>(18, value.IsFromPool, value.UserId, value.SeatId, value.Vit);
		writer.WritePackable<PbMultiFightUserBase>(value.UserBaseInfo);
		writer.WritePackable<PbRoomRoleInfo>(value.RoleInfo);
		writer.WriteUnmanaged<int, int, int, int, long, int, long>(value.SelectModel, value.CapFlag, value.State, value.TicketCount, value.LastVitRecoverTime, value.RewardCount, value.UnionId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRoomBattlePropInfo>>(value.BattleProp));
		writer.WriteUnmanaged<bool, int>(value.IsFirst, value.HeroCardFrame);
		writer.WriteValue<List<int>>(value.SelectBattleEmojis);
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbTeamRoomUserInfo? value)
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
		PbMultiFightUserBase value6;
		PbRoomRoleInfo value7;
		int value8;
		int value9;
		int value10;
		int value11;
		long value12;
		int value13;
		long value14;
		List<PbRoomBattlePropInfo> value15;
		bool value16;
		int value17;
		List<int> value18;
		int value19;
		if (memberCount == 18)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.SeatId;
				value5 = value.Vit;
				value6 = value.UserBaseInfo;
				value7 = value.RoleInfo;
				value8 = value.SelectModel;
				value9 = value.CapFlag;
				value10 = value.State;
				value11 = value.TicketCount;
				value12 = value.LastVitRecoverTime;
				value13 = value.RewardCount;
				value14 = value.UnionId;
				value15 = value.BattleProp;
				value16 = value.IsFirst;
				value17 = value.HeroCardFrame;
				value18 = value.SelectBattleEmojis;
				value19 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadPackable(ref value6);
				reader.ReadPackable(ref value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				reader.ReadUnmanaged<long>(out value12);
				reader.ReadUnmanaged<int>(out value13);
				reader.ReadUnmanaged<long>(out value14);
				ListFormatter.DeserializePackable(ref reader, ref value15);
				reader.ReadUnmanaged<bool>(out value16);
				reader.ReadUnmanaged<int>(out value17);
				reader.ReadValue(ref value18);
				reader.ReadUnmanaged<int>(out value19);
				goto IL_03a4;
			}
			reader.ReadUnmanaged<bool, long, int, int>(out value2, out value3, out value4, out value5);
			value6 = reader.ReadPackable<PbMultiFightUserBase>();
			value7 = reader.ReadPackable<PbRoomRoleInfo>();
			reader.ReadUnmanaged<int, int, int, int, long, int, long>(out value8, out value9, out value10, out value11, out value12, out value13, out value14);
			value15 = ListFormatter.DeserializePackable<PbRoomBattlePropInfo>(ref reader);
			reader.ReadUnmanaged<bool, int>(out value16, out value17);
			value18 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int>(out value19);
		}
		else
		{
			if (memberCount > 18)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbTeamRoomUserInfo), 18, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = null;
				value7 = null;
				value8 = 0;
				value9 = 0;
				value10 = 0;
				value11 = 0;
				value12 = 0L;
				value13 = 0;
				value14 = 0L;
				value15 = null;
				value16 = false;
				value17 = 0;
				value18 = null;
				value19 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.SeatId;
				value5 = value.Vit;
				value6 = value.UserBaseInfo;
				value7 = value.RoleInfo;
				value8 = value.SelectModel;
				value9 = value.CapFlag;
				value10 = value.State;
				value11 = value.TicketCount;
				value12 = value.LastVitRecoverTime;
				value13 = value.RewardCount;
				value14 = value.UnionId;
				value15 = value.BattleProp;
				value16 = value.IsFirst;
				value17 = value.HeroCardFrame;
				value18 = value.SelectBattleEmojis;
				value19 = value.RpcId;
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
								reader.ReadPackable(ref value6);
								if (memberCount != 5)
								{
									reader.ReadPackable(ref value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value11);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<long>(out value12);
														if (memberCount != 11)
														{
															reader.ReadUnmanaged<int>(out value13);
															if (memberCount != 12)
															{
																reader.ReadUnmanaged<long>(out value14);
																if (memberCount != 13)
																{
																	ListFormatter.DeserializePackable(ref reader, ref value15);
																	if (memberCount != 14)
																	{
																		reader.ReadUnmanaged<bool>(out value16);
																		if (memberCount != 15)
																		{
																			reader.ReadUnmanaged<int>(out value17);
																			if (memberCount != 16)
																			{
																				reader.ReadValue(ref value18);
																				if (memberCount != 17)
																				{
																					reader.ReadUnmanaged<int>(out value19);
																					_ = 18;
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
									}
								}
							}
						}
					}
				}
			}
			if (value != null)
			{
				goto IL_03a4;
			}
		}
		value = new PbTeamRoomUserInfo
		{
			IsFromPool = value2,
			UserId = value3,
			SeatId = value4,
			Vit = value5,
			UserBaseInfo = value6,
			RoleInfo = value7,
			SelectModel = value8,
			CapFlag = value9,
			State = value10,
			TicketCount = value11,
			LastVitRecoverTime = value12,
			RewardCount = value13,
			UnionId = value14,
			BattleProp = value15,
			IsFirst = value16,
			HeroCardFrame = value17,
			SelectBattleEmojis = value18,
			RpcId = value19
		};
		return;
		IL_03a4:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.SeatId = value4;
		value.Vit = value5;
		value.UserBaseInfo = value6;
		value.RoleInfo = value7;
		value.SelectModel = value8;
		value.CapFlag = value9;
		value.State = value10;
		value.TicketCount = value11;
		value.LastVitRecoverTime = value12;
		value.RewardCount = value13;
		value.UnionId = value14;
		value.BattleProp = value15;
		value.IsFirst = value16;
		value.HeroCardFrame = value17;
		value.SelectBattleEmojis = value18;
		value.RpcId = value19;
	}
}
