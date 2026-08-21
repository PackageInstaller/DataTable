using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(5003)]
[MemoryPackable(GenerateType.Object)]
public class PbEquipBase : MessageObject, IMemoryPackable<PbEquipBase>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbEquipBaseFormatter : MemoryPackFormatter<PbEquipBase>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbEquipBase value)
		{
			PbEquipBase.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbEquipBase value)
		{
			PbEquipBase.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int Type { get; set; }

	[MemoryPackOrder(1)]
	public int EquipId { get; set; }

	[MemoryPackOrder(2)]
	public long Uuid { get; set; }

	[MemoryPackOrder(3)]
	public long Count { get; set; }

	[MemoryPackOrder(4)]
	public long RoleId { get; set; }

	[MemoryPackOrder(5)]
	public int Level { get; set; }

	[MemoryPackOrder(6)]
	public int Exp { get; set; }

	[MemoryPackOrder(7)]
	public bool Locked { get; set; }

	[MemoryPackOrder(8)]
	public int Star { get; set; }

	[MemoryPackOrder(9)]
	public int Refine { get; set; }

	[MemoryPackOrder(10)]
	public int Rank { get; set; }

	[MemoryPackOrder(11)]
	public List<PbAttributeBase> Attribute { get; set; } = new List<PbAttributeBase>();

	[MemoryPackOrder(12)]
	public List<PbEntryBase> Entries { get; set; } = new List<PbEntryBase>();

	[MemoryPackOrder(13)]
	public List<PbEntryBase> CacheEntries { get; set; } = new List<PbEntryBase>();

	[MemoryPackOrder(14)]
	public int SubType { get; set; }

	public static PbEquipBase Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbEquipBase)) as PbEquipBase;
		}
		return new PbEquipBase();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			Type = 0;
			EquipId = 0;
			Uuid = 0L;
			Count = 0L;
			RoleId = 0L;
			Level = 0;
			Exp = 0;
			Locked = false;
			Star = 0;
			Refine = 0;
			Rank = 0;
			Attribute.Clear();
			Entries.Clear();
			CacheEntries.Clear();
			SubType = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbEquipBase()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbEquipBase>())
		{
			MemoryPackFormatterProvider.Register(new PbEquipBaseFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbEquipBase[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbEquipBase>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbAttributeBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbAttributeBase>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbEntryBase>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbEntryBase>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbEquipBase? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, long, long, long, int, int, bool, int, int, int>(16, value.IsFromPool, value.Type, value.EquipId, value.Uuid, value.Count, value.RoleId, value.Level, value.Exp, value.Locked, value.Star, value.Refine, value.Rank);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbAttributeBase>>(value.Attribute));
		List<PbEntryBase> source = value.Entries;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		source = value.CacheEntries;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		writer.WriteUnmanaged<int>(value.SubType);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbEquipBase? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		long value5;
		long value6;
		long value7;
		int value8;
		int value9;
		bool value10;
		int value11;
		int value12;
		int value13;
		List<PbAttributeBase> value14;
		List<PbEntryBase> value15;
		List<PbEntryBase> value16;
		int value17;
		if (memberCount == 16)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.EquipId;
				value5 = value.Uuid;
				value6 = value.Count;
				value7 = value.RoleId;
				value8 = value.Level;
				value9 = value.Exp;
				value10 = value.Locked;
				value11 = value.Star;
				value12 = value.Refine;
				value13 = value.Rank;
				value14 = value.Attribute;
				value15 = value.Entries;
				value16 = value.CacheEntries;
				value17 = value.SubType;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<long>(out value5);
				reader.ReadUnmanaged<long>(out value6);
				reader.ReadUnmanaged<long>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<bool>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				reader.ReadUnmanaged<int>(out value12);
				reader.ReadUnmanaged<int>(out value13);
				ListFormatter.DeserializePackable(ref reader, ref value14);
				ListFormatter.DeserializePackable(ref reader, ref value15);
				ListFormatter.DeserializePackable(ref reader, ref value16);
				reader.ReadUnmanaged<int>(out value17);
				goto IL_0334;
			}
			reader.ReadUnmanaged<bool, int, int, long, long, long, int, int, bool, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9, out value10, out value11, out value12, out value13);
			value14 = ListFormatter.DeserializePackable<PbAttributeBase>(ref reader);
			value15 = ListFormatter.DeserializePackable<PbEntryBase>(ref reader);
			value16 = ListFormatter.DeserializePackable<PbEntryBase>(ref reader);
			reader.ReadUnmanaged<int>(out value17);
		}
		else
		{
			if (memberCount > 16)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbEquipBase), 16, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0L;
				value6 = 0L;
				value7 = 0L;
				value8 = 0;
				value9 = 0;
				value10 = false;
				value11 = 0;
				value12 = 0;
				value13 = 0;
				value14 = null;
				value15 = null;
				value16 = null;
				value17 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Type;
				value4 = value.EquipId;
				value5 = value.Uuid;
				value6 = value.Count;
				value7 = value.RoleId;
				value8 = value.Level;
				value9 = value.Exp;
				value10 = value.Locked;
				value11 = value.Star;
				value12 = value.Refine;
				value13 = value.Rank;
				value14 = value.Attribute;
				value15 = value.Entries;
				value16 = value.CacheEntries;
				value17 = value.SubType;
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
							reader.ReadUnmanaged<long>(out value5);
							if (memberCount != 4)
							{
								reader.ReadUnmanaged<long>(out value6);
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
												reader.ReadUnmanaged<bool>(out value10);
												if (memberCount != 9)
												{
													reader.ReadUnmanaged<int>(out value11);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<int>(out value12);
														if (memberCount != 11)
														{
															reader.ReadUnmanaged<int>(out value13);
															if (memberCount != 12)
															{
																ListFormatter.DeserializePackable(ref reader, ref value14);
																if (memberCount != 13)
																{
																	ListFormatter.DeserializePackable(ref reader, ref value15);
																	if (memberCount != 14)
																	{
																		ListFormatter.DeserializePackable(ref reader, ref value16);
																		if (memberCount != 15)
																		{
																			reader.ReadUnmanaged<int>(out value17);
																			_ = 16;
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
				goto IL_0334;
			}
		}
		value = new PbEquipBase
		{
			IsFromPool = value2,
			Type = value3,
			EquipId = value4,
			Uuid = value5,
			Count = value6,
			RoleId = value7,
			Level = value8,
			Exp = value9,
			Locked = value10,
			Star = value11,
			Refine = value12,
			Rank = value13,
			Attribute = value14,
			Entries = value15,
			CacheEntries = value16,
			SubType = value17
		};
		return;
		IL_0334:
		value.IsFromPool = value2;
		value.Type = value3;
		value.EquipId = value4;
		value.Uuid = value5;
		value.Count = value6;
		value.RoleId = value7;
		value.Level = value8;
		value.Exp = value9;
		value.Locked = value10;
		value.Star = value11;
		value.Refine = value12;
		value.Rank = value13;
		value.Attribute = value14;
		value.Entries = value15;
		value.CacheEntries = value16;
		value.SubType = value17;
	}
}
