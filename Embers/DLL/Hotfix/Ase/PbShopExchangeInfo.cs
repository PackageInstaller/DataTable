using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(350)]
[MemoryPackable(GenerateType.Object)]
public class PbShopExchangeInfo : MessageObject, IMemoryPackable<PbShopExchangeInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbShopExchangeInfoFormatter : MemoryPackFormatter<PbShopExchangeInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbShopExchangeInfo value)
		{
			PbShopExchangeInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbShopExchangeInfo value)
		{
			PbShopExchangeInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int ExchangeId { get; set; }

	[MemoryPackOrder(1)]
	public int ExchangeCount { get; set; }

	[MemoryPackOrder(2)]
	public int LeftCount { get; set; }

	[MemoryPackOrder(3)]
	public int ItemId { get; set; }

	[MemoryPackOrder(4)]
	public int ItemCount { get; set; }

	[MemoryPackOrder(5)]
	public int ItemType { get; set; }

	[MemoryPackOrder(6)]
	public long RefreshTime { get; set; }

	[MemoryPackOrder(7)]
	public long DelistTime { get; set; }

	[MemoryPackOrder(8)]
	public List<PbShopConsumeItem> ConsumeItemInfo { get; set; } = new List<PbShopConsumeItem>();

	[MemoryPackOrder(9)]
	public bool IsUnlock { get; set; }

	public static PbShopExchangeInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbShopExchangeInfo)) as PbShopExchangeInfo;
		}
		return new PbShopExchangeInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			ExchangeId = 0;
			ExchangeCount = 0;
			LeftCount = 0;
			ItemId = 0;
			ItemCount = 0;
			ItemType = 0;
			RefreshTime = 0L;
			DelistTime = 0L;
			ConsumeItemInfo.Clear();
			IsUnlock = false;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbShopExchangeInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbShopExchangeInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbShopExchangeInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbShopExchangeInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbShopExchangeInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbShopConsumeItem>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbShopConsumeItem>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbShopExchangeInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int, int, int, int, int, long, long>(11, value.IsFromPool, value.ExchangeId, value.ExchangeCount, value.LeftCount, value.ItemId, value.ItemCount, value.ItemType, value.RefreshTime, value.DelistTime);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbShopConsumeItem>>(value.ConsumeItemInfo));
		writer.WriteUnmanaged<bool>(value.IsUnlock);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbShopExchangeInfo? value)
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
		int value7;
		int value8;
		long value9;
		long value10;
		List<PbShopConsumeItem> value11;
		bool value12;
		if (memberCount == 11)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.ExchangeId;
				value4 = value.ExchangeCount;
				value5 = value.LeftCount;
				value6 = value.ItemId;
				value7 = value.ItemCount;
				value8 = value.ItemType;
				value9 = value.RefreshTime;
				value10 = value.DelistTime;
				value11 = value.ConsumeItemInfo;
				value12 = value.IsUnlock;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadUnmanaged<int>(out value5);
				reader.ReadUnmanaged<int>(out value6);
				reader.ReadUnmanaged<int>(out value7);
				reader.ReadUnmanaged<int>(out value8);
				reader.ReadUnmanaged<long>(out value9);
				reader.ReadUnmanaged<long>(out value10);
				ListFormatter.DeserializePackable(ref reader, ref value11);
				reader.ReadUnmanaged<bool>(out value12);
				goto IL_0233;
			}
			reader.ReadUnmanaged<bool, int, int, int, int, int, int, long, long>(out value2, out value3, out value4, out value5, out value6, out value7, out value8, out value9, out value10);
			value11 = ListFormatter.DeserializePackable<PbShopConsumeItem>(ref reader);
			reader.ReadUnmanaged<bool>(out value12);
		}
		else
		{
			if (memberCount > 11)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbShopExchangeInfo), 11, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = 0;
				value6 = 0;
				value7 = 0;
				value8 = 0;
				value9 = 0L;
				value10 = 0L;
				value11 = null;
				value12 = false;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.ExchangeId;
				value4 = value.ExchangeCount;
				value5 = value.LeftCount;
				value6 = value.ItemId;
				value7 = value.ItemCount;
				value8 = value.ItemType;
				value9 = value.RefreshTime;
				value10 = value.DelistTime;
				value11 = value.ConsumeItemInfo;
				value12 = value.IsUnlock;
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
									reader.ReadUnmanaged<int>(out value7);
									if (memberCount != 6)
									{
										reader.ReadUnmanaged<int>(out value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<long>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<long>(out value10);
												if (memberCount != 9)
												{
													ListFormatter.DeserializePackable(ref reader, ref value11);
													if (memberCount != 10)
													{
														reader.ReadUnmanaged<bool>(out value12);
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
				goto IL_0233;
			}
		}
		value = new PbShopExchangeInfo
		{
			IsFromPool = value2,
			ExchangeId = value3,
			ExchangeCount = value4,
			LeftCount = value5,
			ItemId = value6,
			ItemCount = value7,
			ItemType = value8,
			RefreshTime = value9,
			DelistTime = value10,
			ConsumeItemInfo = value11,
			IsUnlock = value12
		};
		return;
		IL_0233:
		value.IsFromPool = value2;
		value.ExchangeId = value3;
		value.ExchangeCount = value4;
		value.LeftCount = value5;
		value.ItemId = value6;
		value.ItemCount = value7;
		value.ItemType = value8;
		value.RefreshTime = value9;
		value.DelistTime = value10;
		value.ConsumeItemInfo = value11;
		value.IsUnlock = value12;
	}
}
