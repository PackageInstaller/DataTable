using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10087)]
[MemoryPackable(GenerateType.Object)]
public class S2C_GameInstanceSettleResponse : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<S2C_GameInstanceSettleResponse>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class S2C_GameInstanceSettleResponseFormatter : MemoryPackFormatter<S2C_GameInstanceSettleResponse>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref S2C_GameInstanceSettleResponse value)
		{
			S2C_GameInstanceSettleResponse.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref S2C_GameInstanceSettleResponse value)
		{
			S2C_GameInstanceSettleResponse.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(2)]
	public PbDropThing PassRewards { get; set; }

	[MemoryPackOrder(3)]
	public int Star { get; set; }

	[MemoryPackOrder(4)]
	public List<PbNormalRoleInfo> Roles { get; set; } = new List<PbNormalRoleInfo>();

	[MemoryPackOrder(5)]
	public int AccountLevel { get; set; }

	[MemoryPackOrder(6)]
	public long AccountExp { get; set; }

	[MemoryPackOrder(7)]
	public int AccountExpDelta { get; set; }

	[MemoryPackOrder(8)]
	public int AccountEnergy { get; set; }

	[MemoryPackOrder(9)]
	public long LastVitRecoverTime { get; set; }

	[MemoryPackOrder(10)]
	public bool IsWin { get; set; }

	[MemoryPackOrder(11)]
	public PbItemChange CostGoods { get; set; }

	[MemoryPackOrder(12)]
	public int RaceCopyScore { get; set; }

	[MemoryPackOrder(13)]
	public PbDropThing FirstStarRewards { get; set; }

	[MemoryPackOrder(14)]
	public bool RewardInPackage { get; set; }

	[MemoryPackOrder(15)]
	public int SuitboxCopyRewardCount { get; set; }

	[MemoryPackOrder(16)]
	public int LastMaxScore { get; set; }

	public static S2C_GameInstanceSettleResponse Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(S2C_GameInstanceSettleResponse)) as S2C_GameInstanceSettleResponse;
		}
		return new S2C_GameInstanceSettleResponse();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			PassRewards = null;
			Star = 0;
			Roles.Clear();
			AccountLevel = 0;
			AccountExp = 0L;
			AccountExpDelta = 0;
			AccountEnergy = 0;
			LastVitRecoverTime = 0L;
			IsWin = false;
			CostGoods = null;
			RaceCopyScore = 0;
			FirstStarRewards = null;
			RewardInPackage = false;
			SuitboxCopyRewardCount = 0;
			LastMaxScore = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static S2C_GameInstanceSettleResponse()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_GameInstanceSettleResponse>())
		{
			MemoryPackFormatterProvider.Register(new S2C_GameInstanceSettleResponseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<S2C_GameInstanceSettleResponse[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<S2C_GameInstanceSettleResponse>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbNormalRoleInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbNormalRoleInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref S2C_GameInstanceSettleResponse? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(19, value.IsFromPool);
		writer.WritePackable<PbDropThing>(value.PassRewards);
		writer.WriteUnmanaged<int>(value.Star);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbNormalRoleInfo>>(value.Roles));
		writer.WriteUnmanaged<int, long, int, int, long, bool>(value.AccountLevel, value.AccountExp, value.AccountExpDelta, value.AccountEnergy, value.LastVitRecoverTime, value.IsWin);
		writer.WritePackable<PbItemChange>(value.CostGoods);
		writer.WriteUnmanaged<int>(value.RaceCopyScore);
		writer.WritePackable<PbDropThing>(value.FirstStarRewards);
		writer.WriteUnmanaged<bool, int, int, int, int>(value.RewardInPackage, value.SuitboxCopyRewardCount, value.LastMaxScore, value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref S2C_GameInstanceSettleResponse? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		PbDropThing value3;
		int value4;
		List<PbNormalRoleInfo> value5;
		int value6;
		long value7;
		int value8;
		int value9;
		long value10;
		bool value11;
		PbItemChange value12;
		int value13;
		PbDropThing value14;
		bool value15;
		int value16;
		int value17;
		int value18;
		int value19;
		string message;
		if (memberCount == 19)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.PassRewards;
				value4 = value.Star;
				value5 = value.Roles;
				value6 = value.AccountLevel;
				value7 = value.AccountExp;
				value8 = value.AccountExpDelta;
				value9 = value.AccountEnergy;
				value10 = value.LastVitRecoverTime;
				value11 = value.IsWin;
				value12 = value.CostGoods;
				value13 = value.RaceCopyScore;
				value14 = value.FirstStarRewards;
				value15 = value.RewardInPackage;
				value16 = value.SuitboxCopyRewardCount;
				value17 = value.LastMaxScore;
				value18 = value.RpcId;
				value19 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadPackable(ref value3);
				reader.ReadUnmanaged<int>(out value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				reader.ReadUnmanaged<bool>(out value11);
				reader.ReadPackable(ref value12);
				reader.ReadUnmanaged<int>(out value13);
				reader.ReadPackable(ref value14);
				reader.ReadUnmanaged<bool>(out value15);
				reader.ReadUnmanaged<int>(out value16);
				reader.ReadUnmanaged<int>(out value17);
				reader.ReadUnmanaged<int>(out value18);
				reader.ReadUnmanaged<int>(out value19);
				message = reader.ReadString();
				goto IL_03dd;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = reader.ReadPackable<PbDropThing>();
			reader.ReadUnmanaged<int>(out value4);
			value5 = ListFormatter.DeserializePackable<PbNormalRoleInfo>(ref reader);
			reader.ReadUnmanaged<int, long, int, int, long, bool>(out value6, out value7, out value8, out value9, out value10, out value11);
			value12 = reader.ReadPackable<PbItemChange>();
			reader.ReadUnmanaged<int>(out value13);
			value14 = reader.ReadPackable<PbDropThing>();
			reader.ReadUnmanaged<bool, int, int, int, int>(out value15, out value16, out value17, out value18, out value19);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 19)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(S2C_GameInstanceSettleResponse), 19, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = 0;
				value5 = null;
				value6 = 0;
				value7 = 0L;
				value8 = 0;
				value9 = 0;
				value10 = 0L;
				value11 = false;
				value12 = null;
				value13 = 0;
				value14 = null;
				value15 = false;
				value16 = 0;
				value17 = 0;
				value18 = 0;
				value19 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.PassRewards;
				value4 = value.Star;
				value5 = value.Roles;
				value6 = value.AccountLevel;
				value7 = value.AccountExp;
				value8 = value.AccountExpDelta;
				value9 = value.AccountEnergy;
				value10 = value.LastVitRecoverTime;
				value11 = value.IsWin;
				value12 = value.CostGoods;
				value13 = value.RaceCopyScore;
				value14 = value.FirstStarRewards;
				value15 = value.RewardInPackage;
				value16 = value.SuitboxCopyRewardCount;
				value17 = value.LastMaxScore;
				value18 = value.RpcId;
				value19 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadPackable(ref value3);
					if (memberCount != 2)
					{
						reader.ReadUnmanaged<int>(out value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<bool>(out value11);
													if (memberCount != 10)
													{
														reader.ReadPackable(ref value12);
														if (memberCount != 11)
														{
															reader.ReadUnmanaged<int>(out value13);
															if (memberCount != 12)
															{
																reader.ReadPackable(ref value14);
																if (memberCount != 13)
																{
																	reader.ReadUnmanaged<bool>(out value15);
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
																						message = reader.ReadString();
																						_ = 19;
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
				goto IL_03dd;
			}
		}
		value = new S2C_GameInstanceSettleResponse
		{
			IsFromPool = value2,
			PassRewards = value3,
			Star = value4,
			Roles = value5,
			AccountLevel = value6,
			AccountExp = value7,
			AccountExpDelta = value8,
			AccountEnergy = value9,
			LastVitRecoverTime = value10,
			IsWin = value11,
			CostGoods = value12,
			RaceCopyScore = value13,
			FirstStarRewards = value14,
			RewardInPackage = value15,
			SuitboxCopyRewardCount = value16,
			LastMaxScore = value17,
			RpcId = value18,
			Error = value19,
			Message = message
		};
		return;
		IL_03dd:
		value.IsFromPool = value2;
		value.PassRewards = value3;
		value.Star = value4;
		value.Roles = value5;
		value.AccountLevel = value6;
		value.AccountExp = value7;
		value.AccountExpDelta = value8;
		value.AccountEnergy = value9;
		value.LastVitRecoverTime = value10;
		value.IsWin = value11;
		value.CostGoods = value12;
		value.RaceCopyScore = value13;
		value.FirstStarRewards = value14;
		value.RewardInPackage = value15;
		value.SuitboxCopyRewardCount = value16;
		value.LastMaxScore = value17;
		value.RpcId = value18;
		value.Error = value19;
		value.Message = message;
	}
}
