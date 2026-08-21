using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(212)]
[MemoryPackable(GenerateType.Object)]
public class PbNormalRoleInfo : MessageObject, IMemoryPackable<PbNormalRoleInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbNormalRoleInfoFormatter : MemoryPackFormatter<PbNormalRoleInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbNormalRoleInfo value)
		{
			PbNormalRoleInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbNormalRoleInfo value)
		{
			PbNormalRoleInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int RoleId { get; set; }

	[MemoryPackOrder(1)]
	public int Star { get; set; }

	[MemoryPackOrder(2)]
	public int Level { get; set; }

	[MemoryPackOrder(3)]
	public long Exp { get; set; }

	[MemoryPackOrder(4)]
	public List<PbEquipBase> Armours { get; set; } = new List<PbEquipBase>();

	[MemoryPackOrder(5)]
	public PbEquipBase Weapon { get; set; }

	[MemoryPackOrder(6)]
	public List<PbRoleTalent> Talents { get; set; } = new List<PbRoleTalent>();

	[MemoryPackOrder(7)]
	public List<int> SeatLevel { get; set; } = new List<int>();

	[MemoryPackOrder(8)]
	public int Feeling { get; set; }

	[MemoryPackOrder(9)]
	public int TrustLevel { get; set; }

	[MemoryPackOrder(10)]
	public PbEquipBase Suitbox { get; set; }

	[MemoryPackOrder(11)]
	public int SkinID { get; set; }

	[MemoryPackOrder(12)]
	public List<PbIdValue> SkillSkinIds { get; set; } = new List<PbIdValue>();

	public static PbNormalRoleInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbNormalRoleInfo)) as PbNormalRoleInfo;
		}
		return new PbNormalRoleInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RoleId = 0;
			Star = 0;
			Level = 0;
			Exp = 0L;
			Armours.Clear();
			Weapon = null;
			Talents.Clear();
			SeatLevel.Clear();
			Feeling = 0;
			TrustLevel = 0;
			Suitbox = null;
			SkinID = 0;
			SkillSkinIds.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbNormalRoleInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbNormalRoleInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbNormalRoleInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbNormalRoleInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbNormalRoleInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbEquipBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbEquipBase>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbRoleTalent>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbRoleTalent>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbIdValue>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbIdValue>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbNormalRoleInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, long>(14, value.IsFromPool, value.RoleId, value.Star, value.Level, value.Exp);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEquipBase>>(value.Armours));
		writer.WritePackable<PbEquipBase>(value.Weapon);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRoleTalent>>(value.Talents));
		writer.WriteValue<List<int>>(value.SeatLevel);
		writer.WriteUnmanaged<int, int>(value.Feeling, value.TrustLevel);
		writer.WritePackable<PbEquipBase>(value.Suitbox);
		writer.WriteUnmanaged<int>(value.SkinID);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbIdValue>>(value.SkillSkinIds));
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbNormalRoleInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		int value5;
		long value6;
		List<PbEquipBase> value7;
		PbEquipBase value8;
		List<PbRoleTalent> value9;
		List<int> value10;
		int value11;
		int value12;
		PbEquipBase value13;
		int value14;
		List<PbIdValue> value15;
		if (memberCount == 14)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.Star;
				value5 = value.Level;
				value6 = value.Exp;
				value7 = value.Armours;
				value8 = value.Weapon;
				value9 = value.Talents;
				value10 = value.SeatLevel;
				value11 = value.Feeling;
				value12 = value.TrustLevel;
				value13 = value.Suitbox;
				value14 = value.SkinID;
				value15 = value.SkillSkinIds;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				reader.ReadPackable(ref value8);
				ListFormatter.DeserializePackable(ref reader, ref value9);
				reader.ReadValue(ref value10);
				reader.ReadUnmanaged<int>(out value11);
				reader.ReadUnmanaged<int>(out value12);
				reader.ReadPackable(ref value13);
				reader.ReadUnmanaged<int>(out value14);
				ListFormatter.DeserializePackable(ref reader, ref value15);
				goto IL_02e3;
			}
			reader.ReadUnmanaged<bool, int, int, int, long>(out value2, out value3, out value4, out value5, out value6);
			value7 = ListFormatter.DeserializePackable<PbEquipBase>(ref reader);
			value8 = reader.ReadPackable<PbEquipBase>();
			value9 = ListFormatter.DeserializePackable<PbRoleTalent>(ref reader);
			value10 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<int, int>(out value11, out value12);
			value13 = reader.ReadPackable<PbEquipBase>();
			reader.ReadUnmanaged<int>(out value14);
			value15 = ListFormatter.DeserializePackable<PbIdValue>(ref reader);
		}
		else
		{
			if (memberCount > 14)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbNormalRoleInfo), 14, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0L;
				value7 = null;
				value8 = null;
				value9 = null;
				value10 = null;
				value11 = 0;
				value12 = 0;
				value13 = null;
				value14 = 0;
				value15 = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.Star;
				value5 = value.Level;
				value6 = value.Exp;
				value7 = value.Armours;
				value8 = value.Weapon;
				value9 = value.Talents;
				value10 = value.SeatLevel;
				value11 = value.Feeling;
				value12 = value.TrustLevel;
				value13 = value.Suitbox;
				value14 = value.SkinID;
				value15 = value.SkillSkinIds;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					reader.ReadUnmanaged<int>(out value3);
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
									ListFormatter.DeserializePackable(ref reader, ref value7);
									if (memberCount != 6)
									{
										reader.ReadPackable(ref value8);
										if (memberCount != 7)
										{
											ListFormatter.DeserializePackable(ref reader, ref value9);
											if (memberCount != 8)
											{
												reader.ReadValue(ref value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value11);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<int>(out value12);
														if (memberCount != 11)
														{
															reader.ReadPackable(ref value13);
															if (memberCount != 12)
															{
																reader.ReadUnmanaged<int>(out value14);
																if (memberCount != 13)
																{
																	ListFormatter.DeserializePackable(ref reader, ref value15);
																	_ = 14;
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
				goto IL_02e3;
			}
		}
		value = new PbNormalRoleInfo
		{
			IsFromPool = value2,
			RoleId = value3,
			Star = value4,
			Level = value5,
			Exp = value6,
			Armours = value7,
			Weapon = value8,
			Talents = value9,
			SeatLevel = value10,
			Feeling = value11,
			TrustLevel = value12,
			Suitbox = value13,
			SkinID = value14,
			SkillSkinIds = value15
		};
		return;
		IL_02e3:
		value.IsFromPool = value2;
		value.RoleId = value3;
		value.Star = value4;
		value.Level = value5;
		value.Exp = value6;
		value.Armours = value7;
		value.Weapon = value8;
		value.Talents = value9;
		value.SeatLevel = value10;
		value.Feeling = value11;
		value.TrustLevel = value12;
		value.Suitbox = value13;
		value.SkinID = value14;
		value.SkillSkinIds = value15;
	}
}
