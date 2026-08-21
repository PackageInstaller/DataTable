using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10297)]
[MemoryPackable(GenerateType.Object)]
public class S2C_MultiFightSettleNotify : MessageObject, IActorMessage, INotification, IMessage, IMemoryPackable<S2C_MultiFightSettleNotify>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_MultiFightSettleNotifyFormatter : MemoryPackFormatter<S2C_MultiFightSettleNotify>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_MultiFightSettleNotify value)
		{
			S2C_MultiFightSettleNotify.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_MultiFightSettleNotify value)
		{
			S2C_MultiFightSettleNotify.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public long ActorId { get; set; }

	[MemoryPackOrder(0)]
	public int Star { get; set; }

	[MemoryPackOrder(2)]
	public PbDropThing PassRewards { get; set; }

	[MemoryPackOrder(3)]
	public PbDropThing StarRewards { get; set; }

	[MemoryPackOrder(4)]
	public PbNormalRoleInfo Role { get; set; }

	[MemoryPackOrder(5)]
	public int AccountLevel { get; set; }

	[MemoryPackOrder(6)]
	public long AccountExp { get; set; }

	[MemoryPackOrder(7)]
	public int AccountExpDelta { get; set; }

	[MemoryPackOrder(8)]
	public int AccountEnergy { get; set; }

	[MemoryPackOrder(9)]
	public List<PbCopyTeamInfo> TeamInfos { get; set; } = new List<PbCopyTeamInfo>();

	[MemoryPackOrder(10)]
	public bool IsWin { get; set; }

	[MemoryPackOrder(11)]
	public PbItemChange CostGoods { get; set; }

	[MemoryPackOrder(12)]
	public long LastVitRecoverTime { get; set; }

	[MemoryPackOrder(13)]
	public int PassTime { get; set; }

	[MemoryPackOrder(14)]
	public int Score { get; set; }

	[MemoryPackOrder(15)]
	public PbDropThing ExtraRewards { get; set; }

	[MemoryPackOrder(16)]
	public bool RewardInPackage { get; set; }

	[MemoryPackOrder(17)]
	public int SuitboxCopyRewardCount { get; set; }

	[MemoryPackOrder(18)]
	public int LastMaxScore { get; set; }

	public static S2C_MultiFightSettleNotify Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_MultiFightSettleNotify)) as S2C_MultiFightSettleNotify;
		}
		return new S2C_MultiFightSettleNotify();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			ActorId = 0L;
			Star = 0;
			PassRewards = null;
			StarRewards = null;
			Role = null;
			AccountLevel = 0;
			AccountExp = 0L;
			AccountExpDelta = 0;
			AccountEnergy = 0;
			TeamInfos.Clear();
			IsWin = false;
			CostGoods = null;
			LastVitRecoverTime = 0L;
			PassTime = 0;
			Score = 0;
			ExtraRewards = null;
			RewardInPackage = false;
			SuitboxCopyRewardCount = 0;
			LastMaxScore = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_MultiFightSettleNotify()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_MultiFightSettleNotify>())
		{
			MemoryPackFormatterProvider.Register(new S2C_MultiFightSettleNotifyFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_MultiFightSettleNotify[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_MultiFightSettleNotify>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCopyTeamInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCopyTeamInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_MultiFightSettleNotify? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int>(21, value.IsFromPool, value.Star);
		writer.WritePackable<PbDropThing>(value.PassRewards);
		writer.WritePackable<PbDropThing>(value.StarRewards);
		writer.WritePackable<PbNormalRoleInfo>(value.Role);
		writer.WriteUnmanaged<int, long, int, int>(value.AccountLevel, value.AccountExp, value.AccountExpDelta, value.AccountEnergy);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCopyTeamInfo>>(value.TeamInfos));
		writer.WriteUnmanaged<bool>(value.IsWin);
		writer.WritePackable<PbItemChange>(value.CostGoods);
		writer.WriteUnmanaged<long, int, int>(value.LastVitRecoverTime, value.PassTime, value.Score);
		writer.WritePackable<PbDropThing>(value.ExtraRewards);
		writer.WriteUnmanaged<bool, int, int, int, long>(value.RewardInPackage, value.SuitboxCopyRewardCount, value.LastMaxScore, value.RpcId, value.ActorId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_MultiFightSettleNotify? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		PbDropThing value4;
		PbDropThing value5;
		PbNormalRoleInfo value6;
		int value7;
		long value8;
		int value9;
		int value10;
		List<PbCopyTeamInfo> value11;
		bool value12;
		PbItemChange value13;
		long value14;
		int value15;
		int value16;
		PbDropThing value17;
		bool value18;
		int value19;
		int value20;
		int value21;
		long value22;
		if (memberCount == 21)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Star;
				value4 = value.PassRewards;
				value5 = value.StarRewards;
				value6 = value.Role;
				value7 = value.AccountLevel;
				value8 = value.AccountExp;
				value9 = value.AccountExpDelta;
				value10 = value.AccountEnergy;
				value11 = value.TeamInfos;
				value12 = value.IsWin;
				value13 = value.CostGoods;
				value14 = value.LastVitRecoverTime;
				value15 = value.PassTime;
				value16 = value.Score;
				value17 = value.ExtraRewards;
				value18 = value.RewardInPackage;
				value19 = value.SuitboxCopyRewardCount;
				value20 = value.LastMaxScore;
				value21 = value.RpcId;
				value22 = value.ActorId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadPackable(ref value4);
				reader.ReadPackable(ref value5);
				reader.ReadPackable(ref value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<long>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				ListFormatter.DeserializePackable(ref reader, ref value11);
				reader.ReadUnmanaged<bool>(out value12);
				reader.ReadPackable(ref value13);
				reader.ReadUnmanaged<long>(out value14);
				reader.ReadUnmanaged<int>(out value15);
				reader.ReadUnmanaged<int>(out value16);
				reader.ReadPackable(ref value17);
				reader.ReadUnmanaged<bool>(out value18);
				reader.ReadUnmanaged<int>(out value19);
				reader.ReadUnmanaged<int>(out value20);
				reader.ReadUnmanaged<int>(out value21);
				reader.ReadUnmanaged<long>(out value22);
				goto IL_0442;
			}
			reader.ReadUnmanaged<bool, int>(out value2, out value3);
			value4 = reader.ReadPackable<PbDropThing>();
			value5 = reader.ReadPackable<PbDropThing>();
			value6 = reader.ReadPackable<PbNormalRoleInfo>();
			reader.ReadUnmanaged<int, long, int, int>(out value7, out value8, out value9, out value10);
			value11 = ListFormatter.DeserializePackable<PbCopyTeamInfo>(ref reader);
			reader.ReadUnmanaged<bool>(out value12);
			value13 = reader.ReadPackable<PbItemChange>();
			reader.ReadUnmanaged<long, int, int>(out value14, out value15, out value16);
			value17 = reader.ReadPackable<PbDropThing>();
			reader.ReadUnmanaged<bool, int, int, int, long>(out value18, out value19, out value20, out value21, out value22);
		}
		else
		{
			if (memberCount > 21)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_MultiFightSettleNotify), 21, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = null;
				value5 = null;
				value6 = null;
				value7 = 0;
				value8 = 0L;
				value9 = 0;
				value10 = 0;
				value11 = null;
				value12 = false;
				value13 = null;
				value14 = 0L;
				value15 = 0;
				value16 = 0;
				value17 = null;
				value18 = false;
				value19 = 0;
				value20 = 0;
				value21 = 0;
				value22 = 0L;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Star;
				value4 = value.PassRewards;
				value5 = value.StarRewards;
				value6 = value.Role;
				value7 = value.AccountLevel;
				value8 = value.AccountExp;
				value9 = value.AccountExpDelta;
				value10 = value.AccountEnergy;
				value11 = value.TeamInfos;
				value12 = value.IsWin;
				value13 = value.CostGoods;
				value14 = value.LastVitRecoverTime;
				value15 = value.PassTime;
				value16 = value.Score;
				value17 = value.ExtraRewards;
				value18 = value.RewardInPackage;
				value19 = value.SuitboxCopyRewardCount;
				value20 = value.LastMaxScore;
				value21 = value.RpcId;
				value22 = value.ActorId;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
					if (memberCount != 2)
					{
						reader.ReadPackable(ref value4);
						if (memberCount != 3)
						{
							reader.ReadPackable(ref value5);
							if (memberCount != 4)
							{
								reader.ReadPackable(ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													ListFormatter.DeserializePackable(ref reader, ref value11);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<bool>(out value12);
														if (memberCount != 11)
														{
															reader.ReadPackable(ref value13);
															if (memberCount != 12)
															{
																reader.ReadUnmanaged<long>(out value14);
																if (memberCount != 13)
																{
																	reader.ReadUnmanaged<int>(out value15);
																	if (memberCount != 14)
																	{
																		reader.ReadUnmanaged<int>(out value16);
																		if (memberCount != 15)
																		{
																			reader.ReadPackable(ref value17);
																			if (memberCount != 16)
																			{
																				reader.ReadUnmanaged<bool>(out value18);
																				if (memberCount != 17)
																				{
																					reader.ReadUnmanaged<int>(out value19);
																					if (memberCount != 18)
																					{
																						reader.ReadUnmanaged<int>(out value20);
																						if (memberCount != 19)
																						{
																							reader.ReadUnmanaged<int>(out value21);
																							if (memberCount != 20)
																							{
																								reader.ReadUnmanaged<long>(out value22);
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
				goto IL_0442;
			}
		}
		value = new S2C_MultiFightSettleNotify
		{
			IsFromPool = value2,
			Star = value3,
			PassRewards = value4,
			StarRewards = value5,
			Role = value6,
			AccountLevel = value7,
			AccountExp = value8,
			AccountExpDelta = value9,
			AccountEnergy = value10,
			TeamInfos = value11,
			IsWin = value12,
			CostGoods = value13,
			LastVitRecoverTime = value14,
			PassTime = value15,
			Score = value16,
			ExtraRewards = value17,
			RewardInPackage = value18,
			SuitboxCopyRewardCount = value19,
			LastMaxScore = value20,
			RpcId = value21,
			ActorId = value22
		};
		return;
		IL_0442:
		value.IsFromPool = value2;
		value.Star = value3;
		value.PassRewards = value4;
		value.StarRewards = value5;
		value.Role = value6;
		value.AccountLevel = value7;
		value.AccountExp = value8;
		value.AccountExpDelta = value9;
		value.AccountEnergy = value10;
		value.TeamInfos = value11;
		value.IsWin = value12;
		value.CostGoods = value13;
		value.LastVitRecoverTime = value14;
		value.PassTime = value15;
		value.Score = value16;
		value.ExtraRewards = value17;
		value.RewardInPackage = value18;
		value.SuitboxCopyRewardCount = value19;
		value.LastMaxScore = value20;
		value.RpcId = value21;
		value.ActorId = value22;
	}
}
