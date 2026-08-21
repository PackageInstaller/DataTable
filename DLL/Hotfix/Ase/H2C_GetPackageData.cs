using System.Collections.Generic;
using System.Runtime.CompilerServices;
using GameFramework.Network;
using MemoryPack;
using MemoryPack.Formatters;
using MemoryPack.Internal;

namespace Ase;

[Message(10036)]
[MemoryPackable(GenerateType.Object)]
public class H2C_GetPackageData : MessageObject, IActorLocationResponse, IActorResponse, IResponse, IMessage, IMemoryPackable<H2C_GetPackageData>, IMemoryPackFormatterRegister
{
	[Preserve]
	private sealed class H2C_GetPackageDataFormatter : MemoryPackFormatter<H2C_GetPackageData>
	{
		[Preserve]
		public override void Serialize(ref MemoryPackWriter writer, ref H2C_GetPackageData value)
		{
			H2C_GetPackageData.Serialize(ref writer, ref value);
		}

		[Preserve]
		public override void Deserialize(ref MemoryPackReader reader, ref H2C_GetPackageData value)
		{
			H2C_GetPackageData.Deserialize(ref reader, ref value);
		}
	}

	[MemoryPackOrder(89)]
	public int RpcId { get; set; }

	[MemoryPackOrder(90)]
	public int Error { get; set; }

	[MemoryPackOrder(91)]
	public string Message { get; set; }

	[MemoryPackOrder(0)]
	public List<PbItem> Items { get; set; } = new List<PbItem>();

	[MemoryPackOrder(1)]
	public List<PbItem> CumulativeItems { get; set; } = new List<PbItem>();

	[MemoryPackOrder(2)]
	public List<PbExpireItem> ExpireItems { get; set; } = new List<PbExpireItem>();

	[MemoryPackOrder(3)]
	public List<PbExpireItem> AlreadyExpiredItems { get; set; } = new List<PbExpireItem>();

	[MemoryPackOrder(4)]
	public List<PbDropThing> Emergency1 { get; set; } = new List<PbDropThing>();

	[MemoryPackOrder(5)]
	public List<PbDropThing> Emergency2 { get; set; } = new List<PbDropThing>();

	public static H2C_GetPackageData Create(bool isFromPool = true)
	{
		if (isFromPool)
		{
			return Singleton<ObjectPool>.Instance.Fetch(typeof(H2C_GetPackageData)) as H2C_GetPackageData;
		}
		return new H2C_GetPackageData();
	}

	public override void Dispose()
	{
		if (base.IsFromPool)
		{
			RpcId = 0;
			Error = 0;
			Message = null;
			Items.Clear();
			CumulativeItems.Clear();
			ExpireItems.Clear();
			AlreadyExpiredItems.Clear();
			Emergency1.Clear();
			Emergency2.Clear();
			Singleton<ObjectPool>.Instance.Recycle(this);
		}
	}

	static H2C_GetPackageData()
	{
		RegisterFormatter();
	}

	[Preserve]
	public static void RegisterFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_GetPackageData>())
		{
			MemoryPackFormatterProvider.Register(new H2C_GetPackageDataFormatter());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<H2C_GetPackageData[]>())
		{
			MemoryPackFormatterProvider.Register(new ArrayFormatter<H2C_GetPackageData>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbItem>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbItem>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbExpireItem>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbExpireItem>());
		}
		if (!MemoryPackFormatterProvider.IsRegistered<List<PbDropThing>>())
		{
			MemoryPackFormatterProvider.Register(new ListFormatter<PbDropThing>());
		}
	}

	[Preserve]
	public static void Serialize(ref MemoryPackWriter writer, ref H2C_GetPackageData? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<bool>(10, value.IsFromPool);
		List<PbItem> source = value.Items;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		source = value.CumulativeItems;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source));
		List<PbExpireItem> source2 = value.ExpireItems;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source2));
		source2 = value.AlreadyExpiredItems;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source2));
		List<PbDropThing> source3 = value.Emergency1;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source3));
		source3 = value.Emergency2;
		ListFormatter.SerializePackable(ref writer, ref Unsafe.AsRef(in source3));
		writer.WriteUnmanaged<int, int>(value.RpcId, value.Error);
		writer.WriteString(value.Message);
	}

	[Preserve]
	public static void Deserialize(ref MemoryPackReader reader, ref H2C_GetPackageData? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		bool value2;
		List<PbItem> value3;
		List<PbItem> value4;
		List<PbExpireItem> value5;
		List<PbExpireItem> value6;
		List<PbDropThing> value7;
		List<PbDropThing> value8;
		int value9;
		int value10;
		string message;
		if (memberCount == 10)
		{
			if (value != null)
			{
				value2 = value.IsFromPool;
				value3 = value.Items;
				value4 = value.CumulativeItems;
				value5 = value.ExpireItems;
				value6 = value.AlreadyExpiredItems;
				value7 = value.Emergency1;
				value8 = value.Emergency2;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
				reader.ReadUnmanaged<bool>(out value2);
				ListFormatter.DeserializePackable(ref reader, ref value3);
				ListFormatter.DeserializePackable(ref reader, ref value4);
				ListFormatter.DeserializePackable(ref reader, ref value5);
				ListFormatter.DeserializePackable(ref reader, ref value6);
				ListFormatter.DeserializePackable(ref reader, ref value7);
				ListFormatter.DeserializePackable(ref reader, ref value8);
				reader.ReadUnmanaged<int>(out value9);
				reader.ReadUnmanaged<int>(out value10);
				message = reader.ReadString();
				goto IL_0224;
			}
			reader.ReadUnmanaged<bool>(out value2);
			value3 = ListFormatter.DeserializePackable<PbItem>(ref reader);
			value4 = ListFormatter.DeserializePackable<PbItem>(ref reader);
			value5 = ListFormatter.DeserializePackable<PbExpireItem>(ref reader);
			value6 = ListFormatter.DeserializePackable<PbExpireItem>(ref reader);
			value7 = ListFormatter.DeserializePackable<PbDropThing>(ref reader);
			value8 = ListFormatter.DeserializePackable<PbDropThing>(ref reader);
			reader.ReadUnmanaged<int, int>(out value9, out value10);
			message = reader.ReadString();
		}
		else
		{
			if (memberCount > 10)
			{
				MemoryPackSerializationException.ThrowInvalidPropertyCount(typeof(H2C_GetPackageData), 10, memberCount);
				return;
			}
			if (value == null)
			{
				value2 = false;
				value3 = null;
				value4 = null;
				value5 = null;
				value6 = null;
				value7 = null;
				value8 = null;
				value9 = 0;
				value10 = 0;
				message = null;
			}
			else
			{
				value2 = value.IsFromPool;
				value3 = value.Items;
				value4 = value.CumulativeItems;
				value5 = value.ExpireItems;
				value6 = value.AlreadyExpiredItems;
				value7 = value.Emergency1;
				value8 = value.Emergency2;
				value9 = value.RpcId;
				value10 = value.Error;
				message = value.Message;
			}
			if (memberCount != 0)
			{
				reader.ReadUnmanaged<bool>(out value2);
				if (memberCount != 1)
				{
					ListFormatter.DeserializePackable(ref reader, ref value3);
					if (memberCount != 2)
					{
						ListFormatter.DeserializePackable(ref reader, ref value4);
						if (memberCount != 3)
						{
							ListFormatter.DeserializePackable(ref reader, ref value5);
							if (memberCount != 4)
							{
								ListFormatter.DeserializePackable(ref reader, ref value6);
								if (memberCount != 5)
								{
									ListFormatter.DeserializePackable(ref reader, ref value7);
									if (memberCount != 6)
									{
										ListFormatter.DeserializePackable(ref reader, ref value8);
										if (memberCount != 7)
										{
											reader.ReadUnmanaged<int>(out value9);
											if (memberCount != 8)
											{
												reader.ReadUnmanaged<int>(out value10);
												if (memberCount != 9)
												{
													message = reader.ReadString();
													_ = 10;
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
				goto IL_0224;
			}
		}
		value = new H2C_GetPackageData
		{
			IsFromPool = value2,
			Items = value3,
			CumulativeItems = value4,
			ExpireItems = value5,
			AlreadyExpiredItems = value6,
			Emergency1 = value7,
			Emergency2 = value8,
			RpcId = value9,
			Error = value10,
			Message = message
		};
		return;
		IL_0224:
		value.IsFromPool = value2;
		value.Items = value3;
		value.CumulativeItems = value4;
		value.ExpireItems = value5;
		value.AlreadyExpiredItems = value6;
		value.Emergency1 = value7;
		value.Emergency2 = value8;
		value.RpcId = value9;
		value.Error = value10;
		value.Message = message;
	}
}
