using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(351)]
[MemoryPackable(GenerateType.Object)]
public class PbShopInfo : MessageObject, IMemoryPackable<PbShopInfo>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class PbShopInfoFormatter : MemoryPackFormatter<PbShopInfo>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref PbShopInfo value)
		{
			PbShopInfo.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref PbShopInfo value)
		{
			PbShopInfo.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(0)]
	public int MainShopId { get; set; }

	[MemoryPackOrder(1)]
	public int ShopId { get; set; }

	[MemoryPackOrder(2)]
	public List<int> ConsumeItemId { get; set; } = new List<int>();

	[MemoryPackOrder(3)]
	public List<int> ConsumeItemType { get; set; } = new List<int>();

	[MemoryPackOrder(4)]
	public long RefreshTime { get; set; }

	[MemoryPackOrder(5)]
	public List<PbShopExchangeInfo> ExchangeInfos { get; set; } = new List<PbShopExchangeInfo>();

	[MemoryPackOrder(6)]
	public string ShopName { get; set; }

	public static PbShopInfo Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(PbShopInfo)) as PbShopInfo;
		}
		return new PbShopInfo();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			MainShopId = 0;
			ShopId = 0;
			ConsumeItemId.Clear();
			ConsumeItemType.Clear();
			RefreshTime = 0L;
			ExchangeInfos.Clear();
			ShopName = null;
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static PbShopInfo()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<PbShopInfo>())
		{
			MemoryPackFormatterProvider.Register(new PbShopInfoFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<PbShopInfo[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<PbShopInfo>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<int>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<int>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbShopExchangeInfo>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbShopExchangeInfo>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref PbShopInfo? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool, int, int>(8, value.IsFromPool, value.MainShopId, value.ShopId);
		writer.WriteValue<List<int>>(value.ConsumeItemId);
		writer.WriteValue<List<int>>(value.ConsumeItemType);
		writer.WriteUnmanaged<long>(value.RefreshTime);
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef<List<PbShopExchangeInfo>>(value.ExchangeInfos));
		writer.WriteString(value.ShopName);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref PbShopInfo? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		int value3;
		int value4;
		List<int> value5;
		List<int> value6;
		long value7;
		List<PbShopExchangeInfo> value8;
		string shopName;
		if (memberCount == 8)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.MainShopId;
				value4 = value.ShopId;
				value5 = value.ConsumeItemId;
				value6 = value.ConsumeItemType;
				value7 = value.RefreshTime;
				value8 = value.ExchangeInfos;
				shopName = value.ShopName;
				reader.ReadUnmanaged<bool>(out value2);
				reader.ReadUnmanaged<int>(out value3);
				reader.ReadUnmanaged<int>(out value4);
				reader.ReadValue(ref value5);
				reader.ReadValue(ref value6);
				reader.ReadUnmanaged<long>(out value7);
				ListFormatter.DeserializePackable(ref reader, ref value8);
				shopName = reader.ReadString();
				goto IL_01ba;
			}
			reader.ReadUnmanaged<bool, int, int>(out value2, out value3, out value4);
			value5 = reader.ReadValue<List<int>>();
			value6 = reader.ReadValue<List<int>>();
			reader.ReadUnmanaged<long>(out value7);
			value8 = ListFormatter.DeserializePackable<PbShopExchangeInfo>(ref reader);
			shopName = reader.ReadString();
		}
		else
		{
			if (memberCount > 8)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(PbShopInfo), 8, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = 0;
				value4 = 0;
				value5 = null;
				value6 = null;
				value7 = 0L;
				value8 = null;
				shopName = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.MainShopId;
				value4 = value.ShopId;
				value5 = value.ConsumeItemId;
				value6 = value.ConsumeItemType;
				value7 = value.RefreshTime;
				value8 = value.ExchangeInfos;
				shopName = value.ShopName;
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
							reader.ReadValue(ref value5);
							if (memberCount != 4)
							{
								reader.ReadValue(ref value6);
								if (memberCount != 5)
								{
									reader.ReadUnmanaged<long>(out value7);
									if (memberCount != 6)
									{
										ListFormatter.DeserializePackable(ref reader, ref value8);
										if (memberCount != 7)
										{
											shopName = reader.ReadString();
											_ = 8;
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
				goto IL_01ba;
			}
		}
		value = new PbShopInfo
		{
			IsFromPool = value2,
			MainShopId = value3,
			ShopId = value4,
			ConsumeItemId = value5,
			ConsumeItemType = value6,
			RefreshTime = value7,
			ExchangeInfos = value8,
			ShopName = shopName
		};
		return;
		IL_01ba:
		value.IsFromPool = value2;
		value.MainShopId = value3;
		value.ShopId = value4;
		value.ConsumeItemId = value5;
		value.ConsumeItemType = value6;
		value.RefreshTime = value7;
		value.ExchangeInfos = value8;
		value.ShopName = shopName;
	}
}
