using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(201)]
[MemoryPackable(GenerateType.Object)]
public class UserBaseInfo : MessageObject, IMemoryPackable<UserBaseInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class UserBaseInfoFormatter : MemoryPackFormatter<UserBaseInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref UserBaseInfo value)
		{
			UserBaseInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref UserBaseInfo value)
		{
			UserBaseInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public string Name { get; set; }

	[MemoryPackOrder(2)]
	public int Vip { get; set; }

	[MemoryPackOrder(3)]
	public int Level { get; set; }

	[MemoryPackOrder(4)]
	public string Account { get; set; }

	[MemoryPackOrder(5)]
	public long Gold { get; set; }

	[MemoryPackOrder(6)]
	public long Diamond { get; set; }

	[MemoryPackOrder(7)]
	public int Energy { get; set; }

	[MemoryPackOrder(9)]
	public long Exp { get; set; }

	[MemoryPackOrder(10)]
	public long FlagBit { get; set; }

	[MemoryPackOrder(11)]
	public int Icon { get; set; }

	[MemoryPackOrder(12)]
	public int IconFrame { get; set; }

	[MemoryPackOrder(13)]
	public int TitleId { get; set; }

	[MemoryPackOrder(14)]
	public List<int> ShowHeroes { get; set; } = new List<int>();

	[MemoryPackOrder(15)]
	public int MaxStoryLevel { get; set; }

	[MemoryPackOrder(16)]
	public int PosterGirl { get; set; }

	[MemoryPackOrder(17)]
	public int Background { get; set; }

	[MemoryPackOrder(18)]
	public int WeeklyCopyRank { get; set; }

	[MemoryPackOrder(19)]
	public long LastEnergyRecoveryTime { get; set; }

	[MemoryPackOrder(20)]
	public long MaxCopyOpenIdx { get; set; }

	[MemoryPackOrder(21)]
	public long FirstCharge { get; set; }

	[MemoryPackOrder(22)]
	public long TotalCharge { get; set; }

	[MemoryPackOrder(23)]
	public long Voucher { get; set; }

	[MemoryPackOrder(24)]
	public int LastMapId { get; set; }

	[MemoryPackOrder(25)]
	public int UserMoney { get; set; }

	[MemoryPackOrder(26)]
	public int Gender { get; set; }

	[MemoryPackOrder(27)]
	public int CopyStar { get; set; }

	[MemoryPackOrder(28)]
	public List<PbMedalInfo> WearMedal { get; set; } = new List<PbMedalInfo>();

	[MemoryPackOrder(29)]
	public PbExtraItemInfo IconInfo { get; set; }

	[MemoryPackOrder(30)]
	public PbExtraItemInfo IconFrameInfo { get; set; }

	[MemoryPackOrder(31)]
	public PbExtraItemInfo TitleInfo { get; set; }

	[MemoryPackOrder(32)]
	public int logintimes { get; set; }

	[MemoryPackOrder(33)]
	public long CreateTime { get; set; }

	[MemoryPackOrder(34)]
	public string UnionName { get; set; }

	[MemoryPackOrder(35)]
	public List<PbCopyChallengeInfo> CopyChallengeInfo { get; set; } = new List<PbCopyChallengeInfo>();

	[MemoryPackOrder(36)]
	public int ShowPosterGirl { get; set; }

	[MemoryPackOrder(37)]
	public int ShowBackground { get; set; }

	[MemoryPackOrder(38)]
	public bool IsShowCopyInfo { get; set; }

	public static UserBaseInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(UserBaseInfo)) as UserBaseInfo;
		}
		return new UserBaseInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			Name = null;
			Vip = 0;
			Level = 0;
			Account = null;
			Gold = 0L;
			Diamond = 0L;
			Energy = 0;
			Exp = 0L;
			FlagBit = 0L;
			Icon = 0;
			IconFrame = 0;
			TitleId = 0;
			ShowHeroes.Clear();
			MaxStoryLevel = 0;
			PosterGirl = 0;
			Background = 0;
			WeeklyCopyRank = 0;
			LastEnergyRecoveryTime = 0L;
			MaxCopyOpenIdx = 0L;
			FirstCharge = 0L;
			TotalCharge = 0L;
			Voucher = 0L;
			LastMapId = 0;
			UserMoney = 0;
			Gender = 0;
			CopyStar = 0;
			WearMedal.Clear();
			IconInfo = null;
			IconFrameInfo = null;
			TitleInfo = null;
			logintimes = 0;
			CreateTime = 0L;
			UnionName = null;
			CopyChallengeInfo.Clear();
			ShowPosterGirl = 0;
			ShowBackground = 0;
			IsShowCopyInfo = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static UserBaseInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<UserBaseInfo>())
		{
			MemoryPackFormatterProvider.Register(new UserBaseInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<UserBaseInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<UserBaseInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbMedalInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbMedalInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbCopyChallengeInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbCopyChallengeInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref UserBaseInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, long>(39, value.IsFromPool, value.UserId);
		writer.WriteString(value.Name);
		writer.WriteUnmanaged<int, int>(value.Vip, value.Level);
		writer.WriteString(value.Account);
		writer.WriteUnmanaged<long, long, int, long, long, int, int, int>(value.Gold, value.Diamond, value.Energy, value.Exp, value.FlagBit, value.Icon, value.IconFrame, value.TitleId);
		writer.WriteValue<List<int>>(value.ShowHeroes);
		writer.WriteUnmanaged<int, int, int, int, long, long, long, long, long, int, int, int, int>(value.MaxStoryLevel, value.PosterGirl, value.Background, value.WeeklyCopyRank, value.LastEnergyRecoveryTime, value.MaxCopyOpenIdx, value.FirstCharge, value.TotalCharge, value.Voucher, value.LastMapId, value.UserMoney, value.Gender, value.CopyStar);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbMedalInfo>>(value.WearMedal));
		writer.WritePackable<PbExtraItemInfo>(value.IconInfo);
		writer.WritePackable<PbExtraItemInfo>(value.IconFrameInfo);
		writer.WritePackable<PbExtraItemInfo>(value.TitleInfo);
		writer.WriteUnmanaged<int, long>(value.logintimes, value.CreateTime);
		writer.WriteString(value.UnionName);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbCopyChallengeInfo>>(value.CopyChallengeInfo));
		writer.WriteUnmanaged<int, int, bool>(value.ShowPosterGirl, value.ShowBackground, value.IsShowCopyInfo);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref UserBaseInfo? value)
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
		long value7;
		int value8;
		long value9;
		long value10;
		int value11;
		int value12;
		int value13;
		List<int> value14;
		int value15;
		int value16;
		int value17;
		int value18;
		long value19;
		long value20;
		long value21;
		long value22;
		long value23;
		int value24;
		int value25;
		int value26;
		int value27;
		List<PbMedalInfo> value28;
		PbExtraItemInfo value29;
		PbExtraItemInfo value30;
		PbExtraItemInfo value31;
		int value32;
		long value33;
		List<PbCopyChallengeInfo> value34;
		int value35;
		int value36;
		bool value37;
		string name;
		string account;
		string unionName;
		if (memberCount == 39)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				name = value.Name;
				value4 = value.Vip;
				value5 = value.Level;
				account = value.Account;
				value6 = value.Gold;
				value7 = value.Diamond;
				value8 = value.Energy;
				value9 = value.Exp;
				value10 = value.FlagBit;
				value11 = value.Icon;
				value12 = value.IconFrame;
				value13 = value.TitleId;
				value14 = value.ShowHeroes;
				value15 = value.MaxStoryLevel;
				value16 = value.PosterGirl;
				value17 = value.Background;
				value18 = value.WeeklyCopyRank;
				value19 = value.LastEnergyRecoveryTime;
				value20 = value.MaxCopyOpenIdx;
				value21 = value.FirstCharge;
				value22 = value.TotalCharge;
				value23 = value.Voucher;
				value24 = value.LastMapId;
				value25 = value.UserMoney;
				value26 = value.Gender;
				value27 = value.CopyStar;
				value28 = value.WearMedal;
				value29 = value.IconInfo;
				value30 = value.IconFrameInfo;
				value31 = value.TitleInfo;
				value32 = value.logintimes;
				value33 = value.CreateTime;
				unionName = value.UnionName;
				value34 = value.CopyChallengeInfo;
				value35 = value.ShowPosterGirl;
				value36 = value.ShowBackground;
				value37 = value.IsShowCopyInfo;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				name = reader.ReadString();
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				account = reader.ReadString();
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				reader.ReadUnmanaged<int>(out value12);
				reader.ReadUnmanaged<int>(out value13);
				reader.ReadValue(ref value14);
				reader.ReadUnmanaged<int>(out value15);
				reader.ReadUnmanaged<int>(out value16);
				reader.ReadUnmanaged<int>(out value17);
				reader.ReadUnmanaged<int>(out value18);
				reader.ReadUnmanaged<long>(out value19);
				reader.ReadUnmanaged<long>(out value20);
				reader.ReadUnmanaged<long>(out value21);
				reader.ReadUnmanaged<long>(out value22);
				reader.ReadUnmanaged<long>(out value23);
				reader.ReadUnmanaged<int>(out value24);
				reader.ReadUnmanaged<int>(out value25);
				reader.ReadUnmanaged<int>(out value26);
				reader.ReadUnmanaged<int>(out value27);
				ListFormatter.DeserializePackable(ref reader, ref value28);
				reader.ReadPackable(ref value29);
				reader.ReadPackable(ref value30);
				reader.ReadPackable(ref value31);
				reader.ReadUnmanaged<int>(out value32);
				reader.ReadUnmanaged<long>(out value33);
				unionName = reader.ReadString();
				ListFormatter.DeserializePackable(ref reader, ref value34);
				reader.ReadUnmanaged<int>(out value35);
				reader.ReadUnmanaged<int>(out value36);
				reader.ReadUnmanaged<bool>(out value37);
				goto IL_07b4;
			}
			reader.ReadUnmanaged<bool, long>(out value2, out value3);
			name = reader.ReadString();
			reader.ReadUnmanaged<int, int>(out value4, out value5);
			account = reader.ReadString();
			reader.ReadUnmanaged<long, long, int, long, long, int, int, int>(out value6, out value7, out value8, out value9, out value10, out value11, out value12, out value13);
			value14 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int, int, int, long, long, long, long, long, int, int, int, int>(out value15, out value16, out value17, out value18, out value19, out value20, out value21, out value22, out value23, out value24, out value25, out value26, out value27);
			value28 = ListFormatter.DeserializePackable<PbMedalInfo>(ref reader);
			value29 = reader.ReadPackable<PbExtraItemInfo>();
			value30 = reader.ReadPackable<PbExtraItemInfo>();
			value31 = reader.ReadPackable<PbExtraItemInfo>();
			reader.ReadUnmanaged<int, long>(out value32, out value33);
			unionName = reader.ReadString();
			value34 = ListFormatter.DeserializePackable<PbCopyChallengeInfo>(ref reader);
			reader.ReadUnmanaged<int, int, bool>(out value35, out value36, out value37);
		}
		else
		{
			if (memberCount > 39)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(UserBaseInfo), 39, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				name = null;
				value4 = 0;
				value5 = 0;
				account = null;
				value6 = 0L;
				value7 = 0L;
				value8 = 0;
				value9 = 0L;
				value10 = 0L;
				value11 = 0;
				value12 = 0;
				value13 = 0;
				value14 = null;
				value15 = 0;
				value16 = 0;
				value17 = 0;
				value18 = 0;
				value19 = 0L;
				value20 = 0L;
				value21 = 0L;
				value22 = 0L;
				value23 = 0L;
				value24 = 0;
				value25 = 0;
				value26 = 0;
				value27 = 0;
				value28 = null;
				value29 = null;
				value30 = null;
				value31 = null;
				value32 = 0;
				value33 = 0L;
				unionName = null;
				value34 = null;
				value35 = 0;
				value36 = 0;
				value37 = false;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				name = value.Name;
				value4 = value.Vip;
				value5 = value.Level;
				account = value.Account;
				value6 = value.Gold;
				value7 = value.Diamond;
				value8 = value.Energy;
				value9 = value.Exp;
				value10 = value.FlagBit;
				value11 = value.Icon;
				value12 = value.IconFrame;
				value13 = value.TitleId;
				value14 = value.ShowHeroes;
				value15 = value.MaxStoryLevel;
				value16 = value.PosterGirl;
				value17 = value.Background;
				value18 = value.WeeklyCopyRank;
				value19 = value.LastEnergyRecoveryTime;
				value20 = value.MaxCopyOpenIdx;
				value21 = value.FirstCharge;
				value22 = value.TotalCharge;
				value23 = value.Voucher;
				value24 = value.LastMapId;
				value25 = value.UserMoney;
				value26 = value.Gender;
				value27 = value.CopyStar;
				value28 = value.WearMedal;
				value29 = value.IconInfo;
				value30 = value.IconFrameInfo;
				value31 = value.TitleInfo;
				value32 = value.logintimes;
				value33 = value.CreateTime;
				unionName = value.UnionName;
				value34 = value.CopyChallengeInfo;
				value35 = value.ShowPosterGirl;
				value36 = value.ShowBackground;
				value37 = value.IsShowCopyInfo;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<long>(out value3);
					if (memberCount != 2)
					{
						name = reader.ReadString();
						if (memberCount != 3)
						{
							reader.ReadUnmanaged<int>(out value4);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<int>(out value5);
								if (memberCount != 5)
								{
									account = reader.ReadString();
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<long>(out value6);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value7);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value8);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<long>(out value9);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<long>(out value10);
														if (memberCount != 11)
														{
															reader.ReadUnmanaged<int>(out value11);
															if (memberCount != 12)
															{
																reader.ReadUnmanaged<int>(out value12);
																if (memberCount != 13)
																{
																	reader.ReadUnmanaged<int>(out value13);
																	if (memberCount != 14)
																	{
																		reader.ReadValue(ref value14);
																		if (memberCount != 15)
																		{
																			reader.ReadUnmanaged<int>(out value15);
																			if (memberCount != 16)
																			{
																				reader.ReadUnmanaged<int>(out value16);
																				if (memberCount != 17)
																				{
																					reader.ReadUnmanaged<int>(out value17);
																					if (memberCount != 18)
																					{
																						reader.ReadUnmanaged<int>(out value18);
																						if (memberCount != 19)
																						{
																							reader.ReadUnmanaged<long>(out value19);
																							if (memberCount != 20)
																							{
																								reader.ReadUnmanaged<long>(out value20);
																								if (memberCount != 21)
																								{
																									reader.ReadUnmanaged<long>(out value21);
																									if (memberCount != 22)
																									{
																										reader.ReadUnmanaged<long>(out value22);
																										if (memberCount != 23)
																										{
																											reader.ReadUnmanaged<long>(out value23);
																											if (memberCount != 24)
																											{
																												reader.ReadUnmanaged<int>(out value24);
																												if (memberCount != 25)
																												{
																													reader.ReadUnmanaged<int>(out value25);
																													if (memberCount != 26)
																													{
																														reader.ReadUnmanaged<int>(out value26);
																														if (memberCount != 27)
																														{
																															reader.ReadUnmanaged<int>(out value27);
																															if (memberCount != 28)
																															{
																																ListFormatter.DeserializePackable(ref reader, ref value28);
																																if (memberCount != 29)
																																{
																																	reader.ReadPackable(ref value29);
																																	if (memberCount != 30)
																																	{
																																		reader.ReadPackable(ref value30);
																																		if (memberCount != 31)
																																		{
																																			reader.ReadPackable(ref value31);
																																			if (memberCount != 32)
																																			{
																																				reader.ReadUnmanaged<int>(out value32);
																																				if (memberCount != 33)
																																				{
																																					reader.ReadUnmanaged<long>(out value33);
																																					if (memberCount != 34)
																																					{
																																						unionName = reader.ReadString();
																																						if (memberCount != 35)
																																						{
																																							ListFormatter.DeserializePackable(ref reader, ref value34);
																																							if (memberCount != 36)
																																							{
																																								reader.ReadUnmanaged<int>(out value35);
																																								if (memberCount != 37)
																																								{
																																									reader.ReadUnmanaged<int>(out value36);
																																									if (memberCount != 38)
																																									{
																																										reader.ReadUnmanaged<bool>(out value37);
																																										_ = 39;
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
				goto IL_07b4;
			}
		}
		value = new UserBaseInfo
		{
			IsFromPool = value2,
			UserId = value3,
			Name = name,
			Vip = value4,
			Level = value5,
			Account = account,
			Gold = value6,
			Diamond = value7,
			Energy = value8,
			Exp = value9,
			FlagBit = value10,
			Icon = value11,
			IconFrame = value12,
			TitleId = value13,
			ShowHeroes = value14,
			MaxStoryLevel = value15,
			PosterGirl = value16,
			Background = value17,
			WeeklyCopyRank = value18,
			LastEnergyRecoveryTime = value19,
			MaxCopyOpenIdx = value20,
			FirstCharge = value21,
			TotalCharge = value22,
			Voucher = value23,
			LastMapId = value24,
			UserMoney = value25,
			Gender = value26,
			CopyStar = value27,
			WearMedal = value28,
			IconInfo = value29,
			IconFrameInfo = value30,
			TitleInfo = value31,
			logintimes = value32,
			CreateTime = value33,
			UnionName = unionName,
			CopyChallengeInfo = value34,
			ShowPosterGirl = value35,
			ShowBackground = value36,
			IsShowCopyInfo = value37
		};
		return;
		IL_07b4:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.Name = name;
		value.Vip = value4;
		value.Level = value5;
		value.Account = account;
		value.Gold = value6;
		value.Diamond = value7;
		value.Energy = value8;
		value.Exp = value9;
		value.FlagBit = value10;
		value.Icon = value11;
		value.IconFrame = value12;
		value.TitleId = value13;
		value.ShowHeroes = value14;
		value.MaxStoryLevel = value15;
		value.PosterGirl = value16;
		value.Background = value17;
		value.WeeklyCopyRank = value18;
		value.LastEnergyRecoveryTime = value19;
		value.MaxCopyOpenIdx = value20;
		value.FirstCharge = value21;
		value.TotalCharge = value22;
		value.Voucher = value23;
		value.LastMapId = value24;
		value.UserMoney = value25;
		value.Gender = value26;
		value.CopyStar = value27;
		value.WearMedal = value28;
		value.IconInfo = value29;
		value.IconFrameInfo = value30;
		value.TitleInfo = value31;
		value.logintimes = value32;
		value.CreateTime = value33;
		value.UnionName = unionName;
		value.CopyChallengeInfo = value34;
		value.ShowPosterGirl = value35;
		value.ShowBackground = value36;
		value.IsShowCopyInfo = value37;
	}
}
