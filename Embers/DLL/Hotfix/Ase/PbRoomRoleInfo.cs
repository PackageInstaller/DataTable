using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(203)]
[MemoryPackable(GenerateType.Object)]
public class PbRoomRoleInfo : MessageObject, IMemoryPackable<PbRoomRoleInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbRoomRoleInfoFormatter : MemoryPackFormatter<PbRoomRoleInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbRoomRoleInfo value)
		{
			PbRoomRoleInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbRoomRoleInfo value)
		{
			PbRoomRoleInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(0)]
	public int RoleId { get; set; }

	[MemoryPackOrder(1)]
	public int Star { get; set; }

	[MemoryPackOrder(2)]
	public int Level { get; set; }

	[MemoryPackOrder(3)]
	public int SkinId { get; set; }

	[MemoryPackOrder(4)]
	public List<PbEquipBase> Armours { get; set; } = new List<PbEquipBase>();

	[MemoryPackOrder(5)]
	public PbEquipBase Weapon { get; set; }

	[MemoryPackOrder(6)]
	public List<PbRoleTalent> Talents { get; set; } = new List<PbRoleTalent>();

	[MemoryPackOrder(7)]
	public List<int> SeatLevel { get; set; } = new List<int>();

	[MemoryPackOrder(8)]
	public PbEquipBase Suitbox { get; set; }

	[MemoryPackOrder(9)]
	public List<PbIdValue> SkillSkinIds { get; set; } = new List<PbIdValue>();

	public static PbRoomRoleInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbRoomRoleInfo)) as PbRoomRoleInfo;
		}
		return new PbRoomRoleInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			RoleId = 0;
			Star = 0;
			Level = 0;
			SkinId = 0;
			Armours.Clear();
			Weapon = null;
			Talents.Clear();
			SeatLevel.Clear();
			Suitbox = null;
			SkillSkinIds.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbRoomRoleInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbRoomRoleInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbRoomRoleInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbRoomRoleInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbRoomRoleInfo>());
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
	public static void Serialize(ref MemoryPackWriter writer, ref PbRoomRoleInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int>(12, value.IsFromPool, value.RoleId, value.Star, value.Level, value.SkinId);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbEquipBase>>(value.Armours));
		writer.WritePackable<PbEquipBase>(value.Weapon);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbRoleTalent>>(value.Talents));
		writer.WriteValue<List<int>>(value.SeatLevel);
		writer.WritePackable<PbEquipBase>(value.Suitbox);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbIdValue>>(value.SkillSkinIds));
		writer.WriteUnmanaged<int>(value.RpcId);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbRoomRoleInfo? value)
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
		int value6;
		List<PbEquipBase> value7;
		PbEquipBase value8;
		List<PbRoleTalent> value9;
		List<int> value10;
		PbEquipBase value11;
		List<PbIdValue> value12;
		int value13;
		if (memberCount == 12)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.Star;
				value5 = value.Level;
				value6 = value.SkinId;
				value7 = value.Armours;
				value8 = value.Weapon;
				value9 = value.Talents;
				value10 = value.SeatLevel;
				value11 = value.Suitbox;
				value12 = value.SkillSkinIds;
				value13 = value.RpcId;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				reader.ReadPackable(ref value8);
				ListFormatter.DeserializePackable(ref reader, ref value9);
				reader.ReadValue(ref value10);
				reader.ReadPackable(ref value11);
				ListFormatter.DeserializePackable(ref reader, ref value12);
				reader.ReadUnmanaged<int>(out value13);
				goto IL_027e;
			}
			reader.ReadUnmanaged<bool, int, int, int, int>(out value2, out value3, out value4, out value5, out value6);
			value7 = ListFormatter.DeserializePackable<PbEquipBase>(ref reader);
			value8 = reader.ReadPackable<PbEquipBase>();
			value9 = ListFormatter.DeserializePackable<PbRoleTalent>(ref reader);
			value10 = reader.ReadValue<List<int>>();
			value11 = reader.ReadPackable<PbEquipBase>();
			value12 = ListFormatter.DeserializePackable<PbIdValue>(ref reader);
			reader.ReadUnmanaged<int>(out value13);
		}
		else
		{
			if (memberCount > 12)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbRoomRoleInfo), 12, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = null;
				value8 = null;
				value9 = null;
				value10 = null;
				value11 = null;
				value12 = null;
				value13 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.RoleId;
				value4 = value.Star;
				value5 = value.Level;
				value6 = value.SkinId;
				value7 = value.Armours;
				value8 = value.Weapon;
				value9 = value.Talents;
				value10 = value.SeatLevel;
				value11 = value.Suitbox;
				value12 = value.SkillSkinIds;
				value13 = value.RpcId;
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
								reader.ReadUnmanaged<int>(out value6);
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
													reader.ReadPackable(ref value11);
													if (memberCount != 10)
													{
														ListFormatter.DeserializePackable(ref reader, ref value12);
														if (memberCount != 11)
														{
															reader.ReadUnmanaged<int>(out value13);
															_ = 12;
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
				goto IL_027e;
			}
		}
		value = new PbRoomRoleInfo
		{
			IsFromPool = value2,
			RoleId = value3,
			Star = value4,
			Level = value5,
			SkinId = value6,
			Armours = value7,
			Weapon = value8,
			Talents = value9,
			SeatLevel = value10,
			Suitbox = value11,
			SkillSkinIds = value12,
			RpcId = value13
		};
		return;
		IL_027e:
		value.IsFromPool = value2;
		value.RoleId = value3;
		value.Star = value4;
		value.Level = value5;
		value.SkinId = value6;
		value.Armours = value7;
		value.Weapon = value8;
		value.Talents = value9;
		value.SeatLevel = value10;
		value.Suitbox = value11;
		value.SkillSkinIds = value12;
		value.RpcId = value13;
	}
}
