using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(330)]
[MemoryPackable(GenerateType.Object)]
public class PbBattleDataStatistics : MessageObject, IMemoryPackable<PbBattleDataStatistics>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbBattleDataStatisticsFormatter : MemoryPackFormatter<PbBattleDataStatistics>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbBattleDataStatistics value)
		{
			PbBattleDataStatistics.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbBattleDataStatistics value)
		{
			PbBattleDataStatistics.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public long UserId { get; set; }

	[MemoryPackOrder(1)]
	public int HeroId { get; set; }

	[MemoryPackOrder(2)]
	public int Atk { get; set; }

	[MemoryPackOrder(3)]
	public int CutToughen { get; set; }

	[MemoryPackOrder(4)]
	public int Def { get; set; }

	[MemoryPackOrder(5)]
	public int Hp { get; set; }

	[MemoryPackOrder(6)]
	public int EffectDamage { get; set; }

	[MemoryPackOrder(7)]
	public int CutToughenAmount { get; set; }

	[MemoryPackOrder(8)]
	public int TakeDamage { get; set; }

	[MemoryPackOrder(9)]
	public int HealAmount { get; set; }

	public static PbBattleDataStatistics Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbBattleDataStatistics)) as PbBattleDataStatistics;
		}
		return new PbBattleDataStatistics();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			UserId = 0L;
			HeroId = 0;
			Atk = 0;
			CutToughen = 0;
			Def = 0;
			Hp = 0;
			EffectDamage = 0;
			CutToughenAmount = 0;
			TakeDamage = 0;
			HealAmount = 0;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbBattleDataStatistics()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbBattleDataStatistics>())
		{
			MemoryPackFormatterProvider.Register(new PbBattleDataStatisticsFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbBattleDataStatistics[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbBattleDataStatistics>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbBattleDataStatistics? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<bool, long, int, int, int, int, int, int, int, int, int>(11, value.IsFromPool, value.UserId, value.HeroId, value.Atk, value.CutToughen, value.Def, value.Hp, value.EffectDamage, value.CutToughenAmount, value.TakeDamage, value.HealAmount);
		}
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbBattleDataStatistics? value)
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
		int value6;
		int value7;
		int value8;
		int value9;
		int value10;
		int value11;
		int value12;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.HeroId;
				value5 = value.Atk;
				value6 = value.CutToughen;
				value7 = value.Def;
				value8 = value.Hp;
				value9 = value.EffectDamage;
				value10 = value.CutToughenAmount;
				value11 = value.TakeDamage;
				value12 = value.HealAmount;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<long>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				reader.ReadUnmanaged<int>(out value11);
				reader.ReadUnmanaged<int>(out value12);
				goto IL_0226;
			}
			reader.ReadUnmanaged<bool, long, int, int, int, int, int, int, int, int, int>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9, out value10, out value11, out value12);
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbBattleDataStatistics), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0L;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0;
				value10 = 0;
				value11 = 0;
				value12 = 0;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.UserId;
				value4 = value.HeroId;
				value5 = value.Atk;
				value6 = value.CutToughen;
				value7 = value.Def;
				value8 = value.Hp;
				value9 = value.EffectDamage;
				value10 = value.CutToughenAmount;
				value11 = value.TakeDamage;
				value12 = value.HealAmount;
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
								reader.ReadUnmanaged<int>(out value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<int>(out value7);
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
														reader.ReadUnmanaged<int>(out value12);
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
				goto IL_0226;
			}
		}
		value = new PbBattleDataStatistics
		{
			IsFromPool = value2,
			UserId = value3,
			HeroId = value4,
			Atk = value5,
			CutToughen = value6,
			Def = value7,
			Hp = value8,
			EffectDamage = value9,
			CutToughenAmount = value10,
			TakeDamage = value11,
			HealAmount = value12
		};
		return;
		IL_0226:
		value.IsFromPool = value2;
		value.UserId = value3;
		value.HeroId = value4;
		value.Atk = value5;
		value.CutToughen = value6;
		value.Def = value7;
		value.Hp = value8;
		value.EffectDamage = value9;
		value.CutToughenAmount = value10;
		value.TakeDamage = value11;
		value.HealAmount = value12;
	}
}
