using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10296)]
[MemoryPackable(GenerateType.Object)]
public class M2H_InnerSendCopySettleInfoRequest : MessageObject, IRequest, IMessage, IMemoryPackable<M2H_InnerSendCopySettleInfoRequest>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class M2H_InnerSendCopySettleInfoRequestFormatter : MemoryPackFormatter<M2H_InnerSendCopySettleInfoRequest>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref M2H_InnerSendCopySettleInfoRequest value)
		{
			M2H_InnerSendCopySettleInfoRequest.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref M2H_InnerSendCopySettleInfoRequest value)
		{
			M2H_InnerSendCopySettleInfoRequest.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int Star { get; set; }

	[MemoryPackOrder(2)]
	public int RoleId { get; set; }

	[MemoryPackOrder(3)]
	public long FightStartTime { get; set; }

	[MemoryPackOrder(4)]
	public int CopyId { get; set; }

	[MemoryPackOrder(5)]
	public int Difficult { get; set; }

	[MemoryPackOrder(6)]
	public long RoomId { get; set; }

	[MemoryPackOrder(7)]
	public List<PbCopyTeamInfo> TeamUserInfos { get; set; } = new List<PbCopyTeamInfo>();

	[MemoryPackOrder(8)]
	public int SelectModel { get; set; }

	[MemoryPackOrder(9)]
	public float BossHPLeft { get; set; }

	[MemoryPackOrder(10)]
	public int PassTime { get; set; }

	[MemoryPackOrder(11)]
	public bool LeaveHalfway { get; set; }

	[MemoryPackOrder(12)]
	public int DropType { get; set; }

	[MemoryPackOrder(13)]
	public int RewardCount { get; set; }

	[MemoryPackOrder(14)]
	public int Score { get; set; }

	[MemoryPackOrder(15)]
	public int ClientStarInfo { get; set; }

	[MemoryPackOrder(16)]
	public int RewardTimes { get; set; }

	[MemoryPackOrder(17)]
	public PbCopyBattleInfo CopyBattleInfo { get; set; }

	[MemoryPackOrder(18)]
	public long OwnerPlayerId { get; set; }

	public static M2H_InnerSendCopySettleInfoRequest Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(M2H_InnerSendCopySettleInfoRequest)) as M2H_InnerSendCopySettleInfoRequest;
		}
		return new M2H_InnerSendCopySettleInfoRequest();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			UserId = 0L;
			Star = 0;
			RoleId = 0;
			FightStartTime = 0L;
			CopyId = 0;
			Difficult = 0;
			RoomId = 0L;
			TeamUserInfos.Clear();
			SelectModel = 0;
			BossHPLeft = 0f;
			PassTime = 0;
			LeaveHalfway = false;
			DropType = 0;
			RewardCount = 0;
			Score = 0;
			ClientStarInfo = 0;
			RewardTimes = 0;
			CopyBattleInfo = null;
			OwnerPlayerId = 0L;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static M2H_InnerSendCopySettleInfoRequest()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<M2H_InnerSendCopySettleInfoRequest>())
		{
			MemoryPackFormatterProvider.Register(new M2H_InnerSendCopySettleInfoRequestFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<M2H_InnerSendCopySettleInfoRequest[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<M2H_InnerSendCopySettleInfoRequest>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCopyTeamInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCopyTeamInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref M2H_InnerSendCopySettleInfoRequest? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, long, int, int, long>(21, value.IsFromPool, value.UserId, value.Star, value.RoleId, value.FightStartTime, value.CopyId, value.Difficult, value.RoomId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCopyTeamInfo>>(value.TeamUserInfos));
		writer.WriteUnmanaged<int, float, int, bool, int, int, int, int, int>(value.SelectModel, value.BossHPLeft, value.PassTime, value.LeaveHalfway, value.DropType, value.RewardCount, value.Score, value.ClientStarInfo, value.RewardTimes);
		writer.WritePackable<PbCopyBattleInfo>(value.CopyBattleInfo);
		writer.WriteUnmanaged<long, int>(value.OwnerPlayerId, value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref M2H_InnerSendCopySettleInfoRequest? value)
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
		long value6;
		int value7;
		int value8;
		long value9;
		List<PbCopyTeamInfo> value10;
		int value11;
		float value12;
		int value13;
		bool value14;
		int value15;
		int value16;
		int value17;
		int value18;
		int value19;
		PbCopyBattleInfo value20;
		long value21;
		int value22;
		if (memberCount == 21)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Star;
				value5 = value.RoleId;
				value6 = value.FightStartTime;
				value7 = value.CopyId;
				value8 = value.Difficult;
				value9 = value.RoomId;
				value10 = value.TeamUserInfos;
				value11 = value.SelectModel;
				value12 = value.BossHPLeft;
				value13 = value.PassTime;
				value14 = value.LeaveHalfway;
				value15 = value.DropType;
				value16 = value.RewardCount;
				value17 = value.Score;
				value18 = value.ClientStarInfo;
				value19 = value.RewardTimes;
				value20 = value.CopyBattleInfo;
				value21 = value.OwnerPlayerId;
				value22 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				ListFormatter.DeserializePackable(ref reader, ref value10);
				reader.ReadUnmanaged<int>(out value11);
				reader.ReadUnmanaged<float>(out value12);
				reader.ReadUnmanaged<int>(out value13);
				reader.ReadUnmanaged<bool>(out value14);
				reader.ReadUnmanaged<int>(out value15);
				reader.ReadUnmanaged<int>(out value16);
				reader.ReadUnmanaged<int>(out value17);
				reader.ReadUnmanaged<int>(out value18);
				reader.ReadUnmanaged<int>(out value19);
				reader.ReadPackable(ref value20);
				reader.ReadUnmanaged<long>(out value21);
				reader.ReadUnmanaged<int>(out value22);
				goto IL_0424;
			}
			reader.ReadUnmanaged<bool, long, int, int, long, int, int, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9);
			value10 = ListFormatter.DeserializePackable<PbCopyTeamInfo>(ref reader);
			reader.ReadUnmanaged<int, float, int, bool, int, int, int, int, int>(out value11, out value12, out value13, out value14, out value15, out value16, out value17, out value18, out value19);
			value20 = reader.ReadPackable<PbCopyBattleInfo>();
			reader.ReadUnmanaged<long, int>(out value21, out value22);
		}
		else
		{
			if (memberCount > 21)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(M2H_InnerSendCopySettleInfoRequest), 21, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
				value7 = 0;
				value8 = 0;
				value9 = 0L;
				value10 = null;
				value11 = 0;
				value12 = 0f;
				value13 = 0;
				value14 = false;
				value15 = 0;
				value16 = 0;
				value17 = 0;
				value18 = 0;
				value19 = 0;
				value20 = null;
				value21 = 0L;
				value22 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.Star;
				value5 = value.RoleId;
				value6 = value.FightStartTime;
				value7 = value.CopyId;
				value8 = value.Difficult;
				value9 = value.RoomId;
				value10 = value.TeamUserInfos;
				value11 = value.SelectModel;
				value12 = value.BossHPLeft;
				value13 = value.PassTime;
				value14 = value.LeaveHalfway;
				value15 = value.DropType;
				value16 = value.RewardCount;
				value17 = value.Score;
				value18 = value.ClientStarInfo;
				value19 = value.RewardTimes;
				value20 = value.CopyBattleInfo;
				value21 = value.OwnerPlayerId;
				value22 = value.RpcId;
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
								reader.ReadUnmanaged<long>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value9);
											if (memberCount != 8)
											{
												ListFormatter.DeserializePackable(ref reader, ref value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value11);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<float>(out value12);
														if (memberCount != 11)
														{
															reader.ReadUnmanaged<int>(out value13);
															if (memberCount != 12)
															{
																reader.ReadUnmanaged<bool>(out value14);
																if (memberCount != 13)
																{
																	reader.ReadUnmanaged<int>(out value15);
																	if (memberCount != 14)
																	{
																		reader.ReadUnmanaged<int>(out value16);
																		if (memberCount != 15)
																		{
																			reader.ReadUnmanaged<int>(out value17);
																			if (memberCount != 16)
																			{
																				reader.ReadUnmanaged<int>(out value18);
																				if (memberCount != 17)
																				{
																					reader.ReadUnmanaged<int>(out value19);
																					if (memberCount != 18)
																					{
																						reader.ReadPackable(ref value20);
																						if (memberCount != 19)
																						{
																							reader.ReadUnmanaged<long>(out value21);
																							if (memberCount != 20)
																							{
																								reader.ReadUnmanaged<int>(out value22);
																								_ = 21;
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
					}
				}
			}
			if (value != null)
			{
				goto IL_0424;
			}
		}
		value = new M2H_InnerSendCopySettleInfoRequest
		{
			IsFromPool = value2,
			UserId = value3,
			Star = value4,
			RoleId = value5,
			FightStartTime = value6,
			CopyId = value7,
			Difficult = value8,
			RoomId = value9,
			TeamUserInfos = value10,
			SelectModel = value11,
			BossHPLeft = value12,
			PassTime = value13,
			LeaveHalfway = value14,
			DropType = value15,
			RewardCount = value16,
			Score = value17,
			ClientStarInfo = value18,
			RewardTimes = value19,
			CopyBattleInfo = value20,
			OwnerPlayerId = value21,
			RpcId = value22
		};
		return;
		IL_0424:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Star = value4;
		value.RoleId = value5;
		value.FightStartTime = value6;
		value.CopyId = value7;
		value.Difficult = value8;
		value.RoomId = value9;
		value.TeamUserInfos = value10;
		value.SelectModel = value11;
		value.BossHPLeft = value12;
		value.PassTime = value13;
		value.LeaveHalfway = value14;
		value.DropType = value15;
		value.RewardCount = value16;
		value.Score = value17;
		value.ClientStarInfo = value18;
		value.RewardTimes = value19;
		value.CopyBattleInfo = value20;
		value.OwnerPlayerId = value21;
		value.RpcId = value22;
	}
}
